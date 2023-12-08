import 'package:get/instance_manager.dart';

import '../../duplicate_happyhour_controller.dart';

class DuplicateBusinessHourBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DuplicateController());
  }
}
