import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lokasiawan/app/routes/app_pages.dart';

class AddedEmployeesController extends GetxController {
  final nameEmployeeController = TextEditingController();
  final emailEmployeeController = TextEditingController();

  //? FIREBASE
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addEmployees() async {
    if (nameEmployeeController.text.isNotEmpty &&
        emailEmployeeController.text.isNotEmpty) {
      try {
        //^ CREATE EMPLOYEE
        UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
          email: emailEmployeeController.text,
          password: "karyawan", //* default password
        );

        //^ ADDED EMPLOYEE TO -> FIRESTORE DATABASE
        if (userCredential.user != null) {
          String userID = userCredential.user!.uid;

          await firestore.collection("karyawan").doc(userID).set({
            "name": nameEmployeeController.text,
            "email": emailEmployeeController.text,
            "uid": userID,
            "createdAt": DateTime.now().toIso8601String(),
          });

          userCredential.user!.sendEmailVerification();
          Get.snackbar("Yey", "Berhasil menambahkan karyawan");
          Get.offAllNamed(Routes.HOME);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.snackbar("Ups ..", "Password terlalu lemah!");
        } else if (e.code == 'email-already-in-use') {
          Get.snackbar("Ups ..", "Email sudah digunakan!");
        }
      } catch (e) {
        Get.snackbar("Terjadi kesalahan server!", e.toString());
      }
    } else {
      Get.snackbar("Ups ..", "Nama & Email tidak boleh kosong!");
    }
  }
}
