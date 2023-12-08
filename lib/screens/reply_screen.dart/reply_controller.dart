import 'package:get/get.dart';
import 'package:happy_hour_app/data/models/happyhour_model.dart';

class ReplyController extends GetxController {
  // final AddReviewProvider reviewProvider = AddReviewProvider();

  final HappyHourModel hour = Get.arguments;

  final RxBool _show = false.obs;
  bool get show => _show.value;
  set show(value) => _show.value = value;
}
