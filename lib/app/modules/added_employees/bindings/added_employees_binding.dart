import 'package:get/get.dart';

import '../controllers/added_employees_controller.dart';

class AddedEmployeesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddedEmployeesController>(
      () => AddedEmployeesController(),
    );
  }
}
