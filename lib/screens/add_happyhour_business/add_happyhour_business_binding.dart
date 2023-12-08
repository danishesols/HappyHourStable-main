import 'package:get/instance_manager.dart';
import 'package:happy_hour_app/global_controller/global_general_controller.dart';
import 'package:happy_hour_app/screens/happyhour_filter_screen/happyhour_filter_screen_controller.dart';

import '../add_happyhour_standard_item/add_happyhour_controller.dart';

class AddHappyHourBusinessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddHappyhourController());
    Get.lazyPut(() => GlobalGeneralController());
    Get.lazyPut(() => HappyHourFilterScreenController());
  }
}
