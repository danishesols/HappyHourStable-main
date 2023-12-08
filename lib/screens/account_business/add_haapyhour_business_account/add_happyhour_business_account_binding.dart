import 'package:get/get.dart';

import '../business_items/addhappyhour_business_controller.dart';

class AddHappyHourBusinessAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddHappyhourBusinessController());
  }
}
