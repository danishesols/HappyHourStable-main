import 'package:get/instance_manager.dart';
import 'package:happy_hour_app/global_controller/auth_controller.dart';
import 'package:happy_hour_app/global_controller/global_general_controller.dart';

import 'standard_happyhour_detail_screen_controller.dart';

class StandardHappyhourDetailScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StandardHappyhourDetailScreenController());
    Get.lazyPut(() => GlobalGeneralController());
    Get.lazyPut(() => AuthController());
  }
}
