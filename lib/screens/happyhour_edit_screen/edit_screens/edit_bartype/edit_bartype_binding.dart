import 'package:get/instance_manager.dart';
import 'package:happy_hour_app/global_controller/global_general_controller.dart';

import '../edit_controller.dart';

class EditBarTypeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditController());
    Get.lazyPut(() => GlobalGeneralController());
  }
}
