import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lokasiawan/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          //^ EMAIL
          TextField(
            controller: controller.emailController,
            autocorrect: false,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Email"),
            ),
          ),
          const SizedBox(height: 16.0),
          //^ PASSWORD
          TextField(
            controller: controller.passController,
            autocorrect: false,
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Password"),
            ),
          ),
          const SizedBox(height: 16.0),
          //^ INPUT BUTTON
          Obx(
            () => ElevatedButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  await controller.loginUser();
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                child: controller.isLoading.isFalse
                    ? const Text("Login")
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
          const SizedBox(height: 4.0),
          //^ lUPA PASSWORD
          TextButton(
            onPressed: () => Get.toNamed(Routes.FORGOT_PASSWORD),
            child: const Text("Lupa Password?"),
          ),
        ],
      ),
    );
  }
}
