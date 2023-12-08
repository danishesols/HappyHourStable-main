import 'package:get/get.dart';

import 'claim_screens/claim_controller.dart';

class HappyHourClaimBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ClaimController());
  }
}
