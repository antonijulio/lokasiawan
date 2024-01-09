import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AllPresenceController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  DateTime? startDate; //kemungkinan null
  DateTime? endDate = DateTime.now();

  Future<QuerySnapshot<Map<String, dynamic>>> getAllPresence() async {
    String userID = auth.currentUser!.uid;

    ///* Jika startDate (tanggal mulai yang dipilih) == null
    /// maka hanya SATU kriteria pencarian yang akan digunakan:
    /// yaitu isLessThan endDate akan mengambil semua data presensi
    /// yang memiliki tanggal kurang dari endDate
    ///
    /// get seluruh presensi saat ini -> karena HANYA memilih tanggal awal
    /// tanpa memilih tanggal akhir
    if (startDate == null) {
      return await firestore
          .collection("karyawan")
          .doc(userID)
          .collection("presence")
          .where("date", isLessThan: endDate!.toIso8601String())
          .orderBy("date", descending: true)
          .get();

      ///* Jika startDate (tanggal mulai yang dipilih) != null
      /// maka ada DUA kriteria pencarian yang akan digunakan:
      /// 1 isLessThan startDate untuk membatasi tanggal sebelum startDate
      /// 2 isLessThan endDate untuk memastikan tanggal juga kurang dari endDate
    } else {
      return await firestore
          .collection("karyawan")
          .doc(userID)
          .collection("presence")
          .where("date", isGreaterThan: startDate!.toIso8601String())
          .where(
            "date",
            isLessThan: endDate!
                .add(
                  const Duration(days: 1),
                )
                .toIso8601String(),
          )
          .orderBy("date", descending: true)
          .get();
    }
  }

  void selectDate({
    required DateTime? selectedstartDate,
    required DateTime selectedendDate,
  }) {
    // selectedstartDate = startDate;
    // selectedendDate = endDate;
    startDate = selectedstartDate;
    endDate = selectedendDate;
    if (kDebugMode) {
      print("START DATE $startDate");
      print("END DATE $endDate");
    }
    update();
    Get.back();
  }
}
