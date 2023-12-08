import 'package:get/instance_manager.dart';

import '../addhappyhour_business_controller.dart';

class BusinessAmenitiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddHappyhourBusinessController());
  }
}
