import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lokasiawan/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  //? FIREBASE
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> loginUser() async {
    if (emailController.text.isNotEmpty && passController.text.isNotEmpty) {
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
            print(userCredential); //* print userCredential

            Get.snackbar("Yey", "Login Berhasil!");
            Get.offAllNamed(Routes.HOME);
          } else {
            Get.defaultDialog(
              title: "Email Belum Terverifikasi",
              middleText:
                  "Segera cek kembali email anda atau klik tombol dibawah!",
              actions: [
                OutlinedButton(
                  onPressed: () => Get.back(),
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
                    } catch (e) {
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

        // Get.snackbar("Yey", "Login Berhasil!");
        // Get.offAllNamed(Routes.HOME);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.snackbar(
            "Ups ..",
            "Anda belum terdaftar, silahkan hubungi Admin!",
          );
        } else if (e.code == 'wrong-password') {
          Get.snackbar("Ups ..", "Password salah!");
        }
      } catch (e) {
        Get.snackbar("Terjadi Kesalahan Server!", e.toString());
      }
    } else {
      Get.snackbar("Ups ..", "Email & Password tidak boleh kosong!");
    }
  }
}
