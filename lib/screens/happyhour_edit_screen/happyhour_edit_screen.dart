import 'dart:io';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/colors.dart';
import 'package:happy_hour_app/global_widgets/circular_indicator.dart';
import 'package:happy_hour_app/global_widgets/happyhour_card.dart';
import 'package:happy_hour_app/screens/happyhour_edit_screen/edit_screens/edit_controller.dart';

import '../../core/constants.dart';
import '../../global_widgets/custom_button.dart';
import '../../routes/app_routes.dart';
import '../happyhour_detail_screen/happyhour_detail_screen.dart';

class HappyHourEditScreen extends GetView<EditController> {
  const HappyHourEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditController>(builder: (con) {
      return CustomCircleIndicator(
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
                  Navigator.pop(context);
                  // Get.back();
                },
                icon: SvgPicture.asset(
                  "assets/icons/Group 9108.svg",
                  height: 25,
                  width: 25,
                ),
              ),
              // title: const Text(
              //   "Lorem Ipsum Store",
              // ),
              title: Text(controller.firestoreObj.businessName.toString()),
              centerTitle: true,
            ),
            extendBodyBehindAppBar: false,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                            height: H * 0.25,
                            width: W * 1.2,
                            child: controller.firestoreObj.businessImage ==
                                        null ||
                                    controller.firestoreObj.businessImage ==
                                        "" ||
                                    controller.firestoreObj.businessImage ==
                                        'null'
                                ? controller.businessImageFile != null
                                    ? Image.file(
                                        File(
                                          controller.businessImageFile!.path,
                                        ),
                                        width: W * 0.95,
                                        height: H * 0.2,
                                        fit: BoxFit.cover,
                                      )
                                    // : controller.firestoreObj.businessImage !=
                                    //             null &&
                                    //         controller
                                    //                 .firestoreObj.businessImage !=
                                    //             "null"
                                    //     ? Image.network(
                                    //         controller.firestoreObj.businessImage
                                    //             .toString(),
                                    //         fit: BoxFit.fitWidth,
                                    //       )
                                    : Image.asset(
                                        'assets/images/Rectangle 2698@2x.png',
                                        fit: BoxFit.cover,
                                      )
                                :
                                // controller.businessImage != 'null'
                                //         ?
                                Image.network(
                                    controller.firestoreObj.businessImage!,
                                    fit: BoxFit.cover,
                                  )
                            // : Image.asset(
                            //     'assets/images/Rectangle 2698@2x.png',
                            //     fit: BoxFit.cover,
                            //   ),
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
                              Get.toNamed(
                                Routes.editAccountScreen,
                                arguments: controller.firestoreObj,
                              );
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
                    ),
                    SizedBox(
                      height: H * 0.031,
                    ),
                    NewCard(
                      title: controller.businessNameController.text,
                      isNetworkImage:
                          controller.firestoreObj.businessLogo != null &&
                                  controller.firestoreObj.businessLogo != '' &&
                                  controller.firestoreObj.businessLogo != 'null'
                              ? true
                              : false,
                      image: controller.firestoreObj.businessLogo != null &&
                              controller.firestoreObj.businessLogo != '' &&
                              controller.firestoreObj.businessLogo != 'null'
                          ? controller.firestoreObj.businessLogo!
                          : null,
                      subtitle: controller.businessAddressController.text == ""
                          ? controller.firestoreObj.businessAddress.toString()
                          : controller.businessAddressController.text,
                      timeIcon: "assets/icons/Group 11609@2x.png",
                      time: controller.firestoreObj.countList?.length
                              .toString() ??
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Description",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: primary,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.editDescriptionScreen,
                                      arguments: controller.firestoreObj);
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
                          Text(
                            controller.descriptionController.text.toString() ==
                                    ""
                                ? controller.firestoreObj.description.toString()
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Happy Hour Menu",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: primary,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.editAccountScreen,
                                      arguments: controller.firestoreObj);
                                },
                                child: Image.asset(
                                  "assets/icons/Group 11493@2x.png",
                                  height: H * 0.05,
                                  // width: W * 0.05,
                                  fit: BoxFit.cover,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: H * 0.01,
                          ),
                          Visibility(
                            visible: controller.menuImageList.isNotEmpty,
                            child: SizedBox(
                              height: H * 0.25,
                              width: W * 1.2,
                              child:
                                  // child: controller.menuImageList.isNotEmpty
                                  //     ? Swiper(
                                  //         //physics: const NeverScrollableScrollPhysics(),
                                  //         itemCount:
                                  //             controller.menuImageList.length,
                                  //         pagination: const SwiperPagination(),
                                  //         viewportFraction: 1,
                                  //         scale: 1,
                                  //         loop: false,
                                  //         itemBuilder:
                                  //             (BuildContext context, int i) {
                                  //           return Container(
                                  //             height: H * 0.3,
                                  //             width: W,
                                  //             decoration: BoxDecoration(
                                  //               border: Border.all(
                                  //                 width: 4,
                                  //                 color: primary,
                                  //               ),
                                  //             ),
                                  //             child: GestureDetector(
                                  //               onTap: () {
                                  //                 Get.to(() => DetailScreen(
                                  //                     tag: "tag",
                                  //                     image: controller
                                  //                         .menuImageList[i]
                                  //                         .toString()));
                                  //               },
                                  //               child: Image.file(
                                  //                 File(controller
                                  //                     .menuImageList[i]!),
                                  //                 fit: BoxFit.cover,
                                  //               ),
                                  //             ),
                                  //           );
                                  //
                                  //           //  Image.network(
                                  //           //   controller.imageList[index],
                                  //           //   // controller.happyHour.businessImage?.toString() ??
                                  //           //   //     controller.happyHour.menuImage.toString(),
                                  //           //   fit: BoxFit.fitWidth,
                                  //           // );
                                  //         },
                                  //       )
                                  //     :
                                  Swiper(
                                itemCount: controller.menuImageList.length,
                                pagination: const SwiperPagination(),
                                viewportFraction: 1,
                                scale: 1,
                                loop: false,
                                itemBuilder: (BuildContext context, int i) {
                                  return Container(
                                    height: H * 0.3,
                                    width: W,
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(width: 4, color: primary),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(() => DetailScreen(
                                            isNetwork: true,
                                            tag: "tag",
                                            image: controller.menuImageList[i]
                                                .toString()));
                                      },
                                      child: Image.network(
                                        controller.menuImageList[i]!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),

                          SizedBox(
                            height: H * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Happy Hour Times",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: primary),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.editDayTimeScreen,
                                      arguments: controller.firestoreObj);
                                },
                                child: Image.asset(
                                  "assets/icons/Group 11493@2x.png",
                                  height: H * 0.06,
                                ),
                              ),
                            ],
                          ),
                          controller.firestoreObj.day!.isNotEmpty ||
                                  controller.hDayTimeList.isNotEmpty
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Happy Hour Times",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: primary),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.editDayTimeScreen,
                                            arguments: controller.firestoreObj);
                                      },
                                      child: Image.asset(
                                        "assets/icons/Group 11493@2x.png",
                                        height: H * 0.06,
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                          SizedBox(
                            height: H * 0.01,
                          ),
                          GridView.builder(
                            physics: const ScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              //  mainAxisExtent: 1,
                              childAspectRatio: 30 / 2,
                              crossAxisCount: 1,
                            ),
                            shrinkWrap: true,
                            itemCount: controller.hDayTimeList.isEmpty
                                ? controller.firestoreObj.day?.length
                                : controller.hDayTimeList.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  controller.dayTimeList.isEmpty
                                      ? Row(
                                          children: [
                                            SizedBox(
                                              width: W * 0.25,
                                              child: Text(
                                                  "•  ${controller.firestoreObj.day?[index]['Hday']}"),
                                            ),
                                            Text(
                                              "    ${controller.firestoreObj.day?[index]['HfromTime']}  -"
                                              "    ${controller.firestoreObj.day?[index]['HtoTime']}",
                                            ),
                                          ],
                                        )
                                      : controller.hDayTimeList.isNotEmpty
                                          ? Row(
                                              children: [
                                                SizedBox(
                                                  width: W * 0.25,
                                                  child: Text(
                                                      "•  ${controller.hDayTimeList[index]['Hday']}"),
                                                ),
                                                Text(
                                                    " ${controller.hDayTimeList[index]['HfromTime']}   -"
                                                    "   ${controller.hDayTimeList[index]['HtoTime']}"),
                                              ],
                                            )
                                          : const SizedBox(),

                                  // Text(controller.dayTimeList.isEmpty
                                  //     ? "•  ${controller.hour.day?[index]['Hday']}"
                                  //         "    ${controller.hour.day?[index]['HfromTime']} -"
                                  //         "    ${controller.hour.day?[index]['HtoTime']}"
                                  //     : controller.hDayTimeList.isNotEmpty
                                  //         ? "•  ${controller.hDayTimeList[index]['Hday']}"
                                  //             "    ${controller.hDayTimeList[index]['HfromTime']} -"
                                  //             "    ${controller.hDayTimeList[index]['HtoTime']}"
                                  //         : ""),
                                ],
                              );
                            },
                          ),

                          /// added because of when both late and early happy hour are gone. then it will be shown for food items

                          Visibility(
                            visible: controller.earlyFoodItems.isEmpty &&
                                controller.lateFoodItems.isEmpty,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Add Food Items",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: primary),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(Routes.editFoodItemScreen,
                                        arguments: controller.firestoreObj);
                                  },
                                  child: Image.asset(
                                    "assets/icons/Group 11493@2x.png",
                                    height: H * 0.06,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          ///==============================================================================
                          Visibility(
                            visible: controller.earlyFoodItems.isNotEmpty,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Happy Hour Food Items",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: primary),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.moveEditFoodItems();
                                      },
                                      child: Image.asset(
                                        "assets/icons/Group 11493@2x.png",
                                        height: H * 0.06,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        "Name",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "Quantity",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "Price/Discount",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ]),
                                SizedBox(
                                  height: H * 0.01,
                                ),
                                GridView.builder(
                                  physics: const ScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    //  mainAxisExtent: 1,
                                    childAspectRatio: 24 / 2,
                                    crossAxisCount: 1,
                                  ),
                                  shrinkWrap: true,
                                  itemCount: controller.earlyFoodItems.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: W * 0.28,
                                          child: Text(
                                              "${controller.earlyFoodItems[index].name}"),
                                        ),
                                        SizedBox(
                                          width: W * 0.23,
                                          child: Text(
                                              "•  ${controller.earlyFoodItems[index].quantity}"),
                                        ),
                                        if (controller
                                                .earlyFoodItems[index].price !=
                                            '')
                                          SizedBox(
                                            width: W * 0.25,
                                            child: Text(
                                              "•  \$${controller.earlyFoodItems[index].price}",
                                            ),
                                          )
                                        else
                                          SizedBox(
                                            width: W * 0.25,
                                            child: Text(
                                              controller.earlyFoodItems[index]
                                                          .discountIcon ==
                                                      "%"
                                                  ? "• ${controller.earlyFoodItems[index].discount}% off"
                                                  : "• \$${controller.earlyFoodItems[index].discount} off",
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: H * 0.01,
                                ),
                              ],
                            ),
                          ),

                          ///================================= early drink items ==================================
                          Visibility(
                            visible: controller.earlyDrinkItems.isNotEmpty,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Happy Hour Drink Items",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: primary),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                          Routes.editDrinksScreen,
                                          arguments: controller.firestoreObj,
                                        );
                                      },
                                      child: Image.asset(
                                        "assets/icons/Group 11493@2x.png",
                                        height: H * 0.06,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        "Name    ",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "Size",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "Price/Discount",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      // Text(
                                      //   "",
                                      //   style: TextStyle(
                                      //       fontSize: 16,
                                      //       fontWeight: FontWeight.w600),
                                      // ),
                                    ]),
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
                                  itemCount: controller.earlyDrinkItems.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: W * 0.28,
                                          child: Text(
                                            "•  ${controller.earlyDrinkItems[index].name}",
                                          ),
                                        ),
                                        SizedBox(
                                          width: W * 0.23,
                                          child: Text(
                                            "•  ${controller.earlyDrinkItems[index].size}${controller.earlyDrinkItems[index].sizeicon}",
                                          ),
                                        ),
                                        if (controller
                                                .earlyDrinkItems[index].price !=
                                            '')
                                          SizedBox(
                                            width: W * 0.25,
                                            child: Text(
                                              "•  \$${controller.earlyDrinkItems[index].price}",
                                            ),
                                          )
                                        else
                                          SizedBox(
                                            width: W * 0.25,
                                            child: Text(
                                              controller.earlyDrinkItems[index]
                                                          .discounticon ==
                                                      "%"
                                                  ? "• ${controller.earlyDrinkItems[index].discount}% off"
                                                  : "• \$${controller.earlyDrinkItems[index].discount} off",
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: H * 0.01,
                                ),
                              ],
                            ),
                          ),

                          ///================================================================
                          controller.firestoreObj.dayLate!.isNotEmpty ||
                                  controller.hDayTimeLateList.isNotEmpty
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Late Happy Hour Times",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: primary),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.editDayTimeScreen,
                                            arguments: controller.firestoreObj);
                                      },
                                      child: Image.asset(
                                        "assets/icons/Group 11493@2x.png",
                                        height: H * 0.06,
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                          SizedBox(
                            height: H * 0.01,
                          ),
                          controller.firestoreObj.dayLate!.isNotEmpty ||
                                  controller.hDayTimeLateList.isNotEmpty
                              ? GridView.builder(
                                  physics: const ScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 30 / 2,
                                    crossAxisCount: 1,
                                  ),
                                  shrinkWrap: true,
                                  itemCount: controller.hDayTimeLateList.isEmpty
                                      ? controller.firestoreObj.dayLate?.length
                                      : controller.hDayTimeLateList.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        controller.hDayTimeLateList.isEmpty
                                            ? Row(
                                                children: [
                                                  SizedBox(
                                                    width: W * 0.25,
                                                    child: Text(
                                                        "•  ${controller.firestoreObj.dayLate?[index]['Hday2'].toString()}"),
                                                  ),
                                                  Text(
                                                      "   ${controller.firestoreObj.dayLate?[index]['HfromTime2'].toString()}   -"
                                                      "   ${controller.firestoreObj.dayLate?[index]['HtoTime2'].toString()}"),
                                                ],
                                              )
                                            : controller
                                                    .hDayTimeLateList.isNotEmpty
                                                ? Row(
                                                    children: [
                                                      SizedBox(
                                                        width: W * 0.25,
                                                        child: Text(
                                                            "•  ${controller.hDayTimeLateList[index]['Hday2']}"),
                                                      ),
                                                      Text(
                                                        "  ${controller.hDayTimeLateList[index]['HfromTime2']}   -"
                                                        "  ${controller.hDayTimeLateList[index]['HtoTime2']}",
                                                      ),
                                                    ],
                                                  )
                                                : const SizedBox(),
                                      ],
                                    );
                                  },
                                )
                              : const SizedBox(),

                          SizedBox(
                            height: H * 0.01,
                          ),

                          ///==============================================================================
                          Visibility(
                            visible: controller.lateFoodItems.isNotEmpty,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Late Happy Hour Food Items",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: primary),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.moveEditFoodItems();
                                      },
                                      child: Image.asset(
                                        "assets/icons/Group 11493@2x.png",
                                        height: H * 0.06,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        "Name",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "Quantity",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "Price/Discount",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ]),
                                SizedBox(
                                  height: H * 0.01,
                                ),
                                GridView.builder(
                                  physics: const ScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    //  mainAxisExtent: 1,
                                    childAspectRatio: 24 / 2,
                                    crossAxisCount: 1,
                                  ),
                                  shrinkWrap: true,
                                  itemCount: controller.lateFoodItems.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: W * 0.28,
                                          child: Text(controller
                                              .lateFoodItems[index].name),
                                        ),
                                        SizedBox(
                                          width: W * 0.23,
                                          child: Text(
                                              "•  ${controller.lateFoodItems[index].quantity}"),
                                        ),
                                        if (controller
                                                .lateFoodItems[index].price !=
                                            '')
                                          SizedBox(
                                            width: W * 0.25,
                                            child: Text(
                                              "•  \$${controller.lateFoodItems[index].price}",
                                            ),
                                          )
                                        else
                                          SizedBox(
                                            width: W * 0.25,
                                            child: Text(
                                              controller.lateFoodItems[index]
                                                          .discountIcon ==
                                                      "%"
                                                  ? "• ${controller.lateFoodItems[index].discount}% off"
                                                  : "• \$${controller.lateFoodItems[index].discount} off",
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: H * 0.01,
                                ),
                              ],
                            ),
                          ),

                          ///================================ late drink items ===================================
                          Visibility(
                            visible: controller.lateDrinkItems.isNotEmpty,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Late Happy Hour Drink Items",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: primary),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                          Routes.editDrinksScreen,
                                          arguments: controller.firestoreObj,
                                        );
                                      },
                                      child: Image.asset(
                                        "assets/icons/Group 11493@2x.png",
                                        height: H * 0.06,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      "Name ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "Size",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      "Price/Discount",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    // Text(
                                    //   "",
                                    //   style: TextStyle(
                                    //       fontSize: 16,
                                    //       fontWeight: FontWeight.w600),
                                    // ),
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
                                  itemCount: controller.lateDrinkItems.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: W * 0.28,
                                          child: Text(
                                            "•  ${controller.lateDrinkItems[index].name}",
                                          ),
                                        ),
                                        SizedBox(
                                          width: W * 0.23,
                                          child: Text(
                                            "•  ${controller.lateDrinkItems[index].size}${controller.lateDrinkItems[index].sizeicon}",
                                          ),
                                        ),
                                        if (controller
                                                .lateDrinkItems[index].price !=
                                            '')
                                          SizedBox(
                                            width: W * 0.25,
                                            child: Text(
                                              "•  \$${controller.lateDrinkItems[index].price}",
                                            ),
                                          )
                                        else
                                          SizedBox(
                                            width: W * 0.25,
                                            child: Text(
                                              controller.lateDrinkItems[index]
                                                          .discounticon ==
                                                      "%"
                                                  ? "• ${controller.lateDrinkItems[index].discount}% off"
                                                  : "• \$${controller.lateDrinkItems[index].discount} off",
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: H * 0.01,
                                ),
                              ],
                            ),
                          ),

                          /// added because of when both late and early happy hour are gone. then it will be shown for drink items
                          Visibility(
                            visible: (controller.earlyDrinkItems.isEmpty &&
                                controller.lateDrinkItems.isEmpty),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Add Drink Items",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: primary),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(Routes.editDrinksScreen,
                                        arguments: controller.firestoreObj);
                                  },
                                  child: Image.asset(
                                    "assets/icons/Group 11493@2x.png",
                                    height: H * 0.06,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: H * 0.01,
                          ),

                          ///================================ drink items ========================================

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Daily Specials",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: primary),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.editDailySpecialScreen,
                                      arguments: controller.firestoreObj);
                                },
                                child: Image.asset(
                                  "assets/icons/Group 11493@2x.png",
                                  height: H * 0.06,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Day",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "Name",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "Price",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "Size/Quantity",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "Discount",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
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
                              childAspectRatio: 10 / 2,
                              crossAxisCount: 1,
                            ),
                            shrinkWrap: true,
                            itemCount:
                                controller.firestoreObj.dailySpecils?.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                height: 50,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: W * 0.4,
                                      child: Text(
                                          "•${controller.firestoreObj.dailySpecils?[index]['day']}"),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: W * 0.3,
                                          child: Text(
                                              "•    ${controller.firestoreObj.dailySpecils?[index]['name']}"),
                                        ),
                                        SizedBox(
                                          width: W * 0.24,
                                          child: Text((controller.firestoreObj
                                                          .dailySpecils?[index]
                                                      ['price']) !=
                                                  ""
                                              ? "•  \$${controller.firestoreObj.dailySpecils?[index]['price']}"
                                              : ""),
                                        ),
                                        SizedBox(
                                          width: W * 0.2,
                                          child: controller.firestoreObj
                                                          .dailySpecils?[index]
                                                      ['index'] ==
                                                  'Foods'
                                              ? Text(
                                                  "•  ${controller.firestoreObj.dailySpecils?[index]['quantity']}")
                                              : Text(controller.firestoreObj
                                                              .dailySpecils?[
                                                          index]['index'] !=
                                                      "food"
                                                  ? "•  ${controller.firestoreObj.dailySpecils?[index]['quantity']} ${controller.firestoreObj.dailySpecils?[index]['sizeIcon']}"
                                                  : "•  ${controller.firestoreObj.dailySpecils?[index]['quantity']}"),
                                        ),
                                        SizedBox(
                                          width: W * 0.22,
                                          child: Text(
                                            controller.firestoreObj.dailySpecils?[
                                                                index]
                                                            ['discountIcon'] !=
                                                        null &&
                                                    controller.firestoreObj
                                                                    .dailySpecils?[
                                                                index]
                                                            ['discountIcon'] !=
                                                        "%"
                                                ? "• ${controller.firestoreObj.dailySpecils?[index]['discount'] == '' ? '' : controller.firestoreObj.dailySpecils?[index]['discountIcon']}${controller.firestoreObj.dailySpecils?[index]['discount']} off"
                                                : controller.firestoreObj
                                                                .dailySpecils?[
                                                            index]['discount'] ==
                                                        ''
                                                    ? ''
                                                    : "• ${controller.firestoreObj.dailySpecils?[index]['discount']}% off",
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const SizedBox(
                                          width: 70,
                                        ),
                                        Text(
                                          "${controller.firestoreObj.dailySpecils?[index]['fromTime']} -  ${controller.firestoreObj.dailySpecils?[index]['toTime']}",
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: H * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Amenities",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: primary),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.editAmenitiesScreen,
                                      arguments: controller.firestoreObj);
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
                            itemCount: controller.amentyAddList.length,
                            itemBuilder: (context, index) {
                              return Text(
                                "•  ${controller.amentyAddList[index]}",
                              );
                            },
                          ),
                          SizedBox(
                            height: H * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Bar Type",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: primary),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.editBarTypeScreen,
                                      arguments: controller.firestoreObj);
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
                                ? controller.firestoreObj.barType?.length
                                : controller.barTypeAddList.length,
                            itemBuilder: (context, index) {
                              return Text(controller.barTypeAddList.isEmpty
                                  ? "•  ${controller.firestoreObj.barType?[index]}"
                                  : "•  ${controller.barTypeAddList[index]}");
                            },
                          ),
                          SizedBox(
                            height: H * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Events",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: primary),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await controller
                                      .assignStartEventInEdit()
                                      .then((value) {});
                                },
                                child: Image.asset(
                                  "assets/icons/Group 11493@2x.png",
                                  height: H * 0.06,
                                ),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: controller.selectedEvent.isNotEmpty,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        "Name",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "Day",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "From",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "To",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
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
                                    crossAxisCount: 1,
                                  ),
                                  shrinkWrap: true,
                                  itemCount: controller.selectedEvent.isEmpty
                                      ? controller.firestoreObj.event?.length
                                      : controller.selectedEvent.length,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: W * 0.2,
                                          child: Text(
                                            controller.selectedEvent.isEmpty
                                                ? "•  ${controller.firestoreObj.event?[index]['name']}"
                                                : "•  ${controller.selectedEvent[index]['name']}",
                                          ),
                                        ),
                                        Text(controller.selectedEvent.isEmpty
                                            ? "•  ${controller.firestoreObj.event?[index]['day']}"
                                            : "•  ${controller.selectedEvent[index]['day']}"),
                                        Text(
                                          controller.selectedEvent.isEmpty
                                              ? "•  ${controller.firestoreObj.event?[index]['fromtime']}"
                                              : "•  ${controller.selectedEvent[index]['fromtime']}",
                                        ),
                                        Text(controller.selectedEvent.isEmpty
                                            ? "•  ${controller.firestoreObj.event?[index]['totime']}"
                                            : "•  ${controller.selectedEvent[index]['totime']}"),
                                      ],
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: H * 0.01,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Business Hours",
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: primary),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.editHourScreen,
                                      arguments: controller.firestoreObj);
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
                              childAspectRatio: 30 / 2,
                              crossAxisCount: 1,
                            ),
                            shrinkWrap: true,
                            itemCount: controller.selecteddays.isEmpty
                                ? controller.firestoreObj.fromTimeToTime?.length
                                : controller.selecteddays.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  controller.dayFromTimeToTimeList.isEmpty
                                      ? Row(
                                          children: [
                                            SizedBox(
                                              width: W * 0.25,
                                              child: Text(
                                                  "•  ${controller.firestoreObj.fromTimeToTime?[index]['bDay']}"),
                                            ),
                                            Text(
                                                "${controller.firestoreObj.fromTimeToTime?[index]['bFtime']}   -"
                                                "    ${controller.firestoreObj.fromTimeToTime?[index]['bTtime']}"),
                                          ],
                                        )
                                      : controller.selecteddays.isNotEmpty
                                          ? Row(
                                              children: [
                                                SizedBox(
                                                  width: W * 0.25,
                                                  child: Text(
                                                    "• ${controller.selecteddays[index]['bDay']}",
                                                  ),
                                                ),
                                                Text(
                                                    "${controller.selecteddays[index]['bFtime']}   -"
                                                    "  ${controller.selecteddays[index]['bTtime']}"),
                                              ],
                                            )
                                          : const SizedBox(),
                                ],
                              );
                            },
                          ),
                          SizedBox(
                            height: H * 0.03,
                          ),
                          controller.firestoreObj.id == ""
                              ? SizedBox(
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

                                      controller
                                          .updateBusinessHourToFireStore()
                                          .whenComplete(() {
                                        Get.toNamed(Routes.packagesScreen);
                                       // Get.toNamed(Routes.editHappyHourScreen);
                                      });

                                      // Get.back();
                                      // Get.back();
                                    },
                                    text: "Done",
                                    // textColor: blackColor,
                                    fontSize: 24,
                                    verticalPadding: 0,
                                    borderRadius: 45,
                                  ),
                                )
                              : const SizedBox(),
                        ],
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
