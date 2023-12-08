import 'package:get/instance_manager.dart';
import 'package:happy_hour_app/screens/account_standard/standard_find_your_happyhour/find_your_happyhour_standard_controller.dart';

class FindYourHappyHourScreenBindingStandard extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FindYourHappyHourStandardController());
  }
}
