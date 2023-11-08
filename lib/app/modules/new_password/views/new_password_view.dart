import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/new_password_controller.dart';

class NewPasswordView extends GetView<NewPasswordController> {
  const NewPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ganti Password Baru'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          //^ NEW PASSWORD
          TextField(
            controller: controller.newPassController,
            autocorrect: false,
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Password Baru"),
            ),
          ),
          const SizedBox(height: 16.0),
          //^ INPUT BUTTON
          ElevatedButton(
            onPressed: () {
              controller.changePassword();
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text("Submit"),
            ),
          ),
        ],
      ),
    );
  }
}
