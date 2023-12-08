import 'package:get/get.dart';
import 'package:happy_hour_app/global_controller/global_general_controller.dart';
import 'package:happy_hour_app/screens/account_business/add_for_guest/guest_controller.dart';

class GuestFoodItemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GuestController());
    Get.lazyPut(() => GlobalGeneralController());
  }
}
