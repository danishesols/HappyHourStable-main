import 'package:get/instance_manager.dart';
import 'package:happy_hour_app/screens/reply_screen.dart/reply_controller.dart';

class ReplyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReplyController());
  }
}
