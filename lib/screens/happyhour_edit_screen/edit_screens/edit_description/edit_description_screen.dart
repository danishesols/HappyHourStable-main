import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/colors.dart';
import '../../../../core/constants.dart';
import '../../../../global_widgets/main_button.dart';
import '../../../../global_widgets/text_field.dart';
import '../edit_controller.dart';

class EditDescriptionScreen extends GetView<EditController> {
  const EditDescriptionScreen({Key? key}) : super(key: key);

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
        title: const Text("Add Happy Hour"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: H * 0.009,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Text(
                "Add Business Description",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: H * 0.02,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFieldWidget(
                      borderRadius: 18,
                      hintText: "Write Something...",
                      maxLines: 6,
                      textEditingController: controller.descriptionController,
                    ),
                    Center(
                      child: SizedBox(
                        height: H * 0.09,
                        width: W,
                        child: CustomElevatedButtonWidget(
                          onPressed: () {
                            controller.onDescriptionDone();
                          },
                          text: "Done",
                          textColor: blackColor,
                          fontSize: 24,
                          verticalPadding: 0,
                          borderRadius: 45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
