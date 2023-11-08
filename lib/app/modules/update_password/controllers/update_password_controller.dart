import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdatePasswordController extends GetxController {
  final currentPass = TextEditingController();
  final newPass = TextEditingController();
  final confirmPass = TextEditingController();

  RxBool isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> updatePassword() async {
    if (currentPass.text.isNotEmpty &&
        newPass.text.isNotEmpty &&
        confirmPass.text.isNotEmpty) {
      //^ COMPARE NEW AND CONFRIM PASSWORD
      if (newPass.text == confirmPass.text) {
        isLoading.value = true;

        //^ EKSEKUSI PROGRAM
        try {
          //^ LOGIN USER
          String email = auth.currentUser!.email!;
          await auth.signInWithEmailAndPassword(
            email: email,
            password: currentPass.text,
          );

          //^ UPDATE PASSWORD
          await auth.currentUser!.updatePassword(newPass.text);

          Get.back();
          Get.snackbar("Yey", "Berhasil mengganti password");
        } on FirebaseAuthException catch (e) {
          if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
            Get.snackbar("Ups ..", "Password lama anda salah!");
          } else {
            Get.snackbar("Terjadi Kesalahan Server!", e.toString());
          }
        } catch (e) {
          Get.snackbar("Terjadi Kesalahan Server!", e.toString());
        } finally {
          isLoading.value = false;
        }
      } else {
        isLoading.value = false;
        Get.snackbar("Ups ..", "Konfirmasi password tidak cocok!");
      }
    } else {
      isLoading.value = false;
      Get.snackbar("Ups ..", "Password tidak boleh kosong!");
    }
  }
}
