import 'package:get/instance_manager.dart';

import '../claim_controller.dart';

class ClaimDaytTimeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ClaimController());
  }
}
