import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../controllers/presence_details_controller.dart';

class PresenceDetailsView extends GetView<PresenceDetailsController> {
  PresenceDetailsView({Key? key}) : super(key: key);
  final Map<String, dynamic> presenceData = Get.arguments;

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
                    DateFormat.yMMMEd().format(
                      DateTime.parse(
                        presenceData['date'],
                      ),
                    ),
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
                  presenceData['attendanceIn']?['currentDate'] == null
                      ? "Jam : -"
                      : "Jam : ${DateFormat.jms().format(DateTime.parse(
                          presenceData['attendanceIn']!['currentDate'],
                        ))}",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  presenceData['attendanceIn']?['currentAddress'] == null
                      ? "Posisi : -"
                      : "Posisi : ${presenceData['attendanceIn']!['currentAddress']}",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  presenceData['attendanceIn']?['status'] == null
                      ? "Status : -"
                      : "Status : ${presenceData['attendanceIn']!['status']}",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  presenceData['attendanceIn']?['distance'] == null
                      ? "Jarak dari lokasi : - Meter"
                      : "Jarak dari lokasi : ${presenceData['attendanceIn']!['distance']}"
                          .replaceAll('meters', 'Meter'),
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  presenceData['attendanceIn']?['latitude'] != null &&
                          presenceData['attendanceIn']?['longitude'] != null
                      ? "Koordinat : ${presenceData['attendanceIn']!['latitude']}, ${presenceData['attendanceIn']!['longitude']}"
                      : "Koordinat : -",
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
                    fontSize: 20,
                  ),
                ),
                Text(
                  presenceData['attendanceOut']?['currentDate'] == null
                      ? "Jam : -"
                      : "Jam : ${DateFormat.jms().format(DateTime.parse(
                          presenceData['attendanceOut']!['currentDate'],
                        ))}",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  presenceData['attendanceOut']?['currentAddress'] == null
                      ? "Posisi : -"
                      : "Posisi : ${presenceData['attendanceOut']!['currentAddress']}",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  presenceData['attendanceOut']?['status'] == null
                      ? "Status : -"
                      : "Status : ${presenceData['attendanceOut']!['status']}",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  presenceData['attendanceOut']?['distance'] == null
                      ? "Jarak dari lokasi : - Meter"
                      : "Jarak dari lokasi : ${presenceData['attendanceOut']!['distance']}"
                          .replaceAll('meters', 'Meter'),
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  presenceData['attendanceOut']?['latitude'] != null &&
                          presenceData['attendanceOut']?['longitude'] != null
                      ? "Koordinat : ${presenceData['attendanceOut']!['latitude']}, ${presenceData['attendanceOut']!['longitude']}"
                      : "Koordinat : -",
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
