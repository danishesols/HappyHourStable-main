import 'package:get/instance_manager.dart';
import 'package:happy_hour_app/screens/claim_this_business/claim_this_business_controller.dart';

class ClaimThisBusinessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ClaimThisBusinessController());
  }
}
