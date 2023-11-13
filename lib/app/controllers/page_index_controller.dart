import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:lokasiawan/app/routes/app_pages.dart';

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
          Position position = responseData['position'];
          updatePosition(position);
          Get.defaultDialog(
            middleText: "${position.latitude}, ${position.longitude}",
          );
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

  Future<Map<String, dynamic>> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      // return Future.error('Location services are disabled.');
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
        // return Future.error('Location permissions are denied');
        return {
          "message": "Izin lokasi ditolak!",
          "error": true,
        };
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      // return Future.error(
      //   'Location permissions are permanently denied, we cannot request permissions.',
      // );

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

  Future<void> updatePosition(Position position) async {
    String userID = auth.currentUser!.uid;

    await firestore.collection("karyawan").doc(userID).update({
      "last_position": {
        "latitude": position.latitude,
        "longitude": position.longitude,
      }
    });
  }
}
