import 'package:get/instance_manager.dart';
import 'package:happy_hour_app/screens/map_argument_screen/map_controller.dart';

class MapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MapController());
  }
}
