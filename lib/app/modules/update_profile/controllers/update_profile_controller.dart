import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  RxBool isLoading = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final ImagePicker picker = ImagePicker();

  XFile? image;

  Future<void> updateProfile(String userID) async {
    isLoading.value = true;
    if (nameController.text.isNotEmpty && emailController.text.isNotEmpty) {
      try {
        //^ UPDATE USER NAME
        await firestore.collection("karyawan").doc(userID).update({
          "name": nameController.text,
        });

        Get.back();
        Get.snackbar("Yey", "Berhasil mengubah nama");
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

    if (image != null) {
    } else {}
    update();
  }
}
