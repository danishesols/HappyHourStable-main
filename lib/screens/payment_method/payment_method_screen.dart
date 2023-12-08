import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/constants.dart';
import 'package:happy_hour_app/global_controller/global_general_controller.dart';
import 'package:happy_hour_app/screens/payment_method/payment_method_screen_controller.dart';

import '../../core/colors.dart';
import '../../global_widgets/main_button.dart';
import '../../routes/app_routes.dart';

class PaymentMethodScreen extends GetView<PaymentMethodScreenController> {
  const PaymentMethodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: SvgPicture.asset(
              "assets/icons/Group 9108.svg",
              height: 25,
              width: 25,
            )),
        title: const Text("Payment Method"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Please select your payment method",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.masterPayment = true;
                            controller.paypalPayment = false;
                            controller.visaPayment = false;
                          },
                          child: controller.masterPayment == false
                              ? Image.asset(
                                  "assets/icons/Group 8556@2x.png",
                                  height: H * 0.3,
                                  width: W * 0.3,
                                )
                              : Image.asset(
                                  "assets/icons/Group 8556@2x.png",
                                  height: H * 0.34,
                                  width: W * 0.34,
                                ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.visaPayment = true;
                            controller.masterPayment = false;
                            controller.paypalPayment = false;
                          },
                          child: controller.visaPayment == false
                              ? Image.asset(
                                  "assets/icons/Group 8559@2x.png",
                                  height: H * 0.3,
                                  width: W * 0.3,
                                )
                              : Image.asset(
                                  "assets/icons/Group 8559@2x.png",
                                  height: H * 0.34,
                                  width: W * 0.34,
                                ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.paypalPayment = true;
                            controller.visaPayment = false;
                            controller.masterPayment = false;
                          },
                          child: controller.paypalPayment == false
                              ? Image.asset(
                                  "assets/icons/Group 8561@2x.png",
                                  height: H * 0.3,
                                  width: W * 0.3,
                                )
                              : Image.asset(
                                  "assets/icons/Group 8561@2x.png",
                                  height: H * 0.34,
                                  width: W * 0.34,
                                  colorBlendMode: BlendMode.plus,
                                ),
                        ),
                      ],
                    )),
              ],
            ),
            SizedBox(
              height: H * 0.09,
              width: W,
              child: CustomElevatedButtonWidget(
                onPressed: () {
                  if (controller.masterPayment == true) {
                    Get.toNamed(Routes.paymentCardDetailScreen);
                  }
                  if (controller.visaPayment == true) {
                    Get.toNamed(Routes.paymentCardDetailScreen);
                  }
                  if (controller.paypalPayment == true) {
                    Get.toNamed(Routes.paymentCardDetailScreen);
                  } else if (controller.masterPayment == false &&
                      controller.visaPayment == false &&
                      controller.paypalPayment == false) {
                    Get.find<GlobalGeneralController>().errorSnackbar(
                        title: "Select One Method",
                        description:
                            "Please Select one Payment method to proceed");
                  }
                },
                text: "Proceed",
                textColor: blackColor,
                fontSize: 24,
                verticalPadding: 0,
                borderRadius: 45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
