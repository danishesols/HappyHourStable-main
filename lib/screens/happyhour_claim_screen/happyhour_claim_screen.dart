import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/colors.dart';
import 'package:happy_hour_app/global_widgets/happyhour_card.dart';
import 'package:happy_hour_app/global_widgets/main_button.dart';
import 'package:happy_hour_app/screens/happyhour_claim_screen/claim_screens/claim_controller.dart';

import '../../core/constants.dart';
import '../../global_widgets/circular_indicator.dart';
import '../../routes/app_routes.dart';

class HappyHourClaimScreen extends GetView<ClaimController> {
  const HappyHourClaimScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomCircleIndicator(
        opacity: 0.5,
        isEnabled: controller.isLoading,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: bgColor,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: SvgPicture.asset(
                    "assets/icons/Group 9108.svg",
                    height: 25,
                    width: 25,
                  )),
              // title: const Text(
              //   "Lorem Ipsum Store",
              // ),
              title: Text(controller.hour.businessName.toString()),
              centerTitle: true,
            ),
            extendBodyBehindAppBar: false,
            body: SingleChildScrollView(
              child: GetBuilder<ClaimController>(
                builder: (_) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18),
                    child: Column(
                      children: [
                        Obx(() => Stack(
                              children: [
                                SizedBox(
                                    height: H * 0.25,
                                    width: W * 1.2,
                                    child: controller.happyHourMenuImage != ""
                                        ? controller.happyHourMenuImage
                                                .contains("image_picker")
                                            ? Image.file(
                                                File(controller
                                                    .happyHourMenuImage),
                                                width: W * 0.95,
                                                height: H * 0.2,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.network(
                                                controller.hour.menuImage
                                                    .toString(),
                                                fit: BoxFit.fitWidth,
                                              )
                                        : Image.network(
                                            controller.happyHourMenuImage,
                                            fit: BoxFit.cover,
                                          )
                                    // : Image.file(
                                    //     File(controller.image),
                                    //     width: W * 0.95,
                                    //     height: H * 0.2,
                                    //     fit: BoxFit.cover,
                                    //   ),
                                    ),
                                Positioned(
                                  top: 10,
                                  right: 20,
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed(Routes.claimAccountScreen,
                                          arguments: controller.hour);
                                    },
                                    child: Image.asset(
                                      "assets/icons/Group 11493@2x.png",
                                      height: H * 0.05,
                                      // width: W * 0.05,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(
                          height: H * 0.031,
                        ),
                        NewCard(
                          title: controller.businessNameController.text,
                          subtitle:
                              controller.businessAddressController.text == ""
                                  ? controller.hour.businessAddress.toString()
                                  : controller.businessAddressController.text,
                          image: "assets/icons/Group 11550.png",
                          timeIcon: "assets/icons/Group 11609@2x.png",
                          time: controller.hour.countList?.length.toString() ??
                              "",
                          rating: Container(),
                          rateCount: "",
                        ),
                        SizedBox(height: H * 0.02),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                "Description",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: H * 0.01,
                              ),
                              Text(
                                controller.descriptionController.text
                                            .toString() ==
                                        ""
                                    ? controller.hour.description.toString()
                                    : controller.descriptionController.text
                                        .toString(),
                                textAlign: TextAlign.left,
                                // overflow: TextOverflow.ellipsis,
                                //softWrap: false,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w300),
                              ),
                              SizedBox(
                                height: H * 0.01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Business Hour",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(Routes.claimHourScreen,
                                          arguments: controller.hour);
                                    },
                                    child: Image.asset(
                                      "assets/icons/Group 11493@2x.png",
                                      height: H * 0.06,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: H * 0.01,
                              ),
                              GridView.builder(
                                physics: const ScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  //  mainAxisExtent: 1,
                                  childAspectRatio: 32 / 2,
                                  crossAxisCount: 1,
                                ),
                                shrinkWrap: true,
                                itemCount: controller.selecteddays.isEmpty
                                    ? controller.hour.fromTimeToTime?.length
                                    : controller.selecteddays.length,
                                itemBuilder: (context, index) {
                                  return Text(controller
                                          .dayFromTimeToTimeList.isEmpty
                                      ? "•  ${controller.hour.fromTimeToTime?[index]['bDay']}"
                                          "    ${controller.hour.fromTimeToTime?[index]['bFtime']} -"
                                          "    ${controller.hour.fromTimeToTime?[index]['bTtime']}"
                                      : "• ${controller.selecteddays[index]['bDay']}"
                                          "    ${controller.selecteddays[index]['bFtime']}"
                                          "    ${controller.selecteddays[index]['bTtime']}");
                                },
                              ),
                              SizedBox(
                                height: H * 0.01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Happy Hour Times",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(Routes.claimDayTimeScreen,
                                          arguments: controller.hour);
                                    },
                                    child: Image.asset(
                                      "assets/icons/Group 11493@2x.png",
                                      height: H * 0.06,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: H * 0.01,
                              ),
                              GridView.builder(
                                physics: const ScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  //  mainAxisExtent: 1,
                                  childAspectRatio: 32 / 2,
                                  crossAxisCount: 1,
                                ),
                                shrinkWrap: true,
                                itemCount: controller.hDayTimeList.isEmpty
                                    ? controller.hour.day?.length
                                    : controller.hDayTimeList.length,
                                itemBuilder: (context, index) {
                                  return Text(controller.dayTimeList.isEmpty
                                      ? "•  ${controller.hour.day?[index]['Hday']}"
                                          "    ${controller.hour.day?[index]['HfromTime']} -"
                                          "    ${controller.hour.day?[index]['HtoTime']}"
                                      : "•  ${controller.hDayTimeList[index]['Hday']}"
                                          "    ${controller.hDayTimeList[index]['HfromTime']} -"
                                          "    ${controller.hDayTimeList[index]['HtoTime']}");
                                },
                              ),
                              SizedBox(
                                height: H * 0.01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Food Items",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(Routes.claimFoodItemScreen,
                                          arguments: controller.hour);
                                    },
                                    child: Image.asset(
                                      "assets/icons/Group 11493@2x.png",
                                      height: H * 0.06,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: H * 0.01,
                              ),
                              GridView.builder(
                                physics: const ScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  //  mainAxisExtent: 1,
                                  childAspectRatio: 16 / 2,
                                  crossAxisCount: 2,
                                ),
                                shrinkWrap: true,
                                itemCount: controller.foodList.isEmpty
                                    ? controller.hour.foodName?.length
                                    : controller.foodList.length,
                                itemBuilder: (context, index) {
                                  return Text(controller.foodList.isEmpty
                                      ? "•  ${controller.hour.foodName?[index]['foodname']}"
                                      : "•  ${controller.foodList[index].name}");
                                },
                              ),
                              SizedBox(
                                height: H * 0.01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Drink Items",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(Routes.claimDrinksScreen,
                                          arguments: controller.hour);
                                    },
                                    child: Image.asset(
                                      "assets/icons/Group 11493@2x.png",
                                      height: H * 0.06,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: H * 0.01,
                              ),
                              GridView.builder(
                                physics: const ScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 16 / 2,
                                  crossAxisCount: 2,
                                ),
                                shrinkWrap: true,
                                itemCount: controller.localdrinkList.isEmpty
                                    ? controller.hour.drinkitemName?.length
                                    : controller.localdrinkList.length,
                                itemBuilder: (context, index) {
                                  return Text(controller.localdrinkList.isEmpty
                                      ? "•  ${controller.hour.drinkitemName?[index]['drinkname']}"
                                      : "•  ${controller.localdrinkList[index].name}");
                                },
                              ),
                              SizedBox(
                                height: H * 0.01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Daily Special",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(
                                          Routes.claimDailySpecialScreen,
                                          arguments: controller.hour);
                                    },
                                    child: Image.asset(
                                      "assets/icons/Group 11493@2x.png",
                                      height: H * 0.06,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: H * 0.01,
                              ),
                              GridView.builder(
                                physics: const ScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 24 / 2,
                                  crossAxisCount: 1,
                                ),
                                shrinkWrap: true,
                                itemCount:
                                    controller.alldailySpecialList.isEmpty
                                        ? controller.hour.dailySpecils?.length
                                        : controller.alldailySpecialList.length,
                                itemBuilder: (context, index) {
                                  return Text(controller
                                          .alldailySpecialList.isEmpty
                                      ? "•  ${controller.hour.dailySpecils?[index]['name']}   •${controller.hour.dailySpecils?[index]['day']}"
                                      : "•  ${controller.alldailySpecialList[index]['name']}   •${controller.hour.dailySpecils?[index]['day']}");
                                },
                              ),
                              SizedBox(
                                height: H * 0.01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Amenities",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(Routes.claimAmenitiesScreen,
                                          arguments: controller.hour);
                                    },
                                    child: Image.asset(
                                      "assets/icons/Group 11493@2x.png",
                                      height: H * 0.06,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: H * 0.01,
                              ),
                              GridView.builder(
                                physics: const ScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  //  mainAxisExtent: 1,
                                  childAspectRatio: 16 / 2,
                                  crossAxisCount: 2,
                                ),
                                shrinkWrap: true,
                                itemCount: controller.amentyAddList.isEmpty
                                    ? controller.hour.amenities?.length
                                    : controller.amentyAddList.length,
                                itemBuilder: (context, index) {
                                  return Text(controller.amentyAddList.isEmpty
                                      ? "•  ${controller.hour.amenities?[index]}"
                                      : "•  ${controller.amentyAddList[index]}");
                                },
                              ),
                              SizedBox(
                                height: H * 0.01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Bar Type",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(Routes.claimBarTypeScreen,
                                          arguments: controller.hour);
                                    },
                                    child: Image.asset(
                                      "assets/icons/Group 11493@2x.png",
                                      height: H * 0.06,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: H * 0.01,
                              ),
                              GridView.builder(
                                physics: const ScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  //  mainAxisExtent: 1,
                                  childAspectRatio: 16 / 2,
                                  crossAxisCount: 2,
                                ),
                                shrinkWrap: true,
                                itemCount: controller.barTypeAddList.isEmpty
                                    ? controller.hour.barType?.length
                                    : controller.barTypeAddList.length,
                                itemBuilder: (context, index) {
                                  return Text(controller.barTypeAddList.isEmpty
                                      ? "•  ${controller.hour.barType?[index]}"
                                      : "•  ${controller.barTypeAddList[index]}");
                                },
                              ),
                              SizedBox(
                                height: H * 0.01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Events",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(Routes.claimEventsScreen,
                                          arguments: controller.hour);
                                    },
                                    child: Image.asset(
                                      "assets/icons/Group 11493@2x.png",
                                      height: H * 0.06,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: H * 0.01,
                              ),
                              GridView.builder(
                                physics: const ScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  //  mainAxisExtent: 1,
                                  childAspectRatio: 16 / 2,
                                  crossAxisCount: 2,
                                ),
                                shrinkWrap: true,
                                itemCount: controller.selectedEvent.isEmpty
                                    ? controller.hour.event?.length
                                    : controller.selectedEvent.length,
                                itemBuilder: (context, index) {
                                  return Text(controller.selectedEvent.isEmpty
                                      ? "•  ${controller.hour.event?[index]['name']}"
                                      : "•  ${controller.selectedEvent[index]['name']}");
                                },
                              ),
                              SizedBox(
                                height: H * 0.01,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: H * 0.09,
                          width: W,
                          child: CustomElevatedButtonWidget(
                            onPressed: () {
                              // print(Get.find<ClaimThisBusinessFormController>()
                              //     .businessCard
                              //     .toString());
                              // print(Get.find<ClaimThisBusinessFormController>()
                              //     .businessImage
                              //     .toString());
                              // print(Get.find<ClaimThisBusinessFormController>()
                              //     .businessLogo
                              //     .toString());

                              controller.updateBusinessHourToFireStore();
                              // Get.back();
                              // Get.back();
                            },
                            text: "Done",
                            textColor: blackColor,
                            fontSize: 24,
                            verticalPadding: 0,
                            borderRadius: 45,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
