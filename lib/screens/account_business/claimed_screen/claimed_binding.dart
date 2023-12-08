import 'package:get/instance_manager.dart';
import 'package:happy_hour_app/screens/account_business/claimed_screen/claimed_controller.dart';

class ClaimedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ClaimedController());
  }
}
