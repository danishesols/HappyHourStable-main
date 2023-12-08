import 'package:get/instance_manager.dart';
import 'package:happy_hour_app/screens/add_happyhour/add_happyhour_screen_controller.dart';

class AddHappyhourScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddHappyhourScreenController());
  }
}
