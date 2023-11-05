import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddedEmployeesController extends GetxController {
  final nameEmployeeController = TextEditingController();
  final emailEmployeeController = TextEditingController();
  final passAdminController = TextEditingController();

  //? FIREBASE
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> processAddData() async {
    if (passAdminController.text.isNotEmpty) {
      try {
        //^ ADMIN VERIFICATION
        String emailAdmin = auth.currentUser!.email!;
        await auth.signInWithEmailAndPassword(
          email: emailAdmin,
          password: passAdminController.text,
        );

        //^ CREATE EMPLOYEE
        UserCredential employeeCredential =
            await auth.createUserWithEmailAndPassword(
          email: emailEmployeeController.text,
          password: "karyawan", //* default password
        );

        //^ ADDED EMPLOYEE TO -> FIRESTORE DATABASE
        if (employeeCredential.user != null) {
          String userID = employeeCredential.user!.uid;

          await firestore.collection("karyawan").doc(userID).set({
            "name": nameEmployeeController.text,
            "email": emailEmployeeController.text,
            "uid": userID,
            "createdAt": DateTime.now().toIso8601String(),
          });

          //^ SEND EMAIL VERIFICATION
          await employeeCredential.user!.sendEmailVerification();

          await auth.signOut(); //* logout dari semua user

          //^ LOGIN KEMBALI SEBAGAI ADMIN
          await auth.signInWithEmailAndPassword(
            email: emailAdmin,
            password: passAdminController.text,
          );

          Get.back(); //* tutup dialog
          Get.back(); //*kembali ke home
          Get.snackbar("Yey", "Berhasil menambahkan karyawan");
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.snackbar("Ups ..", "Password terlalu lemah!");
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar("Ups ..", "Email sudah digunakan!");
        } else if (e.code == 'wrong-password') {
          Get.snackbar("Ups ..", "Password admin salah!");
        }
      } catch (e) {
        Get.snackbar("Terjadi kesalahan server!", e.toString());
      }
    } else {
      Get.snackbar("Ups ..", "Password admin tidak boleh kosong!");
    }
  }

  Future<void> addEmployees() async {
    if (nameEmployeeController.text.isNotEmpty &&
        emailEmployeeController.text.isNotEmpty) {
      Get.defaultDialog(
        title: "Validasi Admin",
        content: Column(
          children: [
            const Text("Mohon masukan password untuk validasi admin"),
            const SizedBox(height: 10.0),
            TextField(
              controller: passAdminController,
              obscureText: true,
              autocorrect: false,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Password Admin"),
              ),
            ),
            const SizedBox(height: 10.0),
          ],
        ),
        actions: [
          OutlinedButton(
            onPressed: () => Get.back(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              await processAddData();
            },
            child: const Text("Submit"),
          ),
        ],
      );
    } else {
      Get.snackbar("Ups ..", "Nama & Email tidak boleh kosong!");
    }
  }
}
