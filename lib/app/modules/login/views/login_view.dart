import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
          ElevatedButton(
            onPressed: () {
              controller.loginUser();
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text("Login"),
            ),
          ),
          const SizedBox(height: 4.0),
          //^ lUPA PASSWORD
          TextButton(
            onPressed: () {},
            child: const Text("Lupa Password?"),
          ),
        ],
      ),
    );
  }
}
