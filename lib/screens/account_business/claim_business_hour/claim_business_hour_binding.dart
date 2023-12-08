import 'package:get/get.dart';
import 'package:happy_hour_app/screens/account_business/claim_business_hour/claim_business_hour_controller.dart';

import '../../../global_controller/global_general_controller.dart';

class ClaimBusinessHourBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ClaimBusinessHourController());
    Get.lazyPut(() => GlobalGeneralController());
  }
}
