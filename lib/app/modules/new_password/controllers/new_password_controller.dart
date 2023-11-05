import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lokasiawan/app/routes/app_pages.dart';

class NewPasswordController extends GetxController {
  final newPassController = TextEditingController();

  //? FIREBASE
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> changePassword() async {
    if (newPassController.text.isNotEmpty) {
      //^ HANDLE PENGGUNAAN PASSWORD YANG SAMA
      if (newPassController.text != 'karyawan') {
        try {
          //^ EKSEKUSI PROGRAM
          String email = auth.currentUser!.email!;
          await auth.currentUser!.updatePassword(newPassController.text);
          await auth.signOut();
          await auth.signInWithEmailAndPassword(
            email: email,
            password: newPassController.text,
          );
          Get.offAllNamed(Routes.HOME);
          Get.snackbar("Yey", "Berhasil mengganti password");
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            Get.snackbar(
              "Ups ..",
              "Password terlalu lemah, gunakan setidaknya 6 karakter!",
            );
          }
        } catch (e) {
          Get.snackbar("Terjadi Kesalahan Server!", e.toString());
        }
      } else {
        Get.snackbar(
          "Ups ..",
          "Pasword baru tidak boleh sama dengan password sebelumnya!",
        );
      }
    } else {
      Get.snackbar("Ups ..", "Pasword baru tidak boleh kosong!");
    }
  }
}
