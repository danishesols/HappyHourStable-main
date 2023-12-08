import 'package:get/instance_manager.dart';
import 'package:happy_hour_app/global_controller/auth_controller.dart';
import 'package:happy_hour_app/global_controller/global_general_controller.dart';

import 'business_happyhour_detail_screen_controller.dart';

class BusinessHappyhourDetailScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BusinessHappyhourDetailScreenController());
    Get.lazyPut(() => GlobalGeneralController());
    Get.lazyPut(() => AuthController());
  }
}
