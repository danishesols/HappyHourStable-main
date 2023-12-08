import 'package:get/instance_manager.dart';

import 'find_your_happyhour_screen_controller.dart';

class BusinessFindYourHappyHourScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BusinessFindYourHappyHourScreenController());
  }
}
