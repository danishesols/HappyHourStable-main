import 'package:get/instance_manager.dart';

import '../claim_controller.dart';

class ClaimAmenitiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ClaimController());
  }
}
