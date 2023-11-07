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
          CircleAvatar(
            child: IconButton(
              onPressed: () => Get.toNamed(Routes.PROFILE),
              icon: const Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
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
