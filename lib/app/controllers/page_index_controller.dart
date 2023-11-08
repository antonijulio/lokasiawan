import 'package:get/get.dart';
import 'package:lokasiawan/app/routes/app_pages.dart';

class PageIndexController extends GetxController {
  RxInt initPage = 0.obs;

  void movePages(int index) {
    switch (index) {
      case 1:
        //comming soon
        print("halaman absen");
        break;
      case 2:
        Get.offAllNamed(Routes.PROFILE);
        initPage.value = index;
        break;
      default:
        initPage.value = index;
        Get.offAllNamed(Routes.HOME);
    }
  }
}
