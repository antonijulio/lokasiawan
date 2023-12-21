import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../controllers/page_index_controller.dart';
import '../components/profile_content.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageController = Get.find<PageIndexController>();

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Profil'),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: controller.streamUser(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snap.hasData) {
              Map<String, dynamic> userData = snap.data!.data()!;
              return ProfileContent(
                userData: userData,
              );
            } else {
              return const Center(
                child: Text("Tidak dapat memuat data user"),
              );
            }
          },
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.fixedCircle,
        height: 70,
        activeColor: Colors.blue,
        backgroundColor: Colors.white,
        color: Colors.grey,
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
