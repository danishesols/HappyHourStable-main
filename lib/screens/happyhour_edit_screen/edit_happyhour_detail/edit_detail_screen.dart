import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/colors.dart';
import 'package:happy_hour_app/global_widgets/happyhour_card.dart';
import 'package:happy_hour_app/screens/happyhour_detail_screen/happyhour_detail_screen.dart';
import 'package:happy_hour_app/screens/happyhour_edit_screen/edit_happyhour_detail/edit_detail_screen_controller.dart';
import 'package:intl/intl.dart';

import 'package:toggle_switch/toggle_switch.dart';

import '../../../core/constants.dart';
import '../edit_screens/edit_controller.dart';

class EditDetailScreen extends GetView<EditDetailScreenController> {
  const EditDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                SizedBox(
                  height: H * 0.25,
                  width: W * 1.2,
                  child: Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: controller.happyHour.businessImage != null &&
                                controller.happyHour.businessImage != ''
                            ? Image.network(
                                controller.happyHour.businessImage.toString(),
                                fit: BoxFit.fitWidth,
                              )
                            : Image.asset(
                                "assets/images/Rectangle 2698@2x.png",
                                fit: BoxFit.fitWidth,
                              ),
                      ),
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
                      // Positioned(
                      //   height: 50,
                      //   width: 50,
                      //   top: 10,
                      //   right: 80,
                      //   child: FavoriteButton(
                      //     hoursFavoriteModel: controller.hour,
                      //     size: 29,
                      //     cardPadding: 6,
                      //   ),
                      // ),
                      // Positioned(
                      //   height: 50,
                      //   width: 50,
                      //   top: 10,
                      //   right: 20,
                      //   child: InkWell(
                      //     onTap: () {
                      //       controller.onDirectionTap(
                      //           "https://www.google.com/maps/search/?api=1&query=${controller.happyHour.latitude},${controller.happyHour.longitude}");
                      //     },
                      //     child: Image.asset(
                      //       "assets/icons/Direction.png",
                      //       fit: BoxFit.cover,
                      //     ),

                      //   ),
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  height: H * 0.01,
                ),
                NewCard(
                  title: controller.happyHour.businessName.toString(),
                  subtitle: controller.happyHour.businessAddress.toString(),
                  isNetworkImage: controller.happyHour.businessLogo != null &&
                          controller.happyHour.businessLogo != ''
                      ? true
                      : false,
                  image: controller.happyHour.businessLogo != '' &&
                          controller.happyHour.businessLogo != null
                      ? controller.happyHour.businessLogo
                      : null,
                  timeIcon: "assets/icons/Group 11609@2x.png",
                  time: controller.happyHour.countList?.length.toString() ?? "",
                  rating: RatingBarIndicator(
                    unratedColor: Colors.grey.shade300,
                    direction: Axis.horizontal,
                    rating: 0,
                    itemCount: 5,
                    itemSize: 20,
                    itemBuilder: (context, index) => Image.asset(
                      "assets/icons/Path 602@2x.png",
                      height: 7,
                      width: 10,
                      color: primary,
                    ),
                  ),
                  rateCount: "",
                  // flag: Image.asset(
                  //   "assets/icons/Group 11615.png",
                  //   height: H * 0.06,
                  // ),
                  // share: GestureDetector(
                  //   onTap: () {
                  //     dialogueCard(context, "Claim This Business",
                  //         "Do you want to claim this business?", () {
                  //       Navigator.pop(context);
                  //       Get.toNamed(Routes.claimThisBusinessFormScreen,
                  //           arguments: controller.happyHour);
                  //     });

                  //   },
                  //   child: Image.asset(
                  //     "assets/icons/Group 11598.png",
                  //     height: H * 0.06,
                  //   ),
                  // ),
                  // flag: GestureDetector(
                  //   onTap: () {
                  //     controller.onAddreportTap();
                  //     // Get.toNamed(
                  //     //   Routes.reportScreen,
                  //     // );
                  //   },
                  //   child: Image.asset(
                  //     "assets/icons/Group 11614@2x.png",
                  //     height: H * 0.055,
                  //   ),
                  // ),
                ),
                SizedBox(height: H * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ToggleSwitch(
                        cornerRadius: 30,
                        minWidth: 120.0,
                        minHeight: 35.0,
                        fontSize: 16.0,
                        initialLabelIndex: 0,
                        activeBgColor: const [primary],
                        activeFgColor: Colors.black,
                        inactiveBgColor: bgColor,
                        inactiveFgColor: Colors.grey,
                        totalSwitches: 2,
                        labels: const ['Overview', 'Reviews'],
                        radiusStyle: true,
                        onToggle: (index) {
                          controller.switches = index;
                        },
                      ),
                    ),
                  ],
                ),
                Obx(
                  () => controller.switches == 0
                      ? const OverView()
                      : const Reviews(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Reviews extends GetView<EditDetailScreenController> {
  const Reviews({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: H * 0.036),
        // GestureDetector(
        //   onTap: () {
        //     // Get.toNamed(Routes.addReviewScreen,arguments:controller.happyHour.id );
        //     controller.onAddreviewTap();
        //   },
        //   child: Row(
        //     //Rating Images
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Image.asset("assets/icons/Path 601.png"),
        //       const SizedBox(
        //         width: 10,
        //       ),
        //       Image.asset("assets/icons/Path 601.png"),
        //       const SizedBox(
        //         width: 10,
        //       ),
        //       Image.asset("assets/icons/Path 601.png"),
        //       const SizedBox(
        //         width: 10,
        //       ),
        //       Image.asset("assets/icons/Path 601.png"),
        //       const SizedBox(
        //         width: 10,
        //       ),
        //       Image.asset("assets/icons/Path 605.png"),
        //     ],
        //   ),
        // ),
        SizedBox(height: H * 0.03),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "Reviews (${controller.happyHour.reviewStar?.length ?? 0}) ",
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: controller.happyHour.reviewStar?.reversed.length ?? 0,
          physics: const ScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: CustomReplyCard(
                subtitle: controller.happyHour.reviewStar?[index]['reviewText']
                        .toString() ??
                    "",
                image: "assets/icons/Group 8.png",
                time: "5421",
                rating: RatingBarIndicator(
                  unratedColor: Colors.grey.shade300,
                  direction: Axis.horizontal,
                  rating: controller.happyHour.reviewStar?[0]["stars"] ?? 0,
                  itemCount: 5,
                  itemSize: 20,
                  itemBuilder: (context, index) => Image.asset(
                    "assets/icons/Path 602@2x.png",
                    height: 7,
                    width: 10,
                    color: primary,
                  ),
                ),
                rateCount: DateFormat('dd/MM/yyyy').add_jm().format(
                      DateTime.parse(controller
                              .happyHour.reviewStar?[index]['reviewTime']
                              .toDate()
                              .toString() ??
                          ""),
                    ),
                replieImage: "assets/icons/Group 11550@2x.png",
                replieTitle: "Lorem Ipsum Business",
                replieTime: "03:00 PM 27/04/2022,",
                replieSubTitle:
                    "Lorem ipsum dolor sit amit Lorem ipsum sit \nLorem ipsum dolor sit amit Lorem ipsum sit",
              ),
            );
          },
        ),
      ],
    );
  }
}

class OverView extends GetView<EditController> {
  const OverView({
    Key? key,
  }) : super(key: key);

  _sectionTitle(String title) => Text(
        title,
        style: const TextStyle(
            fontSize: 17, fontWeight: FontWeight.w600, color: primary),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _sectionTitle("Description"),
          SizedBox(
            height: H * 0.01,
          ),
          Text(
            controller.descriptionController.text.toString() == ""
                ? controller.firestoreObj.description.toString()
                : controller.descriptionController.text.toString(),
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: H * 0.01,
          ),
          _sectionTitle("Happy Hour Menu"),
          SizedBox(
            height: H * 0.01,
          ),
          SizedBox(
            height: H * 0.25,
            width: W * 1.2,
            child: Swiper(
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
                    border: Border.all(width: 4, color: primary),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => DetailScreen(
                          isNetwork: true,
                          tag: "tag",
                          image: controller.menuImageList[i].toString()));
                    },
                    child: Image.network(
                      controller.menuImageList[i]!,
                      fit: BoxFit.cover,
                    ),
                  ),
                );

                //  Image.network(
                //   controller.imageList[index],
                //   // controller.happyHour.businessImage?.toString() ??
                //   //     controller.happyHour.menuImage.toString(),
                //   fit: BoxFit.fitWidth,
                // );
              },
            ),
          ),
          SizedBox(
            height: H * 0.01,
          ),
          const Text(
            "Happy Hour Times",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: primary),
          ),
          SizedBox(
            height: H * 0.02,
          ),
          Visibility(
            visible: controller.firestoreObj.day != null &&
                controller.firestoreObj.day!.isNotEmpty,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionTitle('Happy Hour Times'),
                SizedBox(
                  height: H * 0.01,
                ),
                GridView.builder(
                  physics: const ScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    //  mainAxisExtent: 1,
                    childAspectRatio: 30 / 2,
                    crossAxisCount: 1,
                  ),
                  shrinkWrap: true,
                  itemCount: controller.firestoreObj.day?.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
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
                        ),

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
                SizedBox(
                  height: H * 0.01,
                ),

                ///==============================================================================
                Visibility(
                  visible: controller.earlyFoodItems.isNotEmpty,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle("Happy Hour Food Items"),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Name",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Quantity",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Price/Discount",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              if (controller.earlyFoodItems[index].price != '')
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle("Happy Hour Drink Items"),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Name    ",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Size",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Price/Discount",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              if (controller.earlyDrinkItems[index].price != '')
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
                SizedBox(
                  height: H * 0.01,
                ),
              ],
            ),
          ),
          Visibility(
            visible: controller.firestoreObj.dayLate != null &&
                controller.firestoreObj.dayLate!.isNotEmpty,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionTitle("Late Happy Hour Times"),
                SizedBox(
                  height: H * 0.01,
                ),
                GridView.builder(
                  physics: const ScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 30 / 2,
                    crossAxisCount: 1,
                  ),
                  shrinkWrap: true,
                  itemCount: controller.firestoreObj.dayLate?.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
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
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: H * 0.01,
                ),

                ///==============================================================================
                Visibility(
                  visible: controller.lateFoodItems.isNotEmpty,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle("Late Happy Hour Food Items"),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Price/Discount",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: W * 0.28,
                                child:
                                    Text(controller.lateFoodItems[index].name),
                              ),
                              SizedBox(
                                width: W * 0.23,
                                child: Text(
                                    "•  ${controller.lateFoodItems[index].quantity}"),
                              ),
                              if (controller.lateFoodItems[index].price != '')
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
                      _sectionTitle("Late Happy Hour Drink Items"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Name ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Size",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Price/Discount",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              if (controller.lateDrinkItems[index].price != '')
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
              ],
            ),
          ),
          SizedBox(
            height: H * 0.01,
          ),
          Visibility(
            visible: controller.firestoreObj.dailySpecils != null &&
                controller.firestoreObj.dailySpecils!.isNotEmpty,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionTitle("Daily Specials"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Day",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Name",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Price",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Size/Quantity",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Discount",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: H * 0.01,
                ),
                GridView.builder(
                  physics: const ScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 10 / 2,
                    crossAxisCount: 1,
                  ),
                  shrinkWrap: true,
                  itemCount: controller.firestoreObj.dailySpecils?.length,
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
                                child: Text((controller
                                    .firestoreObj
                                    .dailySpecils?[
                                index]['price']) !=
                                    ""
                                    ? "•  \$${controller.firestoreObj.dailySpecils?[index]['price']}"
                                    : ""),
                              ),
                              SizedBox(
                                width: W * 0.2,
                                child: controller.firestoreObj
                                    .dailySpecils?[
                                index]['index'] ==
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
                                  index][
                                  'discountIcon'] !=
                                      null &&
                                      controller.firestoreObj
                                          .dailySpecils?[
                                      index][
                                      'discountIcon'] !=
                                          "%"
                                      ? "• ${controller.firestoreObj.dailySpecils?[index]['discount'] == '' ? '' : controller.firestoreObj.dailySpecils?[index]['discountIcon']}${controller.firestoreObj.dailySpecils?[index]['discount']} off"
                                      : controller.firestoreObj
                                      .dailySpecils?[
                                  index]
                                  ['discount'] ==
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
              ],
            ),
          ),
          SizedBox(
            height: H * 0.01,
          ),
          Visibility(
            visible: controller.firestoreObj.amenities != null &&
                controller.firestoreObj.amenities!.isNotEmpty,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionTitle("Amenities"),
                SizedBox(
                  height: H * 0.01,
                ),
                GridView.builder(
                  physics: const ScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    //  mainAxisExtent: 1,
                    childAspectRatio: 16 / 2,
                    crossAxisCount: 2,
                  ),
                  shrinkWrap: true,
                  itemCount: controller.amentyAddList.isEmpty
                      ? controller.firestoreObj.amenities?.length
                      : controller.amentyAddList.length,
                  itemBuilder: (context, index) {
                    return Text(
                      controller.amentyAddList.isEmpty
                          ? "•  ${controller.firestoreObj.amenities?[index]}"
                          : "•  ${controller.amentyAddList[index]}",
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: H * 0.01,
          ),
          Visibility(
            visible: controller.firestoreObj.barType != null &&
                controller.firestoreObj.barType!.isNotEmpty,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionTitle("Bar Type"),
                SizedBox(
                  height: H * 0.01,
                ),
                GridView.builder(
                  physics: const ScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
              ],
            ),
          ),
          SizedBox(
            height: H * 0.01,
          ),
          Visibility(
            visible: controller.firestoreObj.event != null &&
                controller.firestoreObj.event!.isNotEmpty,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionTitle("Events"),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Name",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Day",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "From",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "To",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: H * 0.01,
                ),
                GridView.builder(
                  physics: const ScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              ],
            ),
          ),
          SizedBox(
            height: H * 0.01,
          ),
          Visibility(
            visible: controller.firestoreObj.fromTimeToTime != null &&
                controller.firestoreObj.fromTimeToTime!.isNotEmpty,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionTitle("Business Hours"),
                SizedBox(
                  height: H * 0.01,
                ),
                GridView.builder(
                  physics: const ScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                                            "• ${controller.selecteddays[index]['bDay']}"),
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
              ],
            ),
          ),
          SizedBox(
            height: H * 0.03,
          ),
        ],
      ),
    );
  }
}

// class OverView extends GetView<BusinessHappyhourDetailScreenController> {
//   const OverView({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           SizedBox(
//             height: H * 0.01,
//           ),
//           const Text(
//             "Happy Hour Times",
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//           ),
//           SizedBox(
//             height: H * 0.01,
//           ),
//           GridView.builder(
//             physics: const ScrollPhysics(),
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               childAspectRatio: 16 / 2,
//               crossAxisCount: 1,
//             ),
//             shrinkWrap: true,
//             itemCount: controller.happyHour.day?.length ?? 0,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: SizedBox(
//                   child: Row(
//                     children: [
//                       SizedBox(
//                         width: W * 0.44,
//                         child: Text(
//                             "• ${controller.happyHour.day?[index]['Hday'].toString()}"),
//                       ),
//                       Column(
//                         children: [
//                           Text(
//                               "${controller.happyHour.day?[index]['HfromTime'].toString()} - ${controller.happyHour.day?[index]['HtoTime'].toString()}"),
//                           const SizedBox(
//                             height: 5,
//                           ),
//                           Text(controller.happyHour.day?[index]['htoTime2'] !=
//                                   null
//                               ? "${controller.happyHour.day?[index]['hfromTime2'].toString()} - ${controller.happyHour.day?[index]['htoTime2'].toString()}"
//                               : ""),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//           const Text(
//             "Description",
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//           ),
//           SizedBox(
//             height: H * 0.01,
//           ),
//           Text(
//             controller.happyHour.description ?? "",
//             textAlign: TextAlign.left,
//             // overflow: TextOverflow.ellipsis,
//             //softWrap: false,
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
//           ),
//           SizedBox(
//             height: H * 0.01,
//           ),
//           const Text(
//             "Happy Hour Menu",
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//           ),
//           SizedBox(
//             height: H * 0.01,
//           ),
//           GestureDetector(
//             onTap: () {
//               Get.to(() => DetailScreen(
//                   tag: "tag",
//                   image: controller.happyHour.menuImage.toString()));
//             },
//             child: Container(
//               height: H * 0.3,
//               width: W,
//               decoration: BoxDecoration(
//                 border: Border.all(width: 4, color: primary),
//               ),
//               child: Image.network(
//                 controller.happyHour.menuImage.toString(),
//                 fit: BoxFit.cover,
//               ),

//               // InteractiveViewer(
//               //   panEnabled: false,
//               //   clipBehavior: Clip.none,
//               //   minScale: 1,
//               //   maxScale: 4,
//               //   child: AspectRatio(
//               //     aspectRatio: 1,
//               //     child: ClipRRect(
//               //       child: Hero(
//               //         tag: "Image Hero",
//               //         child: Image.network(
//               //           controller.happyHour.menuImage.toString(),
//               //           fit: BoxFit.cover,
//               //         ),
//               //       ),
//               //     ),
//               //   ),
//               // ),
//             ),
//           ),
//           // Image.network(controller.happyHour.menuImage.toString()),
//           //  SizedBox(
//           //     width: W,
//           //     height: H * 0.3,
//           //     child: PhotoView(
//           //       initialScale: PhotoViewComputedScale.covered,
//           //       imageProvider: NetworkImage(
//           //         (controller.happyHour.menuImage),
//           //       ),
//           //     ),
//           //   ),
//           SizedBox(
//             height: H * 0.02,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: const [
//               Text(
//                 "Food Items",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//               ),
//               Text(
//                 "Quantity",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//               ),
//               Text(
//                 "Price/Discount",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: H * 0.01,
//           ),
//           ListView.builder(
//             physics: const ScrollPhysics(),
//             shrinkWrap: true,
//             itemCount: controller.happyHour.foodName?.length ?? 0,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     SizedBox(
//                       width: W * 0.32,
//                       child: Text(
//                         "• ${controller.happyHour.foodName?[index]["foodname"]}",
//                         maxLines: 1,
//                       ),
//                     ),
//                     SizedBox(
//                       width: W * 0.25,
//                       child: Text(
//                           "• ${controller.happyHour.foodName?[index]["fooddiscount"]}"),
//                     ),
//                     SizedBox(
//                       width: W * 0.2,
//                       child: Text("${controller.happyHour.foodName?[index]["foodprice"]}" !=
//                               ""
//                           ? "• \$ ${controller.happyHour.foodName?[index]["foodprice"]}"
//                           : "• \$ ${controller.happyHour.foodName?[index]["foodcount"]}"),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//           SizedBox(
//             height: H * 0.01,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: const [
//               Text(
//                 "Drinks ",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//               ),
//               Text(
//                 "   Size",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//               ),
//               Text(
//                 "Price/Discount",
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: H * 0.01,
//           ),
//           ListView.builder(
//             physics: const ScrollPhysics(),
//             shrinkWrap: true,
//             itemCount: controller.happyHour.drinkitemName?.length ?? 0,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     SizedBox(
//                       width: W * 0.3,
//                       child: Text(
//                         "• ${controller.happyHour.drinkitemName?[index]['drinkname']}",
//                         maxLines: 1,
//                       ),
//                     ),
//                     SizedBox(
//                       width: W * 0.25,
//                       child: Text(
//                           "• ${controller.happyHour.drinkitemName?[index]['drinksize']}"),
//                     ),
//                     SizedBox(
//                       width: W * 0.2,
//                       child: Text("${controller.happyHour.drinkitemName?[index]['drinkprice']}" !=
//                               ""
//                           ? "• \$ ${controller.happyHour.drinkitemName?[index]['drinkprice']}"
//                           : "• \$ ${controller.happyHour.drinkitemName?[index]['drinkdiscount']}"),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//           SizedBox(
//             height: H * 0.01,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: const [
//               Text(
//                 "Daily Specials",
//                 style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//               ),
//               Text(
//                 "Quantity/Size",
//                 style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//               ),
//               Text(
//                 "Price/Discount",
//                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//               ),
//             ],
//           ),

//           SizedBox(
//             height: H * 0.01,
//           ),
//           ListView.builder(
//             physics: const ScrollPhysics(),
//             shrinkWrap: true,
//             itemCount: controller.happyHour.dailySpecils?.length ?? 0,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     SizedBox(
//                       width: W * 0.32,
//                       child: Text(
//                         "• ${controller.happyHour.dailySpecils?[index]['name']}",
//                         maxLines: 1,
//                       ),
//                     ),
//                     SizedBox(
//                       width: W * 0.25,
//                       child: Text(
//                         "• ${controller.happyHour.dailySpecils?[index]['quantity']}",
//                         maxLines: 1,
//                       ),
//                     ),
//                     SizedBox(
//                       width: W * 0.2,
//                       child: Text(
//                         "${controller.happyHour.dailySpecils?[index]['price']}" !=
//                                 ""
//                             ? "• ${controller.happyHour.dailySpecils?[index]['price']}"
//                             : "• ${controller.happyHour.dailySpecils?[index]['quantity']}",
//                         maxLines: 1,
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),

//           SizedBox(
//             height: H * 0.01,
//           ),
//           const Text(
//             "Amenities",
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//           ),
//           SizedBox(
//             height: H * 0.01,
//           ),
//           GridView.builder(
//             physics: const ScrollPhysics(),
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               //  mainAxisExtent: 1,
//               childAspectRatio: 16 / 2,
//               crossAxisCount: 2,
//             ),
//             shrinkWrap: true,
//             itemCount: controller.happyHour.amenities?.length ?? 0,
//             itemBuilder: (context, index) {
//               return Text("• ${controller.happyHour.amenities?[index]}");
//             },
//           ),

//           SizedBox(
//             height: H * 0.01,
//           ),
//           const Text(
//             "Bar-Types",
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//           ),
//           SizedBox(
//             height: H * 0.01,
//           ),
//           GridView.builder(
//             physics: const ScrollPhysics(),
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               //  mainAxisExtent: 1,
//               childAspectRatio: 16 / 2,
//               crossAxisCount: 2,
//             ),
//             shrinkWrap: true,
//             itemCount: controller.happyHour.barType?.length ?? 0,
//             itemBuilder: (context, index) {
//               return Text("•  ${controller.happyHour.barType?[index]}");
//             },
//           ),

//           SizedBox(
//             height: H * 0.01,
//           ),
//           const Text(
//             "Events",
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//           ),
//           SizedBox(
//             height: H * 0.01,
//           ),
//           GridView.builder(
//             physics: const ScrollPhysics(),
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               //  mainAxisExtent: 1,
//               childAspectRatio: 16 / 2,
//               crossAxisCount: 2,
//             ),
//             shrinkWrap: true,
//             itemCount: controller.happyHour.event?.length ?? 0,
//             itemBuilder: (context, index) {
//               return Text("• ${controller.happyHour.event?[index]['name']}");
//             },
//           ),

//           SizedBox(
//             height: H * 0.01,
//           ),
//           const Text(
//             "Business Times",
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//           ),
//           SizedBox(
//             height: H * 0.01,
//           ),
//           ListView.builder(
//             physics: const ScrollPhysics(),
//             shrinkWrap: true,
//             itemCount: controller.happyHour.fromTimeToTime?.length ?? 0,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: Row(
//                   children: [
//                     SizedBox(
//                       width: W * 0.26,
//                       child: Text(
//                           "• ${controller.happyHour.fromTimeToTime?[index]['bDay'].toString()}  "),
//                     ),
//                     Text(
//                         "  ${controller.happyHour.fromTimeToTime?[index]['bFtime'].toString()} - ${controller.happyHour.fromTimeToTime?[index]['bTtime'].toString()}")
//                   ],
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

class CustomReplyCard extends GetView<EditDetailScreenController> {
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
    //Rape it with obx when Show Reply textfield
    return GestureDetector(
      onTap: () {
        // controller.isShow = !controller.isShow;
      },
      child: Card(
        elevation: 5,
        color: whiteColor,
        shadowColor: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                        // SvgPicture.asset(
                        //   rating,
                        //   height: H * 0.015,
                        // ),
                        // const SizedBox(
                        //   width: 10,
                        // ),
                        // SvgPicture.asset(
                        //   rating,
                        //   height: H * 0.015,
                        // ),
                        // const SizedBox(
                        //   width: 10,
                        // ),
                        // SvgPicture.asset(
                        //   rating,
                        //   height: H * 0.015,
                        // ),
                        // const SizedBox(
                        //   width: 10,
                        // ),
                        // SvgPicture.asset(
                        //   rating,
                        //   height: H * 0.015,
                        // ),
                        // const SizedBox(
                        //   width: 10,
                        // ),
                        // SvgPicture.asset(
                        //   rating,
                        //   height: H * 0.015,
                        // ),
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
              //Reply Card Will be Show After discomment this
              // visible: controller.isShow,
              visible: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0, bottom: 12.0),
                    child: Text("Replies"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, bottom: 16.0),
                    child: Container(
                      height: H * 0.1,
                      width: W,
                      decoration: BoxDecoration(
                          color: const Color(0xFFF5F4F4),
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: W * 0.14,
                              // child: SvgPicture.asset(image),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: bgColor,
                                  image: DecorationImage(
                                      image: AssetImage(replieImage ?? ""))),
                            ),
                          ),
                          SizedBox(
                            width: W * 0.020,
                          ),
                          SizedBox(
                            width: W * 0.7,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 16.0, left: 0, right: 8),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        replieTitle ?? "",
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        replieTime ?? "",
                                        style: const TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: H * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        replieSubTitle ?? "",
                                        maxLines: 4,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
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
          ],
        ),
      ),
    );
  }
}

Future<dynamic> dialogueCard(
  BuildContext context,
  String title,
  String middleText,
  VoidCallback onConfrim,
) {
  return showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: SizedBox(
          height: H * 0.3,
          width: W * 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: H * 0.03,
              ),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: H * 0.045,
              ),
              Center(
                child: Text(
                  middleText,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(
                height: H * 0.045,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Colors.black, width: 0.5),
                            borderRadius: BorderRadius.circular(35),
                          ),
                          minimumSize: Size(W * 0.32, H * 0.072),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          Get.back();
                        }),
                    SizedBox(
                      width: W * 0.03,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35),
                        ),
                        minimumSize: Size(W * 0.32, H * 0.072),
                      ),
                      onPressed: onConfrim,
                      child: const Text(
                        'Yes',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
