import 'package:get/instance_manager.dart';
import 'package:happy_hour_app/screens/find_your_happyhour_screen/find_your_happyhour_screen_controller.dart';

class FindYourHappyHourScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FindYourHappyHourScreenController());
  }
}
