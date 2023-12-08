import 'package:get/instance_manager.dart';
import 'package:happy_hour_app/global_controller/global_general_controller.dart';
import 'package:happy_hour_app/screens/happyhour_filter_screen/happyhour_filter_screen_controller.dart';

class HappyHourFilterScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HappyHourFilterScreenController());
    Get.lazyPut(() => GlobalGeneralController());
  }
}
