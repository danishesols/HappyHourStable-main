import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/colors.dart';
import 'package:happy_hour_app/global_controller/auth_controller.dart';
import 'package:happy_hour_app/global_widgets/happyhour_card.dart';
import 'package:happy_hour_app/screens/happyhour_detail_screen/happyhour_detail_screen.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../../core/constants.dart';
import '../../../global_widgets/favorite_happyhour.dart';
import '../../../routes/app_routes.dart';
import '../../account_standard/standard_happyhour_detail/standard_happyhour_detail_screen.dart';
import '../../account_standard/standard_happyhour_detail/standard_happyhour_detail_screen_controller.dart';
import '../claim_report/claim_report_screen.dart';
import 'business_happyhour_detail_screen_controller.dart';

class BusinessHappyHourDetailScreen
    extends GetView<BusinessHappyhourDetailScreenController> {
  const BusinessHappyHourDetailScreen({Key? key}) : super(key: key);

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
                            ? PinchZoom(
                              child: Image.network(
                                  controller.happyHour.businessImage.toString(),
                                  fit: BoxFit.fitWidth,
                                ),
                            )
                            : PinchZoom(
                              child: Image.asset(
                                  "assets/images/Rectangle 2698@2x.png",
                                  fit: BoxFit.fitWidth,
                                ),
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
                      Positioned(
                        height: 50,
                        width: 50,
                        top: 10,
                        right: 80,
                        child: FavoriteButton(
                          hoursFavoriteModel: controller.hour,
                          size: 29,
                          cardPadding: 6,
                        ),
                      ),
                      Positioned(
                        height: 50,
                        width: 50,
                        top: 10,
                        right: 20,
                        child: InkWell(
                          onTap: () {
                            controller.onDirectionTap(
                                "https://www.google.com/maps/search/?api=1&query=${controller.happyHour.latitude},${controller.happyHour.longitude}");
                          },
                          child: Image.asset(
                            "assets/icons/Direction.png",
                            fit: BoxFit.cover,
                          ),
                          // Container(
                          //   decoration: const BoxDecoration(
                          //     color: whiteColor,
                          //     shape: BoxShape.circle,
                          //     image: DecorationImage(
                          //       image: AssetImage("assets/icons/Direction.png"),
                          //       fit: BoxFit.cover,
                          //     ),
                          //     // child: Image.asset(
                          //     //   "assets/icons/Groupshare.jpg",

                          //     //   // fit: BoxFit.cover,
                          //     // ),
                          //   ),
                          // ),
                        ),
                      ),
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
                  image: controller.happyHour.businessLogo != null &&
                          controller.happyHour.businessLogo != ''
                      ? controller.happyHour.businessLogo!
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
                  share: controller.happyHour.id !=
                          Get.find<AuthController>().user.uid
                      ? GestureDetector(
                          onTap: () {
                            print(controller.happyHour.hid);
                            print(Get.find<AuthController>().user.uid);
                            controller.happyHour.id != ""
                                ? dialogueCard(
                                    context,
                                    "Claim This Business",
                                    "This Happy Hour is already claimed by another business.If you want to claim this Happy Hour claim it here.",
                                    "Claim", () async {
                                    await Get.to(() => ClaimReportScreen(
                                          hourId:
                                              controller.happyHour.hid ?? '',
                                        ));
                                  })
                                : dialogueCard(
                                    context,
                                    "Claim This Business",
                                    "Do you want to claim this business?",
                                    "Yes", () {
                                    Get.toNamed(
                                        Routes.claimThisBusinessFormScreen,
                                        arguments: controller.happyHour);
                                  });
                          },
                          child: Image.asset(
                            "assets/icons/Group 11598.png",
                            height: H * 0.06,
                          ),
                        )
                      : const SizedBox(
                          width: 20,
                        ),
                  flag: controller.happyHour.id !=
                          Get.find<AuthController>().user.uid
                      ? GestureDetector(
                          onTap: () {
                            controller.onAddreportTap();
                          },
                          child: Image.asset(
                            "assets/icons/Group 11614@2x.png",
                            height: H * 0.055,
                          ),
                        )
                      : const SizedBox(),
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

class Reviews extends GetView<BusinessHappyhourDetailScreenController> {
  const Reviews({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => StandardHappyhourDetailScreenController());
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: H * 0.036),
        GestureDetector(
          onTap: () {
            // Get.toNamed(Routes.addReviewScreen,arguments:controller.happyHour.id );
            controller.onAddreviewTap();
          },
          child: Row(
            //Rating Images
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/icons/Path 601.png"),
              const SizedBox(
                width: 10,
              ),
              Image.asset("assets/icons/Path 601.png"),
              const SizedBox(
                width: 10,
              ),
              Image.asset("assets/icons/Path 601.png"),
              const SizedBox(
                width: 10,
              ),
              Image.asset("assets/icons/Path 601.png"),
              const SizedBox(
                width: 10,
              ),
              Image.asset("assets/icons/Path 605.png"),
            ],
          ),
        ),
        SizedBox(height: H * 0.03),
        ShowReviews(
          hourId: controller.happyHour.id!,
          isBusinessReplyScreen: false,
        ),
      ],
    );
  }
}

class OverView extends GetView<BusinessHappyhourDetailScreenController> {
  const OverView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            "Description",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: primary,
            ),
          ),

          Text(
            controller.happyHour.description ?? "",
            textAlign: TextAlign.left,
            // overflow: TextOverflow.ellipsis,
            //softWrap: false,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: H * 0.01,
          ),
          const Text(
            "Happy Hour Menu",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: primary,
            ),
          ),
          SizedBox(
            height: H * 0.01,
          ),
          SizedBox(
            height: H * 0.25,
            width: W * 1.2,
            child: Swiper(
              //physics: const NeverScrollableScrollPhysics(),
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
                      controller.menuImageList[i],
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
          // GestureDetector(
          //   onTap: () {
          //     Get.to(() => DetailScreen(
          //         tag: "tag",
          //         image: controller.happyHour.menuImage.toString()));
          //   },
          //   child: Container(
          //     height: H * 0.3,
          //     width: W,
          //     decoration: BoxDecoration(
          //       border: Border.all(width: 4, color: primary),
          //     ),
          //     child: Image.network(
          //       controller.happyHour.menuImage.toString(),
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          SizedBox(
            height: H * 0.01,
          ),
          Visibility(
            visible: controller.happyHour.day != null &&
                controller.happyHour.day!.isNotEmpty,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionTitle('Happy Hour Times'),
                ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.happyHour.day?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SizedBox(
                        child: Row(
                          children: [
                            SizedBox(
                              width: W * 0.44,
                              child: Text(
                                  "• ${controller.happyHour.day?[index]['Hday'].toString()}"),
                            ),
                            Text(
                                "${controller.happyHour.day?[index]['HfromTime'].toString()} - ${controller.happyHour.day?[index]['HtoTime'].toString()}"),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: H * 0.02,
                ),
                Visibility(
                  visible: controller.earlyFoodList.isNotEmpty,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle('Happy Hour Food Items'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Food Items",
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
                        ],
                      ),
                      SizedBox(
                        height: H * 0.01,
                      ),
                      ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.earlyFoodList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: W * 0.32,
                                  child: Text(
                                    "• ${controller.earlyFoodList[index]["foodname"]}",
                                    maxLines: 1,
                                  ),
                                ),
                                SizedBox(
                                  width: W * 0.25,
                                  child: Text(
                                      "• ${controller.earlyFoodList[index]["foodcount"]}"),
                                ),
                                SizedBox(
                                  width: W * 0.2,
                                  child: Text(controller.earlyFoodList[index]
                                              ["foodprice"] !=
                                          ""
                                      ? "• \$${controller.earlyFoodList[index]["foodprice"]}"
                                      : controller.earlyFoodList[index]
                                                  ["discountIcon"] ==
                                              "%"
                                          ? "• ${controller.earlyFoodList[index]["fooddiscount"]}${controller.earlyFoodList[index]["discountIcon"]} off"
                                          : "• \$${controller.earlyFoodList[index]["fooddiscount"]} off"),
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
                  height: H * 0.02,
                ),
                Visibility(
                  visible: controller.earlyDrinkList.isNotEmpty,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle('Happy Hour Drink Items'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Drinks ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "   Size",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Price/Discount",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: H * 0.01,
                      ),
                      ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.earlyDrinkList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: W * 0.3,
                                  child: Text(
                                    "• ${controller.earlyDrinkList[index]['drinkname']}",
                                    maxLines: 1,
                                  ),
                                ),
                                SizedBox(
                                  width: W * 0.25,
                                  child: Text(controller.earlyDrinkList[index]
                                              ['sizeIcon'] ==
                                          ""
                                      ? "• ${controller.earlyDrinkList[index]['drinksize']}  oz"
                                      : "• ${controller.earlyDrinkList[index]['drinksize']}  ${controller.earlyDrinkList[index]['sizeIcon']}"),
                                ),
                                SizedBox(
                                  width: W * 0.2,
                                  child: Text(
                                    controller.earlyDrinkList[index]
                                                ['drinkprice'] !=
                                            ""
                                        ? "• \$${controller.earlyDrinkList[index]['drinkprice']}"
                                        : controller.earlyDrinkList[index]
                                                    ['discountIcon'] ==
                                                ""
                                            ? "•  ${controller.earlyDrinkList[index]['drinkdiscount']} % off"
                                            : controller.earlyDrinkList[index]
                                                        ['discountIcon'] ==
                                                    "%"
                                                ? "•  ${controller.earlyDrinkList[index]['drinkdiscount']}"
                                                    "${controller.earlyDrinkList[index]['discountIcon']} off"
                                                : "•  \$"
                                                    "${controller.earlyDrinkList[index]['drinkdiscount']} off",
                                  ),
                                ),
                              ],
                            ),
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

          Visibility(
            visible: controller.happyHour.dayLate != null &&
                controller.happyHour.dayLate!.isNotEmpty,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionTitle('Late Happy Hour Times'),
                ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.happyHour.dayLate?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SizedBox(
                        child: Row(
                          children: [
                            SizedBox(
                              width: W * 0.44,
                              child: Text(
                                  "• ${controller.happyHour.dayLate?[index]['Hday2'].toString()}"),
                            ),
                            Text(
                                "${controller.happyHour.dayLate?[index]['HfromTime2'].toString()} - ${controller.happyHour.dayLate?[index]['HtoTime2'].toString()}"),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: H * 0.01,
                ),
                Visibility(
                  visible: controller.lateFoodList.isNotEmpty,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle("Late Happy Hour Food Items"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Food Items",
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
                        ],
                      ),
                      ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.lateFoodList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: W * 0.32,
                                  child: Text(
                                    "• ${controller.lateFoodList[index]["foodname"]}",
                                    maxLines: 1,
                                  ),
                                ),
                                SizedBox(
                                  width: W * 0.25,
                                  child: Text(
                                      "• ${controller.lateFoodList[index]["foodcount"]}"),
                                ),
                                SizedBox(
                                  width: W * 0.2,
                                  child: Text(controller.lateFoodList[index]
                                              ["foodprice"] !=
                                          ""
                                      ? "• \$${controller.lateFoodList[index]["foodprice"]}"
                                      : controller.lateFoodList[index]
                                                  ["discountIcon"] ==
                                              "%"
                                          ? "• ${controller.lateFoodList[index]["fooddiscount"]}${controller.lateFoodList[index]["discountIcon"]} off"
                                          : "• \$${controller.lateFoodList[index]["fooddiscount"]} off"),
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
                  visible: controller.lateDrinkList.isNotEmpty,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle("Late Happy Hour Drink Items"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Drinks ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "   Size",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Price/Discount",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.lateDrinkList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: W * 0.32,
                                  child: Text(
                                    "• ${controller.lateDrinkList[index]["drinkname"]}",
                                    maxLines: 1,
                                  ),
                                ),
                                SizedBox(
                                  width: W * 0.25,
                                  child: Text(controller.lateDrinkList[index]
                                              ["sizeIcon"] ==
                                          ""
                                      ? "• ${controller.lateDrinkList[index]["drinksize"]} oz"
                                      : "• ${controller.lateDrinkList[index]["drinksize"]}${controller.lateDrinkList[index]["sizeIcon"]}"),
                                ),
                                SizedBox(
                                  width: W * 0.2,
                                  child: Text(controller.lateDrinkList[index]
                                              ["drinkprice"] !=
                                          ""
                                      ? "• \$ ${controller.lateDrinkList[index]["drinkprice"]}"
                                      : controller.lateDrinkList[index]
                                                  ["discountIcon"] ==
                                              "%"
                                          ? "•  ${controller.lateDrinkList[index]["drinkdiscount"]}${controller.lateDrinkList[index]["discountIcon"]} off"
                                          : "•  \$${controller.lateDrinkList[index]["drinkdiscount"]} off"),
                                ),
                              ],
                            ),
                          );
                        },
                      )
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
            visible: !controller.makeDailySpecialVisible(),
            child: _sectionTitle('Daily Specials'),
          ),
          //Sunday List
          controller.sundayList.isNotEmpty
              ? Text(
                  "${controller.sundayList.first['day']}",
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                  maxLines: 1,
                )
              : const SizedBox(),
          controller.sundayList.isNotEmpty
              ? SizedBox(
                  height: H * 0.01,
                )
              : const SizedBox(),
          controller.sundayList.isNotEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Item Name",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Quantity",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Size",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Price",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Discount",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              : const SizedBox(),
          controller.sundayList.isNotEmpty
              ? SizedBox(
                  height: H * 0.01,
                )
              : const SizedBox(),
          controller.sundayList.isNotEmpty
              ? ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.sundayList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: H * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: W * 0.26,
                                child: Text(
                                  "• ${controller.sundayList[index]['name']}",
                                  maxLines: 2,
                                ),
                              ),
                              SizedBox(
                                width: W * 0.15,
                                child: Text(
                                  controller.sundayList[index]['index'] ==
                                          "Foods"
                                      ? "  ${controller.sundayList[index]['quantity']}"
                                      : "",
                                  maxLines: 1,
                                ),
                              ),
                              SizedBox(
                                width: W * 0.19,
                                child: Row(
                                  children: [
                                    Text(
                                      controller.sundayList[index]['index'] ==
                                              "Drinks"
                                          ? "${controller.sundayList[index]['quantity']} "
                                          : "",
                                      maxLines: 1,
                                    ),
                                    controller.sundayList[index]['index'] ==
                                            "Drinks"
                                        ? Expanded(
                                            flex: 1,
                                            child: Text(
                                              controller.sundayList[index]
                                                          ['sizeIcon'] ==
                                                      null
                                                  ? "ml"
                                                  : "${controller.sundayList[index]['sizeIcon']}",
                                              maxLines: 1,
                                              softWrap: false,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                        : const Text(""),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: W * 0.14,
                                child: Text(
                                  controller.sundayList[index]['price'] != ""
                                      ? "\$${controller.sundayList[index]['price']}"
                                      : "",
                                  maxLines: 1,
                                ),
                              ),
                              SizedBox(
                                width: W * 0.14,
                                child: controller.sundayList[index]
                                            ['discountIcon'] ==
                                        "%"
                                    ? Text(
                                        controller.sundayList[index]
                                                    ['discount'] !=
                                                ""
                                            ? "${controller.sundayList[index]['discount']}${controller.sundayList[index]['discountIcon']} off"
                                            : "",
                                        maxLines: 2,
                                      )
                                    : Text(
                                        controller.sundayList[index]
                                                    ['discount'] !=
                                                ""
                                            ? "\$${controller.sundayList[index]['discount']} off"
                                            : "",
                                        maxLines: 2,
                                      ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: H * 0.015,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(
                                width: 70,
                              ),
                              Text(
                                "${controller.sundayList[index]['fromTime']} -  ${controller.sundayList[index]['toTime']}",
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                )
              : const SizedBox(),

          //Monday List
          controller.mondayList.isNotEmpty
              ? Text(
                  "${controller.mondayList.first['day']}",
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                  maxLines: 1,
                )
              : const SizedBox(),
          controller.mondayList.isNotEmpty
              ? SizedBox(
                  height: H * 0.01,
                )
              : const SizedBox(),
          controller.mondayList.isNotEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Item Name",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Quantity",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Size",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Price",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Discount",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              : const SizedBox(),
          controller.mondayList.isNotEmpty
              ? SizedBox(
                  height: H * 0.01,
                )
              : const SizedBox(),
          controller.mondayList.isNotEmpty
              ? ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.mondayList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: W * 0.26,
                                child: Text(
                                  "• ${controller.mondayList[index]['name']}",
                                  maxLines: 2,
                                ),
                              ),
                              SizedBox(
                                width: W * 0.15,
                                child: Text(
                                  controller.mondayList[index]['index'] ==
                                          "Foods"
                                      ? "  ${controller.mondayList[index]['quantity']}"
                                      : "",
                                  maxLines: 2,
                                ),
                              ),
                              SizedBox(
                                width: W * 0.19,
                                child: Row(
                                  children: [
                                    Text(
                                      controller.mondayList[index]['index'] ==
                                              "Drinks"
                                          ? "${controller.mondayList[index]['quantity']} "
                                          : "",
                                      maxLines: 2,
                                    ),
                                    controller.mondayList[index]['index'] ==
                                            "Drinks"
                                        ? Expanded(
                                            flex: 1,
                                            child: Text(
                                              controller.mondayList[index]
                                                          ['sizeIcon'] ==
                                                      null
                                                  ? "ml"
                                                  : "${controller.mondayList[index]['sizeIcon']}",
                                              maxLines: 2,
                                              softWrap: false,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                        : const Text(""),
                                  ],
                                ),
                              ),

                              SizedBox(
                                width: W * 0.14,
                                child: Text(
                                  controller.mondayList[index]['price'] != ""
                                      ? "\$${controller.mondayList[index]['price']}"
                                      : "",
                                  maxLines: 2,
                                ),
                              ),
                              // SizedBox(
                              //   width: W * 0.16,
                              //   child: Text(
                              //     "\$${controller.mondayList[index]['price']}",
                              //     maxLines: 1,
                              //   ),
                              // ),

                              SizedBox(
                                width: W * 0.14,
                                child: controller.mondayList[index]
                                            ['discountIcon'] ==
                                        "%"
                                    ? Text(
                                        controller.mondayList[index]
                                                    ['discount'] !=
                                                ""
                                            ? "${controller.mondayList[index]['discount']}${controller.mondayList[index]['discountIcon']} off"
                                            : "",
                                        maxLines: 2,
                                      )
                                    : Text(
                                        controller.mondayList[index]
                                                    ['discount'] !=
                                                ""
                                            ? "\$${controller.mondayList[index]['discount']} off"
                                            : "",
                                        maxLines: 2,
                                      ),
                              ),
                              // SizedBox(
                              //   width: W * 0.1,
                              //   child: Text(
                              //     "${controller.mondayList[index]['discount']}",
                              //     maxLines: 1,
                              //   ),
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: H * 0.015,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(
                                width: 70,
                              ),
                              Text(
                                "${controller.mondayList[index]['fromTime']} -  ${controller.mondayList[index]['toTime']}",
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                )
              : const SizedBox(),

          //Tuesday List
          controller.tuesdayList.isNotEmpty
              ? Text(
                  "${controller.tuesdayList.first['day']}",
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                  maxLines: 1,
                )
              : const SizedBox(),
          controller.tuesdayList.isNotEmpty
              ? SizedBox(
                  height: H * 0.01,
                )
              : const SizedBox(),
          controller.tuesdayList.isNotEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Item Name",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Quantity",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Size",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Price",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Discount",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              : const SizedBox(),
          controller.tuesdayList.isNotEmpty
              ? SizedBox(
                  height: H * 0.01,
                )
              : const SizedBox(),
          controller.tuesdayList.isNotEmpty
              ? ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.tuesdayList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: W * 0.26,
                                child: Text(
                                  "• ${controller.tuesdayList[index]['name']}",
                                  maxLines: 2,
                                ),
                              ),
                              SizedBox(
                                width: W * 0.15,
                                child: Text(
                                  controller.tuesdayList[index]['index'] ==
                                          "Foods"
                                      ? "  ${controller.tuesdayList[index]['quantity']}"
                                      : "",
                                  maxLines: 1,
                                ),
                              ),
                              SizedBox(
                                width: W * 0.19,
                                child: Row(
                                  children: [
                                    Text(
                                      controller.tuesdayList[index]['index'] ==
                                              "Drinks"
                                          ? "${controller.tuesdayList[index]['quantity']} "
                                          : "",
                                      maxLines: 1,
                                    ),
                                    controller.tuesdayList[index]['index'] ==
                                            "Drinks"
                                        ? Expanded(
                                            flex: 1,
                                            child: Text(
                                              controller.tuesdayList[index]
                                                          ['sizeIcon'] ==
                                                      null
                                                  ? "ml"
                                                  : "${controller.tuesdayList[index]['sizeIcon']}",
                                              maxLines: 1,
                                              softWrap: false,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                        : const Text(""),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: W * 0.14,
                                child: Text(
                                  controller.tuesdayList[index]['price'] != ""
                                      ? "\$${controller.tuesdayList[index]['price']}"
                                      : "",
                                  maxLines: 2,
                                ),
                              ),
                              // SizedBox(
                              //   width: W * 0.16,
                              //   child: Text(
                              //     "\$${controller.tuesdayList[index]['price']}",
                              //     maxLines: 1,
                              //   ),
                              // ),
                              SizedBox(
                                width: W * 0.14,
                                child: controller.tuesdayList[index]
                                            ['discountIcon'] ==
                                        "%"
                                    ? Text(
                                        controller.tuesdayList[index]
                                                    ['discount'] !=
                                                ""
                                            ? "${controller.tuesdayList[index]['discount']}${controller.tuesdayList[index]['discountIcon']} off"
                                            : "",
                                        maxLines: 2,
                                      )
                                    : Text(
                                        controller.tuesdayList[index]
                                                    ['discount'] !=
                                                ""
                                            ? "\$${controller.tuesdayList[index]['discount']} off"
                                            : "",
                                        maxLines: 2,
                                      ),
                              ),
                              //  ///
                              // SizedBox(
                              //   width: W * 0.1,
                              //   child: Text(
                              //     "${controller.tuesdayList[index]['discount']}",
                              //     maxLines: 1,
                              //   ),
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: H * 0.015,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(
                                width: 70,
                              ),
                              Text(
                                "${controller.tuesdayList[index]['fromTime']} -  ${controller.tuesdayList[index]['toTime']}",
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                )
              : const SizedBox(),
          //Wednesday List
          controller.wednesdayList.isNotEmpty
              ? Text(
                  "${controller.wednesdayList.first['day']}",
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                  maxLines: 1,
                )
              : const SizedBox(),
          controller.wednesdayList.isNotEmpty
              ? SizedBox(
                  height: H * 0.01,
                )
              : const SizedBox(),
          controller.wednesdayList.isNotEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Item Name",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Quantity",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Size",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Price",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Discount",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              : const SizedBox(),
          controller.wednesdayList.isNotEmpty
              ? SizedBox(
                  height: H * 0.01,
                )
              : const SizedBox(),
          controller.wednesdayList.isNotEmpty
              ? ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.wednesdayList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: W * 0.26,
                                child: Text(
                                  "• ${controller.wednesdayList[index]['name']}",
                                  maxLines: 2,
                                ),
                              ),
                              SizedBox(
                                width: W * 0.15,
                                child: Text(
                                  controller.wednesdayList[index]['index'] ==
                                          "Foods"
                                      ? "  ${controller.wednesdayList[index]['quantity']}"
                                      : "",
                                  maxLines: 1,
                                ),
                              ),
                              SizedBox(
                                width: W * 0.19,
                                child: Row(
                                  children: [
                                    Text(
                                      controller.wednesdayList[index]
                                                  ['index'] ==
                                              "Drinks"
                                          ? "${controller.wednesdayList[index]['quantity']} "
                                          : "",
                                      maxLines: 1,
                                    ),
                                    controller.wednesdayList[index]['index'] ==
                                            "Drinks"
                                        ? Expanded(
                                            flex: 1,
                                            child: Text(
                                              controller.wednesdayList[index]
                                                          ['sizeIcon'] ==
                                                      null
                                                  ? "ml"
                                                  : "${controller.wednesdayList[index]['sizeIcon']}",
                                              maxLines: 1,
                                              softWrap: false,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                        : const Text(""),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: W * 0.14,
                                child: Text(
                                  controller.wednesdayList[index]['price'] != ""
                                      ? "\$${controller.wednesdayList[index]['price']}"
                                      : "",
                                  maxLines: 2,
                                ),
                              ),

                              ///
                              SizedBox(
                                width: W * 0.14,
                                child: controller.wednesdayList[index]
                                            ['discountIcon'] ==
                                        "%"
                                    ? Text(
                                        controller.wednesdayList[index]
                                                    ['discount'] !=
                                                ""
                                            ? "${controller.wednesdayList[index]['discount']}${controller.wednesdayList[index]['discountIcon']} off"
                                            : "",
                                        maxLines: 2,
                                      )
                                    : Text(
                                        controller.wednesdayList[index]
                                                    ['discount'] !=
                                                ""
                                            ? "\$${controller.wednesdayList[index]['discount']} off"
                                            : "",
                                        maxLines: 2,
                                      ),
                              ),
                              // SizedBox(
                              //   width: W * 0.1,
                              //   child: Text(
                              //     "${controller.wednesdayList[index]['discount']}",
                              //     maxLines: 1,
                              //   ),
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: H * 0.015,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(
                                width: 70,
                              ),
                              Text(
                                "${controller.wednesdayList[index]['fromTime']} -  ${controller.wednesdayList[index]['toTime']}",
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                )
              : const SizedBox(),

          //thursday List
          controller.thursdayList.isNotEmpty
              ? Text(
                  "${controller.thursdayList.first['day']}",
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                  maxLines: 1,
                )
              : const SizedBox(),
          controller.thursdayList.isNotEmpty
              ? SizedBox(
                  height: H * 0.01,
                )
              : const SizedBox(),
          controller.thursdayList.isNotEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Item Name",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Quantity",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Size",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Price",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Discount",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              : const SizedBox(),
          controller.thursdayList.isNotEmpty
              ? SizedBox(
                  height: H * 0.01,
                )
              : const SizedBox(),
          controller.thursdayList.isNotEmpty
              ? ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.thursdayList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: W * 0.26,
                                child: Text(
                                  "• ${controller.thursdayList[index]['name']}",
                                  maxLines: 2,
                                ),
                              ),
                              SizedBox(
                                  width: W * 0.15,
                                  child: controller.thursdayList[index]
                                              ['index'] ==
                                          "Foods"
                                      ? Text(
                                          "  ${controller.thursdayList[index]['quantity']}",
                                          maxLines: 1,
                                        )
                                      : const SizedBox()
                                  // SizedBox(
                                  //         width: W * 0.19,
                                  //         child: Row(
                                  //           children: [
                                  //             Text(
                                  //               controller.thursdayList[index]
                                  //                           ['index'] ==
                                  //                       "Drinks"
                                  //                   ? "${controller.thursdayList[index]['quantity']} "
                                  //                   : "",
                                  //               maxLines: 1,
                                  //             ),
                                  //             controller.thursdayList[index]
                                  //                         ['index'] ==
                                  //                     "Drinks"
                                  //                 ? Expanded(
                                  //                     flex: 1,
                                  //                     child: Text(
                                  //                       controller.thursdayList[
                                  //                                       index][
                                  //                                   'sizeIcon'] ==
                                  //                               null
                                  //                           ? "ml"
                                  //                           : "${controller.thursdayList[index]['sizeIcon']}",
                                  //                       maxLines: 1,
                                  //                       softWrap: false,
                                  //                       overflow:
                                  //                           TextOverflow.ellipsis,
                                  //                     ),
                                  //                   )
                                  //                 : const Text(""),
                                  //           ],
                                  //         ),
                                  //       ),
                                  ),
                              SizedBox(
                                width: W * 0.19,
                                child: Row(
                                  children: [
                                    Text(
                                      controller.thursdayList[index]['index'] ==
                                              "Drinks"
                                          ? "${controller.thursdayList[index]['quantity']} "
                                          : "",
                                      maxLines: 1,
                                    ),
                                    controller.thursdayList[index]['index'] ==
                                            "Drinks"
                                        ? Expanded(
                                            flex: 1,
                                            child: Text(
                                              controller.thursdayList[index]
                                                          ['sizeIcon'] ==
                                                      null
                                                  ? "ml"
                                                  : "${controller.thursdayList[index]['sizeIcon']}",
                                              maxLines: 1,
                                              softWrap: false,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                        : const Text(""),
                                  ],
                                ),
                              ),

                              // controller.thursdayList[index]['price'] != ""
                              //     ?
                              SizedBox(
                                width: W * 0.14,
                                child: Text(
                                  controller.thursdayList[index]['price'] != ""
                                      ? "\$${controller.thursdayList[index]['price']}"
                                      : "",
                                  maxLines: 2,
                                ),
                              ),
                              //:

                              // SizedBox(
                              //   width: W * 0.16,
                              //   child: Text(
                              //     "\$${controller.thursdayList[index]['price']}",
                              //     maxLines: 1,
                              //   ),
                              // ),
                              SizedBox(
                                width: W * 0.14,
                                child: controller.thursdayList[index]
                                            ['discountIcon'] ==
                                        "%"
                                    ? Text(
                                        controller.thursdayList[index]
                                                    ['discount'] !=
                                                ""
                                            ? "${controller.thursdayList[index]['discount']}${controller.thursdayList[index]['discountIcon']} off"
                                            : "",
                                        maxLines: 2,
                                      )
                                    : Text(
                                        controller.thursdayList[index]
                                                    ['discount'] !=
                                                ""
                                            ? "\$${controller.thursdayList[index]['discount']} off"
                                            : "",
                                        maxLines: 2,
                                      ),
                              ),

                              ///
                              // SizedBox(
                              //   width: W * 0.1,
                              //   child: Text(
                              //     "${controller.thursdayList[index]['discount']}",
                              //     maxLines: 1,
                              //   ),
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: H * 0.015,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(
                                width: 70,
                              ),
                              Text(
                                "${controller.thursdayList[index]['fromTime']} -  ${controller.thursdayList[index]['toTime']}",
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                )
              : const SizedBox(),

          //friday List
          controller.fridayList.isNotEmpty
              ? Text(
                  "${controller.fridayList.first['day']}",
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                  maxLines: 1,
                )
              : const SizedBox(),
          controller.fridayList.isNotEmpty
              ? SizedBox(
                  height: H * 0.01,
                )
              : const SizedBox(),
          controller.fridayList.isNotEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Item Name",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Quantity",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Size",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Price",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Discount",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              : const SizedBox(),
          controller.fridayList.isNotEmpty
              ? SizedBox(
                  height: H * 0.01,
                )
              : const SizedBox(),
          controller.fridayList.isNotEmpty
              ? ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.fridayList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: W * 0.26,
                                child: Text(
                                  "• ${controller.fridayList[index]['name']}",
                                  maxLines: 2,
                                ),
                              ),
                              SizedBox(
                                width: W * 0.15,
                                child: Text(
                                  controller.fridayList[index]['index'] ==
                                          "Foods"
                                      ? "  ${controller.fridayList[index]['quantity']}"
                                      : "",
                                  maxLines: 1,
                                ),
                              ),
                              SizedBox(
                                width: W * 0.19,
                                child: Row(
                                  children: [
                                    Text(
                                      controller.fridayList[index]['index'] ==
                                              "Drinks"
                                          ? "${controller.fridayList[index]['quantity']} "
                                          : "",
                                      maxLines: 1,
                                    ),
                                    controller.fridayList[index]['index'] ==
                                            "Drinks"
                                        ? Expanded(
                                            flex: 1,
                                            child: Text(
                                              controller.fridayList[index]
                                                          ['sizeIcon'] ==
                                                      null
                                                  ? "ml"
                                                  : "${controller.fridayList[index]['sizeIcon']}",
                                              maxLines: 1,
                                              softWrap: false,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                        : const Text(""),
                                  ],
                                ),
                              ),

                              SizedBox(
                                width: W * 0.14,
                                child: Text(
                                  controller.fridayList[index]['price'] != ""
                                      ? "\$${controller.fridayList[index]['price']}"
                                      : "",
                                  maxLines: 2,
                                ),
                              ),
                              SizedBox(
                                width: W * 0.14,
                                child: controller.fridayList[index]
                                            ['discountIcon'] ==
                                        "%"
                                    ? Text(
                                        controller.fridayList[index]
                                                    ['discount'] !=
                                                ""
                                            ? "${controller.fridayList[index]['discount']}${controller.fridayList[index]['discountIcon']} off"
                                            : "",
                                        maxLines: 2,
                                      )
                                    : Text(
                                        controller.fridayList[index]
                                                    ['discount'] !=
                                                ""
                                            ? "${controller.fridayList[index]['discountIcon']}${controller.fridayList[index]['discount']} off"
                                            : "",
                                        maxLines: 2,
                                      ),
                              ),

                              ///
                              // SizedBox(
                              //   width: W * 0.16,
                              //   child: Text(
                              //     "\$${controller.fridayList[index]['price']}",
                              //     maxLines: 1,
                              //   ),
                              // ),
                              // SizedBox(
                              //   width: W * 0.1,
                              //   child: Text(
                              //     "${controller.fridayList[index]['discount']}",
                              //     maxLines: 1,
                              //   ),
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: H * 0.015,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(
                                width: 70,
                              ),
                              Text(
                                "${controller.fridayList[index]['fromTime']} -  ${controller.fridayList[index]['toTime']}",
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                )
              : const SizedBox(),

          //=========saturday List=========//
          controller.saturdayList.isNotEmpty
              ? Text(
                  "${controller.saturdayList.first['day']}",
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                  maxLines: 1,
                )
              : const SizedBox(),
          controller.saturdayList.isNotEmpty
              ? SizedBox(
                  height: H * 0.01,
                )
              : const SizedBox(),
          controller.saturdayList.isNotEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Item Name",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Quantity",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Size",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Price",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Discount",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              : const SizedBox(),
          controller.saturdayList.isNotEmpty
              ? SizedBox(
                  height: H * 0.01,
                )
              : const SizedBox(),
          controller.saturdayList.isNotEmpty
              ? ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.saturdayList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: W * 0.26,
                                child: Text(
                                  "• ${controller.saturdayList[index]['name']}",
                                  maxLines: 2,
                                ),
                              ),
                              SizedBox(
                                width: W * 0.15,
                                child: Text(
                                  controller.saturdayList[index]['index'] ==
                                          "Foods"
                                      ? "  ${controller.saturdayList[index]['quantity']}"
                                      : "",
                                  maxLines: 1,
                                ),
                              ),
                              SizedBox(
                                width: W * 0.19,
                                child: Row(
                                  children: [
                                    Text(
                                      controller.saturdayList[index]['index'] ==
                                              "Drinks"
                                          ? "${controller.saturdayList[index]['quantity']} "
                                          : "",
                                      maxLines: 1,
                                    ),
                                    controller.saturdayList[index]['index'] ==
                                            "Drinks"
                                        ? Expanded(
                                            flex: 1,
                                            child: Text(
                                              controller.saturdayList[index]
                                                          ['sizeIcon'] ==
                                                      null
                                                  ? "ml"
                                                  : "${controller.saturdayList[index]['sizeIcon']}",
                                              maxLines: 1,
                                              softWrap: false,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                        : const Text(""),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: W * 0.14,
                                child: Text(
                                  controller.saturdayList[index]['price'] != ""
                                      ? "\$${controller.saturdayList[index]['price']}"
                                      : "",
                                  maxLines: 2,
                                ),
                              ),
                              // SizedBox(
                              //   width: W * 0.16,
                              //   child: Text(
                              //     "\$${controller.saturdayList[index]['price']}",
                              //     maxLines: 1,
                              //   ),
                              // ),
                              SizedBox(
                                width: W * 0.14,
                                child: controller.saturdayList[index]
                                            ['discountIcon'] ==
                                        "%"
                                    ? Text(
                                        controller.saturdayList[index]
                                                    ['discount'] !=
                                                ""
                                            ? "${controller.saturdayList[index]['discount']}${controller.saturdayList[index]['discountIcon']} off"
                                            : "",
                                        maxLines: 2,
                                      )
                                    : Text(
                                        controller.saturdayList[index]
                                                    ['discount'] !=
                                                ""
                                            ? "${controller.saturdayList[index]['discountIcon']}${controller.saturdayList[index]['discount']} off"
                                            : "",
                                        maxLines: 2,
                                      ),
                              ),
                              // ///
                              // SizedBox(
                              //   width: W * 0.1,
                              //   child: Text(
                              //     "${controller.saturdayList[index]['discount']}",
                              //     maxLines: 1,
                              //   ),
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: H * 0.015,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(
                                width: 70,
                              ),
                              Text(
                                "${controller.saturdayList[index]['fromTime']} -  ${controller.saturdayList[index]['toTime']}",
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                )
              : const SizedBox(),
          SizedBox(
            height: H * 0.01,
          ),
          Visibility(
            visible: controller.happyHour.amenities != null &&
                controller.happyHour.amenities!.isNotEmpty,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionTitle("Amenities"),
                GridView.builder(
                  physics: const ScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    //  mainAxisExtent: 1,
                    childAspectRatio: 16 / 2,
                    crossAxisCount: 2,
                  ),
                  shrinkWrap: true,
                  itemCount: controller.happyHour.amenities?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Text("• ${controller.happyHour.amenities?[index]}");
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: H * 0.01,
          ),
          Visibility(
            visible: controller.happyHour.barType != null &&
                controller.happyHour.barType!.isNotEmpty,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionTitle("Bar-Types"),
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
                  itemCount: controller.happyHour.barType?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Text("•  ${controller.happyHour.barType?[index]}");
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: H * 0.01,
          ),
          Visibility(
            visible: controller.happyHour.event != null &&
                controller.happyHour.event!.isNotEmpty,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionTitle("Events"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Name",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Day",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "From",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "To",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  height: H * 0.01,
                ),
                ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.happyHour.event?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          SizedBox(
                              width: W * 0.32,
                              child: Text(
                                  "• ${controller.happyHour.event?[index]['name']}")),
                          SizedBox(
                              width: W * 0.2,
                              child: Text(
                                  "• ${controller.happyHour.event?[index]['day']}")),
                          Text(
                              "${controller.happyHour.event?[index]['fromtime']}  -"),
                          Text(
                              " ${controller.happyHour.event?[index]['totime']}"),
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
            visible: controller.happyHour.fromTimeToTime != null &&
                controller.happyHour.fromTimeToTime!.isNotEmpty,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionTitle("Business Times"),
                ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.happyHour.fromTimeToTime?.length ?? 0,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: W * 0.44,
                            child: Text(
                                "• ${controller.happyHour.fromTimeToTime?[index]['bDay'].toString()}"),
                          ),
                          Text(
                              "${controller.happyHour.fromTimeToTime?[index]['bFtime'].toString()} - ${controller.happyHour.fromTimeToTime?[index]['bTtime'].toString()}"),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: primary,
            ),
          ),
          SizedBox(
            height: H * 0.01,
          ),
        ],
      );
}

class CustomReplyCard extends GetView<BusinessHappyhourDetailScreenController> {
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
  buttonText,
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
          height: H * 0.38,
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
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    middleText,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
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
                         // backgroundColor: Colors.white,
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
                      //  backgroundColor: primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35),
                        ),
                        minimumSize: Size(W * 0.32, H * 0.072),
                      ),
                      onPressed: onConfrim,
                      child: Text(
                        buttonText,
                        style: const TextStyle(
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
