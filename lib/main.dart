import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//? FIREBASE
import 'package:firebase_core/firebase_core.dart';
import 'package:lokasiawan/app/controllers/page_index_controller.dart';
import 'firebase_options.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //^ PUT PAGE CONTROLLER
  Get.put(PageIndexController(), permanent: true);

  runApp(
    StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: CircularProgressIndicator(),
            ),
          );
        }
        print(snapshot.data); //* print currentUser
        return GetMaterialApp(
          title: "Presence App",
          debugShowCheckedModeBanner: false,
          initialRoute: snapshot.data != null ? Routes.HOME : Routes.LOGIN,
          getPages: AppPages.routes,
        );
      },
    ),
  );
}
