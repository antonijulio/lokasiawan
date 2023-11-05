import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lokasiawan/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.ADDED_EMPLOYEES);
            },
            icon: const Icon(Icons.person_add_alt),
          ),
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Get.snackbar("Yey", "Berhasil Logout");
              Get.offAllNamed(Routes.LOGIN);
            },
            icon: const Icon(Icons.logout_outlined),
          ),
          const SizedBox(width: 8.0),
        ],
      ),
      body: const Center(
        child: Text(
          'Home',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
