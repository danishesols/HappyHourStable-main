import 'package:get/instance_manager.dart';
import 'package:happy_hour_app/screens/happyhour_map_screen.dart/happyhour_map_screen_controller.dart';

class HappyHourMapScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HappyHourMapScreenController());
  }
}
