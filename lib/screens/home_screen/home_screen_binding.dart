import 'package:get/instance_manager.dart';
import 'package:happy_hour_app/screens/home_screen/home_screen_controller.dart';

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeScreenController());
  }
}
