import 'package:get/instance_manager.dart';
import 'package:happy_hour_app/global_controller/auth_controller.dart';
import 'package:happy_hour_app/screens/account_business/add_for_guest/guest_controller.dart';

class GuestEventsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GuestController());
    Get.lazyPut(() => AuthController());
  }
}
