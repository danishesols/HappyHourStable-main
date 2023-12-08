import 'package:get/instance_manager.dart';

import '../claim_controller.dart';

class ClaimHourBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ClaimController());
  }
}
