import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();

  RxBool isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> sendEmail() async {
    if (emailController.text.isNotEmpty) {
      isLoading.value = true;
      try {
        //^ PROCESS SEND PASSWORD RESET EMAIL
        await auth.sendPasswordResetEmail(email: emailController.text);

        Get.snackbar(
          "Yey",
          "Berhasil mengirimkan link reset password, silahkan cek email anda",
        );
      } catch (e) {
        Get.snackbar("Terjadi Kesalahan Server!", e.toString());
      } finally {
        isLoading.value = false;
      }
    } else {
      Get.snackbar("Ups ..", "Email tidak boleh kosong!");
    }
  }
}
