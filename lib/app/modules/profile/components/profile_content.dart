import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokasiawan/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({
    super.key,
    required this.userData,
    required this.controller,
  });

  final Map<String, dynamic> userData;
  final ProfileController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const SizedBox(height: 24.0),
        //^ PROFILE PHOTO
        CircleAvatar(
          maxRadius: 50.0,
          child: Text(
            "${userData['name'][0]}".toUpperCase(),
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 38,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        //^ DISPLAY NAME
        Align(
          alignment: Alignment.center,
          child: Text(
            "${userData['name']}".toUpperCase(),
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        //^ DISPLAY EMAIL
        Align(
          alignment: Alignment.center,
          child: Text(
            userData['email'],
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 4.0),
        const Divider(thickness: 2),
        //^ UPDATE PROFILE
        ListTile(
          leading: const Icon(
            Icons.person,
            color: Colors.black,
          ),
          title: Text(
            "Update Profile",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          tileColor: Colors.blueGrey.shade50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          onTap: () => Get.toNamed(
            Routes.UPDATE_PROFILE,
            arguments: userData,
          ),
        ),
        const SizedBox(height: 4.0),
        //^ UPDATE PASSWORD
        ListTile(
          leading: const Icon(
            Icons.key,
            color: Colors.black,
          ),
          title: Text(
            "Update Password",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          tileColor: Colors.blueGrey.shade50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          onTap: () => Get.toNamed(Routes.UPDATE_PASSWORD),
        ),
        //^ IF ADMIN == GET ADD EMPLOYEE
        if (userData['role'] == 'admin')
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: ListTile(
              leading: const Icon(
                Icons.person_add_alt_1,
                color: Colors.black,
              ),
              title: Text(
                "Tambah Karyawan",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              tileColor: Colors.blueGrey.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              onTap: () => Get.toNamed(Routes.ADDED_EMPLOYEES),
            ),
          ),
        const SizedBox(height: 4.0),
        //^ SIGN OUT
        ListTile(
          leading: const Icon(
            Icons.power_settings_new_outlined,
            color: Colors.black,
          ),
          title: Text(
            "Logout",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          tileColor: Colors.blueGrey.shade50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          onTap: () => controller.signOut(),
        ),
      ],
    );
  }
}
