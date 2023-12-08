import 'package:get/get.dart';
import 'package:happy_hour_app/screens/account_business/add_for_guest/guest_controller.dart';

class GuestFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GuestController());
  }
}
