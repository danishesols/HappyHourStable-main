import 'package:get/instance_manager.dart';
import 'package:happy_hour_app/global_controller/global_general_controller.dart';
import 'package:happy_hour_app/screens/checkout/check_out_screen_controller.dart';

class CheckOutScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CheckOutScreenController());
    Get.lazyPut(() => GlobalGeneralController());
  }
}
