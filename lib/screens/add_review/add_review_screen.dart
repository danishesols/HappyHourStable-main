import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/constants.dart';
import 'package:happy_hour_app/global_widgets/circular_indicator.dart';
import 'package:happy_hour_app/global_widgets/text_field.dart';
import 'package:happy_hour_app/screens/add_review/add_review_controller.dart';

import '../../core/colors.dart';
import '../../global_widgets/main_button.dart';

class AddReviewScreen extends GetView<AddReviewController> {
  const AddReviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddReviewController>(builder: (con){
      return CustomCircleIndicator(
        isEnabled: controller.isLoading,
        opacity: 0.5,
        child: Scaffold(
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
            title: const Text("Add Review"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: H * 0.009,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        "You can add your review here",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: H * 0.06,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RatingBar.builder(
                            unratedColor: Colors.grey.shade300,
                            initialRating: 4,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            updateOnDrag: true,
                            itemCount: 5,
                            itemPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, index) => Image.asset(
                              "assets/icons/Path 602@2x.png",
                              color: primary,
                            ),
                            onRatingUpdate: controller.rating)
                      ],
                    ),
                    SizedBox(
                      height: H * 0.06,
                    ),
                    SizedBox(
                      height: H * 0.24,
                      child: CustomTextFieldWidget(
                        textEditingController: controller.reviewController,
                        borderRadius: 8,
                        maxLines: 8,
                        hintText: "Write Somthing",
                        elevation: 0,
                        blurRadius: 2,
                      ),
                    ),
                    SizedBox(
                      height: H * 0.05,
                    ),
                    SizedBox(
                      height: H * 0.09,
                      width: W,
                      child: CustomElevatedButtonWidget(
                        onPressed: () async{
                          Get.back();
                          await controller.addReviewOnHour();

                        },
                        text: "Submit",
                        textColor: blackColor,
                        fontSize: 24,
                        verticalPadding: 0,
                        borderRadius: 45,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
