import 'package:get/get.dart';

import '../duplicate_happyhour_controller.dart';

class DuplicateShowBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DuplicateController());
  }
}
