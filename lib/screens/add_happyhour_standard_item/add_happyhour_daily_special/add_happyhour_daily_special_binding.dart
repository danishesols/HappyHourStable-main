import 'package:get/instance_manager.dart';

import '../add_happyhour_controller.dart';

class AddHappyDailySpecialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddHappyhourController());
  }
}
