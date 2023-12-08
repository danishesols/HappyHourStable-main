// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/routes/app_routes.dart';
import 'package:happy_hour_app/screens/account_business/business_items/addhappyhour_business_controller.dart';

import '../../../core/colors.dart';
import '../../../core/constants.dart';
import '../../../global_widgets/main_button.dart';
import '../../../global_widgets/text_field.dart';

class AddHappyHourBusinessManually
    extends GetView<AddHappyhourBusinessController> {
 // const AddHappyHourBusinessManually({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              controller.businessAddressController.clear();
              controller.businessNameController.clear();
              Get.back();
            },
            icon: SvgPicture.asset(
              "assets/icons/Group 9108.svg",
              height: 25,
              width: 25,
            )),
        title: const Text("Add Happy Hour"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: controller.manualAddressformKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: H * 0.009,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Add manual address",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  height: H * 0.02,
                ),

                SizedBox(
                  height: H * 0.02,
                ),
                CustomTextFieldWidget(
                  // onTap: () => controller.onBusinessNameClick(),

                  validator: controller.nameValidator,
                  labelText: "Business Name",
                  textEditingController: controller.businessNameController,
                ),
                SizedBox(
                  height: H * 0.02,
                ),
                CustomTextFieldWidget(
                  onTap: () => controller.onBusinessAddressClick(),
                  readOnly: true,
                  validator: controller.addressValidator,
                  labelText: "Business Address",
                  textEditingController: controller.businessAddressController,
                ),

                // ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 32),
        child: SizedBox(
          height: H * 0.09,
          child: CustomElevatedButtonWidget(
            onPressed: () {
              if (controller.manualAddressformKey.currentState!.validate()) {
                Get.offNamed(Routes.addHappyHourBusinessAccountScreen);
              }
            },
            text: "Done",
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
