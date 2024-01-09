import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/update_password_controller.dart';

class UpdatePasswordView extends GetView<UpdatePasswordController> {
  const UpdatePasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Password'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 8.0),
          //^ OLD PASSWORD
          TextField(
            controller: controller.currentPass,
            autocorrect: false,
            obscureText: true,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              label: Text(
                'Password Lama',
                style: GoogleFonts.poppins(),
              ),
            ),
            style: GoogleFonts.poppins(),
          ),
          const SizedBox(height: 12.0),
          //^ NEW PASSWORD
          TextField(
            controller: controller.newPass,
            autocorrect: false,
            obscureText: true,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              label: Text(
                'Password Baru',
                style: GoogleFonts.poppins(),
              ),
            ),
            style: GoogleFonts.poppins(),
          ),
          const SizedBox(height: 12.0),
          //^ CONFIRM PASSWORD
          TextField(
            controller: controller.confirmPass,
            autocorrect: false,
            obscureText: true,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              label: Text(
                'Konfirmasi Password',
                style: GoogleFonts.poppins(),
              ),
            ),
            style: GoogleFonts.poppins(),
          ),
          const SizedBox(height: 16.0),
          Obx(
            () => ElevatedButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  await controller.updatePassword();
                }
              },
              child: controller.isLoading.isFalse
                  ? Text(
                      "Update Password",
                      style: GoogleFonts.poppins(),
                    )
                  : const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
