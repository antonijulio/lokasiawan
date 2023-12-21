import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lokasiawan/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';

class ProfileContent extends GetView<ProfileController> {
  const ProfileContent({
    super.key,
    required this.userData,
  });

  final Map<String, dynamic> userData;

  @override
  Widget build(BuildContext context) {
    String defAvatar = 'https://ui-avatars.com/api/?name=${userData['name']}';

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const SizedBox(height: 24.0),
        //^ PROFILE PHOTO
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: SizedBox(
                width: 100,
                height: 100,
                child: Image.network(
                  userData['avatar'] != null
                      ? userData['avatar'] != ""
                          ? userData['avatar']
                          : defAvatar
                      : defAvatar,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
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
