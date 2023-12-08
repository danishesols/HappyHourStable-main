import 'package:get/instance_manager.dart';
import 'package:happy_hour_app/screens/started_screen/started_screen_controller.dart';

class StartedScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StartedScreenController());
  }
}
