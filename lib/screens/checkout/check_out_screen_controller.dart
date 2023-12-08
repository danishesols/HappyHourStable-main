import 'package:get/get.dart';

class CheckOutScreenController extends GetxController {
  final RxBool _checkBoxmonthly = false.obs;
  bool get monthly => _checkBoxmonthly.value;
  set monthly(value) => _checkBoxmonthly.value = value;

  final RxBool _checkBoxAnnually = false.obs;
  bool get annually => _checkBoxAnnually.value;
  set annually(value) => _checkBoxAnnually.value = value;

  void selectmonthly(bool value) {
    monthly = !monthly;
    annually = false;
    update();
  }

  void selectannually(bool value) {
    annually = !annually;
    monthly = false;
    update();
  }
}
