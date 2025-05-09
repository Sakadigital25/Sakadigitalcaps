import 'package:get/get.dart';
import '../../login/controllers/auth_controller.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  void logout() {
    Get.find<AuthController>().logout();
    selectedIndex.value = 0;
  }
}
