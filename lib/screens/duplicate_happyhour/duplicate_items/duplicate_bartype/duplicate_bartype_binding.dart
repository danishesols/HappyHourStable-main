import 'package:get/instance_manager.dart';

import '../../duplicate_happyhour_controller.dart';

class DupliacteBarTypeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DuplicateController());
  }
}
