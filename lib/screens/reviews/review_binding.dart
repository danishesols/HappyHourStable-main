import 'package:get/instance_manager.dart';
import 'package:happy_hour_app/screens/reviews/review_controller.dart';

class ReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReviewController());
  }
}
