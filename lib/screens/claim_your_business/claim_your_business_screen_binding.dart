import 'package:get/instance_manager.dart';
import 'package:happy_hour_app/screens/claim_your_business/claim_your_business_screen_controller.dart';

class ClaimYourBusinessScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ClaimYourBusinessScreenController());
  }
}
