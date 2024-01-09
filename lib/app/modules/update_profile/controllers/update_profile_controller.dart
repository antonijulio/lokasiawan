import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;

class UpdateProfileController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  RxBool isLoading = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  //? fs = FIREBASE STORAGE
  fs.FirebaseStorage storage = fs.FirebaseStorage.instance;

  final ImagePicker picker = ImagePicker();

  XFile? image;

  Future<void> updateProfile(String userID) async {
    isLoading.value = true;
    if (nameController.text.isNotEmpty && emailController.text.isNotEmpty) {
      try {
        Map<String, dynamic> userData = {
          "name": nameController.text,
        };

        //^ UPLOAD PROFILE PHOTO
        if (image != null) {
          File file = File(image!.path);
          //? ext = extention[.jpg, .png, dll]
          String ext = image!.name.split('.').last;

          await storage.ref('$userID/avatar.$ext').putFile(file);
          String avatarUrl =
              await storage.ref('$userID/avatar.$ext').getDownloadURL();

          userData.addAll({"avatar": avatarUrl});
        }

        //^ UPDATE USER NAME
        await firestore.collection("karyawan").doc(userID).update(userData);

        image = null;

        Get.back();
        Get.snackbar("Yey", "Profil anda berhasil di ubah");
      } catch (e) {
        Get.snackbar("Terjadi Kesalahan Server!", e.toString());
      } finally {
        isLoading.value = false;
      }
    } else {
      isLoading.value = false;
      Get.snackbar("Ups", "Email & Nama tidak boleh kosong!");
    }
  }

  void pickImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    update();
  }

  void deleteAvatar(String userID) async {
    isLoading.value = true;
    try {
      firestore.collection("karyawan").doc(userID).update({
        "avatar": FieldValue.delete(),
      });

      Get.back();
      Get.snackbar("Yey", "Foto profil berhasil dihapus");
    } catch (e) {
      Get.snackbar("Terjadi Kesalahan Server!", e.toString());
    } finally {
      isLoading.value = false;
      update();
    }
  }
}
