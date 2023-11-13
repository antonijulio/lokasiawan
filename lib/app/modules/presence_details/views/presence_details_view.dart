import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../controllers/presence_details_controller.dart';

class PresenceDetailsView extends GetView<PresenceDetailsController> {
  const PresenceDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Presensi'),
        titleTextStyle: GoogleFonts.poppins(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
          weight: 3,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    DateFormat.yMMMEd().format(DateTime.now()),
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Masuk",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "Jam : ${DateFormat.jms().format(DateTime.now())}",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  "Posisi : -6.984574606000466, 110.40375576658954",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  "Status : ",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Keluar",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "Jam : ${DateFormat.jms().format(DateTime.now())}",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  "Posisi : -6.984574606000466, 110.40375576658954",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  "Status : ",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
