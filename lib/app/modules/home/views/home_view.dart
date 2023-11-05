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
          const SizedBox(width: 4),
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.ADDED_EMPLOYEES);
            },
            icon: const Icon(Icons.person_add_alt),
          ),
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
