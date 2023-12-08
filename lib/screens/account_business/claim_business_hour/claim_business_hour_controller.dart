import 'package:get/get.dart';

class ClaimBusinessHourController extends GetxController {
  //observable variables
  final _switchs = 0.obs;
  int get switches => _switchs.value;
  set switches(value) => _switchs.value = value;
}
