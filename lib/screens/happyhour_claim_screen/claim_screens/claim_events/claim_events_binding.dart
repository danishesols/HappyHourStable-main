import 'package:get/instance_manager.dart';
import 'package:happy_hour_app/global_controller/auth_controller.dart';

import '../claim_controller.dart';

class ClaimEventsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ClaimController());
    Get.lazyPut(() => AuthController());
  }
}
