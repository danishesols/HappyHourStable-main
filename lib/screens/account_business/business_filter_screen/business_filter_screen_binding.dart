import 'package:get/instance_manager.dart';
import 'package:happy_hour_app/global_controller/global_general_controller.dart';

import 'business_filter_screen_controller.dart';

class BusinessFilterScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BusinessFilterScreenController());
    Get.lazyPut(() => GlobalGeneralController());
  }
}
