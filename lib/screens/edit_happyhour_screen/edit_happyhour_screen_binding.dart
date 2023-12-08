import 'package:get/instance_manager.dart';
import 'package:happy_hour_app/global_controller/global_general_controller.dart';

import '../checkout_claim/check_out_claim_screen_controller.dart';
import 'edit_happyhour_screen_controller.dart';

class EditHappyHourScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditHappyHourScreenController());
    Get.lazyPut(() => GlobalGeneralController());
    Get.lazyPut(() => CheckOutClaimScreenController());
  }
}
