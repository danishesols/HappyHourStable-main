import 'package:get/get.dart';

class PaymentMethodScreenController extends GetxController {
  final RxBool _masterPayment = false.obs;
  bool get masterPayment => _masterPayment.value;
  set masterPayment(value) => _masterPayment.value = value;

  final RxBool _visaPayment = false.obs;
  bool get visaPayment => _visaPayment.value;
  set visaPayment(value) => _visaPayment.value = value;

  final RxBool _paypalPayment = false.obs;
  bool get paypalPayment => _paypalPayment.value;
  set paypalPayment(value) => _paypalPayment.value = value;
}
