import 'package:get/get.dart';
import 'package:happy_hour_app/screens/packages/packages_screen_controller.dart';

class PackagesScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PackagesScreenController());
  }
}
