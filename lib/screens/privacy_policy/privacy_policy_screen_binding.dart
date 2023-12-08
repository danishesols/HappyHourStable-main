import 'package:get/instance_manager.dart';
import 'package:happy_hour_app/screens/privacy_policy/privacy_policy_screen_controller.dart';

class PrivacyPolicyScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PrivacyPolicyScreenController());
  }
}
