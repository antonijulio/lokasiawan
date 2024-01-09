import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../routes/app_pages.dart';
import '../controllers/all_presence_controller.dart';

import 'package:syncfusion_flutter_datepicker/datepicker.dart';

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
      body: GetBuilder<AllPresenceController>(
        builder: (controller) {
          return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
            future: controller.getAllPresence(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snap.data!.docs.isEmpty || snap.data?.docs == null) {
                return Container(
                  height: 200,
                  alignment: Alignment.center,
                  child: Text(
                    "Tidak ada presensi menurut tanggal yang anda pilih",
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                    ),
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shrinkWrap: true,
                itemCount: snap.data!.docs.length,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  var presenceData = snap.data!.docs[index].data();

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
                                  // DateFormat.yMMMEd().format(
                                  //   DateTime.parse(
                                  //     presenceData['date'],
                                  //   ),
                                  // ),
                                  presenceData['date'] == null
                                      ? "-"
                                      : DateFormat.yMMMEd().format(
                                          DateTime.parse(presenceData['date'])),
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              presenceData['attendanceIn']?['currentDate'] ==
                                      null
                                  ? "-"
                                  : DateFormat.jms().format(DateTime.parse(
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
                              presenceData['attendanceOut']?['currentDate'] ==
                                      null
                                  ? "-"
                                  : DateFormat.jms().format(DateTime.parse(
                                      presenceData['attendanceOut']![
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
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.dialog(
            Dialog(
              child: Container(
                height: MediaQuery.of(context).size.height / 1.5,
                padding: const EdgeInsets.all(24),
                child: SfDateRangePicker(
                  //mulai hari senin
                  monthViewSettings: const DateRangePickerMonthViewSettings(
                    firstDayOfWeek: 1,
                  ),
                  // range ex: tgl 1-3
                  selectionMode: DateRangePickerSelectionMode.range,
                  showActionButtons: true,
                  onCancel: () => Get.back(),
                  onSubmit: (rangeDate) {
                    if (rangeDate != null) {
                      // handle jika user hanya memilih 1 tanggal
                      if ((rangeDate as PickerDateRange).endDate != null) {
                        controller.selectDate(
                          selectedstartDate: rangeDate.startDate!,
                          selectedendDate: rangeDate.endDate!,
                        );
                      }
                    }
                  },
                ),
              ),
            ),
          );
        },
        child: const Icon(Icons.filter_alt_outlined),
      ),
    );
  }
}
