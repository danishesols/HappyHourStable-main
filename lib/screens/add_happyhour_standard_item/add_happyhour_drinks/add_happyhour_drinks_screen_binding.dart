import 'package:get/instance_manager.dart';
import 'package:happy_hour_app/global_controller/global_general_controller.dart';

import '../add_happyhour_controller.dart';

class AddHappyHOurDrinksScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddHappyhourController());
    Get.lazyPut(() => GlobalGeneralController());
  }
}
