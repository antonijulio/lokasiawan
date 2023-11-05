import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/added_employees_controller.dart';

class AddedEmployeesView extends GetView<AddedEmployeesController> {
  const AddedEmployeesView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Karyawan'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          //^ NAMA PEGAWAI
          TextField(
            controller: controller.nameEmployeeController,
            autocorrect: false,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Nama'),
            ),
          ),
          const SizedBox(height: 16.0),
          //^ EMAIL PEGAWAI
          TextField(
            controller: controller.emailEmployeeController,
            autocorrect: false,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Email'),
            ),
          ),
          const SizedBox(height: 32.0),
          //^ BUTTON INPUT
          Obx(
            () => ElevatedButton(
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  await controller.addEmployees();
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                child: controller.isLoading.isFalse
                    ? const Text("Tambah Karyawan")
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
        ],
      ),
    );
  }
}
