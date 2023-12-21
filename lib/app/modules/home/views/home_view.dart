import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lokasiawan/app/routes/app_pages.dart';

import '../../../controllers/page_index_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageController = Get.find<PageIndexController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: GoogleFonts.poppins(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: controller.streamUser(),
        builder: (context, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (userSnapshot.hasData) {
            Map<String, dynamic>? userData = userSnapshot.data!.data()!;
            String defAvatar =
                'https://ui-avatars.com/api/?name=${userData['name']}';

            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                const SizedBox(height: 16),
                Row(
                  children: [
                    ClipOval(
                      child: SizedBox(
                        width: 85,
                        height: 85,
                        child: Image.network(
                          userData['avatar'] ?? defAvatar,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome",
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          width: 250,
                          child: Text(
                            userData['currentAddress'] != null
                                ? "${userData['currentAddress']}"
                                : "Lokasi Tidak Ditemukan",
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 18.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userData['job'] ?? "-",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        (userData['uid'] ?? "-")
                            .toString()
                            .toUpperCase()
                            .substring(0, 14),
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                      ),
                      Text(
                        userData['name'] ?? "-",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 20.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      stream: controller.streamTodayPresence(),
                      builder: (context, todaySnapshot) {
                        if (todaySnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        Map<String, dynamic>? todayData =
                            todaySnapshot.data?.data();
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Masuk",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  todayData?['attendanceIn'] == null
                                      ? "-"
                                      : DateFormat.jms().format(DateTime.parse(
                                          todayData!['attendanceIn']
                                              ['currentDate'])),
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 2,
                              height: 40,
                              color: Colors.grey,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Keluar",
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  todayData?['attendanceOut'] == null
                                      ? "-"
                                      : DateFormat.jms().format(DateTime.parse(
                                          todayData!['attendanceOut']
                                              ['currentDate'])),
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                ),
                const SizedBox(height: 16.0),
                const Divider(thickness: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Terakhir 5 Hari Lalu",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Get.toNamed(Routes.ALL_PRESENCE),
                      child: Text(
                        "Selengkapnya",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: controller.streamLastPresence(),
                  builder: (context, presenceSnapshot) {
                    if (presenceSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (presenceSnapshot.data!.docs.isEmpty ||
                        presenceSnapshot.data?.docs == null) {
                      return Container(
                        height: 200,
                        alignment: Alignment.center,
                        child: Text(
                          "Belum ada presensi",
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: presenceSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var presenceData =
                              presenceSnapshot.data!.docs[index].data();

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              onTap: () => Get.toNamed(
                                Routes.PRESENCE_DETAILS,
                                arguments: presenceData,
                              ),
                              tileColor: Colors.grey.shade200,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              title: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Masuk",
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          // DateFormat.yMMMEd().format(
                                          //   DateTime.parse(
                                          //     presenceData['date'],
                                          //   ),
                                          // ),
                                          presenceData['date'] == null
                                              ? "-"
                                              : DateFormat.yMMMEd().format(
                                                  DateTime.parse(
                                                      presenceData['date'])),
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      presenceData['attendanceIn']
                                                  ?['currentDate'] ==
                                              null
                                          ? "-"
                                          : DateFormat.jms().format(
                                              DateTime.parse(
                                                  presenceData['attendanceIn']![
                                                      'currentDate'])),
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    const SizedBox(height: 14.0),
                                    Text(
                                      "Keluar",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      presenceData['attendanceOut']
                                                  ?['currentDate'] ==
                                              null
                                          ? "-"
                                          : DateFormat.jms().format(
                                              DateTime.parse(presenceData[
                                                      'attendanceOut']![
                                                  'currentDate'])),
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            );
          } else {
            return const Center(
              child: Text("Tidak dapat memuat data!"),
            );
          }
        },
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.fixedCircle,
        height: 70,
        activeColor: Colors.blue,
        backgroundColor: Colors.white,
        color: Colors.grey,
        items: const [
          TabItem(icon: Icons.home_filled, title: 'Home'),
          TabItem(icon: Icons.fingerprint, title: 'Absen'),
          TabItem(icon: Icons.person, title: 'Profil'),
        ],
        initialActiveIndex: pageController.initPage.value,
        onTap: (int i) => pageController.movePages(i),
      ),
    );
  }
}
