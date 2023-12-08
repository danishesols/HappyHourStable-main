import 'package:get/instance_manager.dart';

import '../add_happyhour_controller.dart';

class AddHappyHourBarTypeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddHappyhourController());
  }
}
