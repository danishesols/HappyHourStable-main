import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/colors.dart';
import 'package:happy_hour_app/core/constants.dart';
import 'package:happy_hour_app/global_controller/global_general_controller.dart';
import 'package:happy_hour_app/global_widgets/main_button.dart';
import 'package:happy_hour_app/global_widgets/text_field.dart';
import 'package:happy_hour_app/screens/checkout_claim/claim_checkout_completed.dart';
import 'check_out_claim_screen_controller.dart';

class CheckOutClaimScreen extends GetView<CheckOutClaimScreenController> {
  const CheckOutClaimScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: const Text("Checkout"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 0.0, top: 16),
                child: Text(
                  "Packages Details",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
              ),
              SizedBox(
                height: H * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("package Name"),
                  Obx(() => Text(controller.annually
                      ? "Yearly package"
                      : "Monthly package"))
                ],
              ),
              SizedBox(
                height: H * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Duration"),
                  Obx(() => Text(controller.annually ? "Yearly" : "Monthly"))
                ],
              ),
              SizedBox(
                height: H * 0.02,
              ),
              const Text(
                "Select Payment Options",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: H * 0.01,
              ),
              Row(
                children: [
                  Transform.scale(
                    scale: 0.5,
                    child: Obx(
                      () => Card(
                        margin: const EdgeInsets.all(1),
                        elevation: 6,
                        shape: const StadiumBorder(),
                        child: Transform.scale(
                          scale: 2.0,
                          child: Checkbox(
                              checkColor: Theme.of(context).primaryColor,
                              splashRadius: 20,
                              shape: const StadiumBorder(),
                              side: BorderSide.none,
                              value: controller.monthly,
                              onChanged: (v) {
                                controller.selectmonthly(v!);
                              }),
                        ),
                      ),
                    ),
                  ),
                  const Text("Charge Monthly"),
                ],
              ),
              Row(
                children: [
                  Transform.scale(
                    scale: 0.5,
                    child: Obx(
                      () => Card(
                        margin: const EdgeInsets.all(1),
                        elevation: 6,
                        shape: const StadiumBorder(),
                        child: Transform.scale(
                          scale: 2.0,
                          child: Checkbox(
                              checkColor: Theme.of(context).primaryColor,
                              splashRadius: 20,
                              shape: const StadiumBorder(),
                              side: BorderSide.none,
                              value: controller.annually,
                              onChanged: (v) {
                                controller.selectannually(v!);
                              }),
                        ),
                      ),
                    ),
                  ),
                  const Text("Charge Annually"),
                ],
              ),
              SizedBox(
                height: H * 0.01,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 0.0, top: 16),
                child: Text(
                  "Add Promo Code",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                ),
              ),
              SizedBox(
                height: H * 0.01,
              ),
              const CustomTextFieldWidget(
                hintText: "Enter Promo Code",
                suffixIcon: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text("Apply",
                      style: TextStyle(
                        fontSize: 16,
                        color: primary,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: H * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 16, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total ",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 16),
                      child: Obx(() => Text(
                            controller.annually ? "\$249.99" : "\$29.99",
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 30.0),
        child: SizedBox(
          height: H * 0.09,
          width: W,
          child: CustomElevatedButtonWidget(
            onPressed: () {
              if (controller.annually == false && controller.monthly == false) {
                Get.find<GlobalGeneralController>().errorSnackbar(
                    title: "Error Occur",
                    description: "Please select one package to proceed");
              } else {
                if (controller.annually == true &&
                    controller.monthly == false) {
                  Get.to(() => const ClaimRequestSubmitted());
                } else {
                  if (controller.annually == false &&
                      controller.monthly == true) {
                    Get.to(() => const ClaimRequestSubmitted());
                  }
                }
              }
            },
            text: "Proceed",
            textColor: blackColor,
            fontSize: 24,
            verticalPadding: 0,
            borderRadius: 45,
          ),
        ),
      ),
    );
  }
}
