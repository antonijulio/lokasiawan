import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../routes/app_pages.dart';
import '../controllers/all_presence_controller.dart';

class AllPresenceView extends GetView<AllPresenceController> {
  const AllPresenceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Semua Presensi'),
        titleTextStyle: GoogleFonts.poppins(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
          weight: 3,
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              elevation: 6,
              child: TextField(
                controller: null,
                autocorrect: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  hintText: "Cari Riwayat Absen",
                  hintStyle: GoogleFonts.poppins(),
                  suffixIcon: const Icon(Icons.search),
                ),
              ),
            ),
          ),
          ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shrinkWrap: true,
            itemCount: 10,
            physics: const ScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  onTap: () => Get.toNamed(Routes.PRESENCE_DETAILS),
                  tileColor: Colors.grey.shade200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Masuk",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              DateFormat.yMMMEd().format(DateTime.now()),
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          DateFormat.jms().format(DateTime.now()),
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
                          DateFormat.jms().format(DateTime.now()),
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
          ),
        ],
      ),
    );
  }
}
