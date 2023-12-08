import 'package:get/instance_manager.dart';
import 'package:happy_hour_app/global_controller/auth_controller.dart';

import '../addhappyhour_business_controller.dart';

class BusinessEventsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddHappyhourBusinessController());
    Get.lazyPut(() => AuthController());
  }
}
