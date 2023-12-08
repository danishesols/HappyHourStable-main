import 'package:get/instance_manager.dart';
import 'package:happy_hour_app/global_controller/auth_controller.dart';
import 'package:happy_hour_app/global_controller/global_general_controller.dart';
import 'package:happy_hour_app/screens/happyhour_edit_screen/edit_happyhour_detail/edit_detail_screen_controller.dart';
import 'package:happy_hour_app/screens/happyhour_edit_screen/edit_screens/edit_controller.dart';

class EditDetailScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditDetailScreenController());
    Get.lazyPut(() => EditController());
    Get.lazyPut(() => GlobalGeneralController());
    Get.lazyPut(() => AuthController());
  }
}
