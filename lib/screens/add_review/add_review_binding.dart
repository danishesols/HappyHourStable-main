import 'package:get/get.dart';
import 'package:happy_hour_app/screens/add_review/add_review_controller.dart';

class AddReviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddReviewController());
  }
}
