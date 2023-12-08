import 'package:get/instance_manager.dart';
import 'package:happy_hour_app/global_controller/global_general_controller.dart';

import '../claim_controller.dart';

class ClaimDrinksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ClaimController());
    Get.lazyPut(() => GlobalGeneralController());
  }
}
