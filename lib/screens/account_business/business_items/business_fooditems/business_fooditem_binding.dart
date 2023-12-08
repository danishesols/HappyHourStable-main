import 'package:get/get.dart';
import 'package:happy_hour_app/global_controller/global_general_controller.dart';

import '../addhappyhour_business_controller.dart';

class BusinessFoodItemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddHappyhourBusinessController());
    Get.lazyPut(() => GlobalGeneralController());
  }
}
