import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lokasiawan/app/routes/app_pages.dart';
import 'package:geocoding/geocoding.dart';

class PageIndexController extends GetxController {
  RxInt initPage = 0.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void movePages(int index) async {
    switch (index) {
      //^ PRESENCE SCREEN
      case 1:
        Map<String, dynamic> responseData = await determinePosition();

        if (responseData['error'] != true) {
          //^ KONVERSI TITIK KOORDINAT KE BENTUK ALAMAT
          Position position = responseData['position'];
          List<Placemark> placemarks = await placemarkFromCoordinates(
              position.latitude, position.longitude);
          String currentAddress =
              "${placemarks[0].thoroughfare}, ${placemarks[0].subLocality}, ${placemarks[0].locality}, ${placemarks[0].subAdministrativeArea}";

          //^ UPDATE POSITION IN FIRESTORE
          updatePosition(position, currentAddress);

          //^ PRESENCE
          presence(position, currentAddress);

          Get.snackbar("Yey", "Berhasil Melakukan Presensi");
        } else {
          Get.snackbar(
            "Terjadi Kesalahan!",
            "Silahkan buka pengaturan untuk mengaktifkan lokasi",
          );
        }
        break;

      //^ PROFILE SCREEN
      case 2:
        Get.offAllNamed(Routes.PROFILE);
        initPage.value = index;
        break;

      //^ HOME SCREEN
      default:
        initPage.value = index;
        Get.offAllNamed(Routes.HOME);
    }
  }

  //^ GET LATITUDE - LONGITUDE
  Future<Map<String, dynamic>> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.

      return {
        "message": "Tidak dapat mengambil lokasi pada device ini",
        "error": true,
      };
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.

        return {
          "message": "Izin lokasi ditolak!",
          "error": true,
        };
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.

      return {
        "message":
            "Lokasiawan membutuhkan lokasi device kamu!, segera masuk ke Pengaturan > Lokasi",
        "error": true,
      };
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position currentPosition = await Geolocator.getCurrentPosition();
    return {
      "position": currentPosition,
      "message": "Berhasil mendapatkan posisi device",
      "error": false,
    };
  }

  //^ UPDATE POSITION IN FIRESTORE
  Future<void> updatePosition(Position position, String currentAddress) async {
    String userID = auth.currentUser!.uid;

    await firestore.collection("karyawan").doc(userID).update({
      "lastPosition": {
        "latitude": position.latitude,
        "longitude": position.longitude,
      },
      "currentAddress": currentAddress,
    });
  }

  Future<void> presence(Position position, String currentAddress) async {
    String userID = auth.currentUser!.uid;

    //^ CREATE A NEW PRESENCE DOCUMENT FOR EACH USER ID
    CollectionReference<Map<String, dynamic>> presenceCollection =
        firestore.collection("karyawan").doc(userID).collection("presence");

    //^ GET PRESENCE DATA COLLECTION ON THE USER ID
    QuerySnapshot<Map<String, dynamic>> presenceSnapshot =
        await presenceCollection.get();

    DateTime currentDate = DateTime.now();

    //^ PRESENCE DOCUMENT NAME
    String presenceDocumentID =
        DateFormat.yMd().format(currentDate).replaceAll("/", "-");

    if (presenceSnapshot.docs.isEmpty) {
      presenceCollection.doc(presenceDocumentID).set({
        "date": currentDate.toIso8601String(),
        "attendanceIn": {
          "currentDate": currentDate.toIso8601String(),
          "latitude": position.latitude,
          "longitude": position.longitude,
          "currentAddress": currentAddress,
          "status": "Dalam Area",
        }
      });
    } else {}
  }
}
