import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

import '../../../controllers/page_index_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageController = Get.find<PageIndexController>();

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Home'),
      //   centerTitle: true,
      // ),
      body: const SafeArea(
        child: Center(
          child: Text(
            'Home',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.fixedCircle,
        height: 70,
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.fingerprint, title: 'Absen'),
          TabItem(icon: Icons.person, title: 'Profil'),
        ],
        initialActiveIndex: pageController.initPage.value,
        onTap: (int i) => pageController.movePages(i),
      ),
    );
  }
}
