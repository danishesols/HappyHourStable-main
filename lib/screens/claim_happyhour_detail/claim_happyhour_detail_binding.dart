import 'package:get/instance_manager.dart';
import 'package:happy_hour_app/global_controller/global_general_controller.dart';
import 'package:happy_hour_app/screens/claim_happyhour_detail/claim_happyhour_detail_controller.dart';

class ClaimHappyHourDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ClaimHappyHourDetailController());
    Get.lazyPut(() => GlobalGeneralController());
  }
}
