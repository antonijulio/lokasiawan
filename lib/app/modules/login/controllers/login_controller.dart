import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lokasiawan/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  RxBool isLoading = false.obs;

  //? FIREBASE
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> loginUser() async {
    if (emailController.text.isNotEmpty && passController.text.isNotEmpty) {
      isLoading.value = true;
      try {
        //^ LOGIN USER
        // ignore: unused_local_variable
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passController.text,
        );

        //^ EMAIL VERIFICATION CHECK
        if (userCredential.user != null) {
          if (userCredential.user!.emailVerified == true) {
            isLoading.value = false;

            //^ CHANGE PASSWORD! IF PASSWORD == 'KARYAWAN'
            if (passController.text == 'karyawan') {
              Get.snackbar(
                "Ganti Password",
                "Silahkan ganti password anda terlebih dahulu!",
              );
              Get.offAllNamed(Routes.NEW_PASSWORD);
            } else {
              Get.snackbar("Yey", "Login Berhasil!");
              Get.offAllNamed(Routes.HOME);
            }
          } else {
            Get.defaultDialog(
              title: "Email Belum Terverifikasi",
              middleText:
                  "Segera cek kembali email anda atau klik tombol dibawah!",
              actions: [
                OutlinedButton(
                  onPressed: () {
                    isLoading.value = false;
                    Get.back();
                  },
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await userCredential.user!.sendEmailVerification();
                      Get.back();
                      Get.snackbar(
                        "Yey",
                        "Berhasil kirim ulang email verifikasi, silahkan cek kembali email anda!",
                      );
                      isLoading.value = false;
                    } catch (e) {
                      isLoading.value = false;
                      Get.snackbar(
                        "Terjadi Kesalahan Server!",
                        e.toString(),
                      );
                    }
                  },
                  child: const Text("Kirim Ulang Email"),
                ),
              ],
            );
          }
        }

        isLoading.value = false;
        // Get.snackbar("Yey", "Login Berhasil!");
        // Get.offAllNamed(Routes.HOME);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          isLoading.value = false;
          Get.snackbar(
            "Ups ..",
            "Anda belum terdaftar, silahkan hubungi Admin!",
          );
        } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
          isLoading.value = false;
          Get.snackbar("Ups ..", "Email & Password salah!");
        }
      } catch (e) {
        isLoading.value = false;
        Get.snackbar("Terjadi Kesalahan Server!", e.toString());
      }
    } else {
      Get.snackbar("Ups ..", "Email & Password tidak boleh kosong!");
    }
  }
}
