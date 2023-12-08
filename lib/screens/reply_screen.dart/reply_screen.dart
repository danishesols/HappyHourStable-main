import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/constants.dart';
import 'package:happy_hour_app/global_widgets/happyhour_card.dart';
import 'package:happy_hour_app/global_widgets/text_field.dart';
import 'package:happy_hour_app/screens/account_standard/standard_happyhour_detail/standard_happyhour_detail_screen.dart';
import 'package:happy_hour_app/screens/reply_screen.dart/reply_controller.dart';

import '../../core/colors.dart';
import '../account_standard/standard_happyhour_detail/standard_happyhour_detail_screen_controller.dart';

class ReplyScreen extends GetView<ReplyController> {
  const ReplyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => StandardHappyhourDetailScreenController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        extendBodyBehindAppBar: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 18),
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                        height: H * 0.25,
                        width: W * 1.2,
                        child: Image.network(
                          controller.hour.menuImage.toString(),
                          fit: BoxFit.fitWidth,
                        )),
                    Positioned(
                      height: 50,
                      width: 50,
                      top: 10,
                      left: 10,
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: SvgPicture.asset(
                          "assets/icons/Group 8597.svg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: H * 0.031,
                ),
                NewCard(
                    title: controller.hour.businessName.toString(),
                    subtitle: controller.hour.businessAddress.toString(),
                    isNetworkImage: controller.hour.businessLogo != null &&
                            controller.hour.businessLogo != '' &&
                            controller.hour.businessLogo != 'null'
                        ? true
                        : false,
                    image: controller.hour.businessLogo != null &&
                            controller.hour.businessLogo != '' &&
                            controller.hour.businessLogo != 'null'
                        ? controller.hour.businessLogo!
                        : null,
                    timeIcon: "assets/icons/Group 11609@2x.png",
                    time: "",
                    rating: Container(),
                    rateCount: "",
                    share: Container()),
                SizedBox(height: H * 0.02),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Reviews",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: H * 0.01,
                        ),
                        ShowReviews(
                          hourId: controller.hour.id!,
                          isBusinessReplyScreen: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomReplyCard extends GetView<ReplyController> {
  const CustomReplyCard({
    Key? key,
    required this.subtitle,
    required this.image,
    this.height,
    this.width,
    required this.time,
    this.timeIcon,
    required this.rating,
    required this.rateCount,
    this.replieTitle,
    this.replieSubTitle,
    this.replieImage,
    this.replieTime,
    this.showReply,
    this.onTap,
  }) : super(key: key);

  final String subtitle;
  final String image;
  final double? height;
  final double? width;
  final String time;
  final String? timeIcon;
  final Widget rating;
  final String rateCount;
  final String? replieTitle;
  final String? replieSubTitle;
  final String? replieImage;
  final String? replieTime;
  final bool? showReply;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          controller.show = !controller.show;
        },
        child: Card(
          elevation: 5,
          color: whiteColor,
          shadowColor: bgColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: H * 0.1,
                      width: W * 0.2,
                      // child: SvgPicture.asset(image),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: bgColor,
                          image: DecorationImage(image: AssetImage(image))),
                    ),
                  ),
                  SizedBox(
                    width: W * 0.020,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        subtitle,
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w300),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          rating,
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            rateCount,
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Visibility(
                visible: controller.show,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16.0, bottom: 16.0),
                      child: Container(
                        height: H * 0.1,
                        width: W,
                        decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                width: W * 0.14,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: bgColor,
                                    image: DecorationImage(
                                        image: AssetImage(replieImage ?? ""))),
                              ),
                            ),
                            SizedBox(
                              width: W * 0.5,
                              child: const Padding(
                                padding: EdgeInsets.all(16),
                                child: CustomTextFieldWidget(),
                              ),
                            ),
                            Image.asset(
                              "assets/icons/send.png",
                              height: 40,
                              width: 40,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
