import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUser() async* {
    String userID = auth.currentUser!.uid;

    yield* firestore.collection("karyawan").doc(userID).snapshots();
  }

  Future<void> signOut() async {
    await auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
    Get.snackbar("Yey", "Berhasil Logout");
  }
}
