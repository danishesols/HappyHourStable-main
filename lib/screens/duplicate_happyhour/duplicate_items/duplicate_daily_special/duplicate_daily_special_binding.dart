import 'package:get/instance_manager.dart';

import '../../duplicate_happyhour_controller.dart';

class DuplicateDailySpecialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DuplicateController());
  }
}
