import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  UpdateProfileView({Key? key}) : super(key: key);

  //^ ARGUMENTS
  final userData = Get.arguments;

  @override
  Widget build(BuildContext context) {
    //^ SET TEXTFIELD VALUE
    controller.nameController.text = userData['name'];
    controller.emailController.text = userData['email'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update Profile',
          style: GoogleFonts.poppins(),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          //^ EMAIL PEGAWAI
          TextField(
            controller: controller.emailController,
            autocorrect: false,
            readOnly: true, //* read only
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              label: const Text('Email'),
              helperText: "Maaf email tidak dapat di ubah",
              helperStyle: GoogleFonts.poppins(color: Colors.red),
            ),
            style: GoogleFonts.poppins(),
          ),
          const SizedBox(height: 16.0),
          //^ NAMA PEGAWAI
          TextField(
            controller: controller.nameController,
            autocorrect: false,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Nama'),
            ),
            style: GoogleFonts.poppins(),
          ),
          const SizedBox(height: 32.0),
          //^ BUTTON INPUT
          Obx(
            () => ElevatedButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  await controller.updateProfile(userData['uid']);
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                child: controller.isLoading.isFalse
                    ? Text(
                        "Update",
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
          ),
        ],
      ),
    );
  }
}