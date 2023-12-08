import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/colors.dart';
import 'package:happy_hour_app/global_widgets/happyhour_card.dart';
import 'package:happy_hour_app/screens/claim_happyhour_detail/claim_happyhour_detail_controller.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../core/constants.dart';
import '../../routes/app_routes.dart';

class ClaimHappyHourDetailScreen
    extends GetView<ClaimHappyHourDetailController> {
  const ClaimHappyHourDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                SizedBox(
                  height: H * 0.25,
                  width: W * 1.2,
                  child: Stack(children: [
                    Swiper(
                      itemBuilder: (BuildContext context, int index) {
                        return Image.network(
                          controller.happyhourModel.menuImage.toString(),
                          fit: BoxFit.fitWidth,
                        );
                      },
                      itemCount: 3,
                      pagination: const SwiperPagination(),
                      viewportFraction: 1,
                      scale: 1,
                      loop: false,
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
                          height: 35,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      height: 50,
                      width: 50,
                      top: 10,
                      right: 80,
                      child: InkWell(
                        onTap: () {},
                        child: Image.asset(
                          "assets/icons/Group 11553.png",
                          height: 35,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      height: 50,
                      width: 50,
                      top: 10,
                      right: 20,
                      child: InkWell(
                        onTap: () {
                          controller.onDirectionTap();

                          // Get.toNamed(Routes.reportScreen);
                        },
                        child: CircleAvatar(
                          backgroundColor: whiteColor,
                          child: ClipOval(
                            child: Image.asset(
                              "assets/icons/Direction.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Container(
                        //   decoration: const BoxDecoration(
                        //     color: whiteColor,
                        //     shape: BoxShape.circle,
                        //     image: DecorationImage(
                        //       image: AssetImage(
                        //         "assets/icons/Direction.png",
                        //       ),
                        //       fit: BoxFit.scaleDown,
                        //     ),
                        //   ),
                        // ),
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  height: H * 0.01,
                ),
                NewCard(
                  title: controller.happyhourModel.businessName.toString(),
                  subtitle:
                      controller.happyhourModel.businessAddress.toString(),
                  image: "assets/icons/Group 11550@2x.png",
                  timeIcon: "assets/icons/Group 11609.png",
                  time: "",
                  rating: RatingBarIndicator(
                    unratedColor: Colors.grey.shade300,
                    direction: Axis.horizontal,
                    rating:
                        controller.happyhourModel.reviewStar?[0]["stars"] ?? 0,
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
                  share: GestureDetector(
                    onTap: () {
                      // Get.find<GlobalGeneralController>().dialogueCard(
                      //     context,
                      //     "Claim This Business",
                      //     "Do you want to Claim This Business",
                      //     "Done", () {
                      // });
                    },
                    child: Image.asset(
                      "assets/icons/Group 11598.png",
                      height: H * 0.06,
                    ),
                    //  Container(
                    //   height: 50,
                    //   width: 50,
                    //   // child: SvgPicture.asset(image),
                    //   decoration: const BoxDecoration(
                    //       shape: BoxShape.circle,
                    //       image: DecorationImage(
                    //           image: AssetImage(
                    //               "assets/icons/Group 11600@2x.png"))),
                    // ),
                  ),
                  flag: GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.reportScreen);
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      // child: SvgPicture.asset(image),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/icons/Group 11614@2x.png"))),
                    ),
                  ),
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
                        labels: const ['OverView', 'Reviews'],
                        radiusStyle: true,
                        onToggle: (index) {
                          controller.switches = index;
                        },
                      ),
                    ),
                  ],
                ),
                Obx(() => controller.switches == 0
                    ? const OverView()
                    : const Reviews())
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OverView extends GetView<ClaimHappyHourDetailController> {
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
          SizedBox(
            height: H * 0.01,
          ),
          Row(
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
          SizedBox(
            height: H * 0.01,
          ),
          const Text(
            "Description",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: H * 0.01,
          ),
          Text(
            controller.happyhourModel.description.toString(),
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
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: H * 0.01,
          ),
          Image.network(controller.happyhourModel.menuImage.toString()),
          SizedBox(
            height: H * 0.01,
          ),
          const Text(
            "Food Items",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
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
              itemCount: controller.happyhourModel.foodName?.length ?? 0,
              itemBuilder: (context, index) {
                return Text(
                    "• ${controller.happyhourModel.foodName?[index]['foodname']}");
              }),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text("• ${controller.happyhourModel.foodName[0]}"),
          //     Text("• ${controller.happyhourModel.foodName[1]}"),
          //   ],
          // ),
          // SizedBox(
          //   height: H * 0.01,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text("• ${controller.happyhourModel.foodName}"),
          //     Text("• ${controller.happyhourModel.foodName}"),
          //   ],
          // ),
          // SizedBox(
          //   height: H * 0.01,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text("• ${controller.happyhourModel.foodName}"),
          //     Text("• ${controller.happyhourModel.foodName}"),
          //   ],
          // ),
          SizedBox(
            height: H * 0.01,
          ),
          const Text(
            "Amenities",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
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
              itemCount: controller.happyhourModel.amenities?.length ?? 0,
              itemBuilder: (context, index) {
                return Text("• ${controller.happyhourModel.amenities?[index]}");
              }),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text("• ${controller.happyhourModel.amenities}"),
          //     Text("• ${controller.happyhourModel.amenities}"),
          //   ],
          // ),
          // SizedBox(
          //   height: H * 0.01,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text("• ${controller.happyhourModel.amenities}"),
          //     Text("• ${controller.happyhourModel.amenities}"),
          //   ],
          // ),
          // SizedBox(
          //   height: H * 0.01,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text("• ${controller.happyhourModel.amenities}"),
          //     Text("• ${controller.happyhourModel.amenities}"),
          //   ],
          // ),
        ],
      ),
    );
  }
}

class Reviews extends GetView<ClaimHappyHourDetailController> {
  const Reviews({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: H * 0.01,
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.addReviewScreen);
          },
          child: Row(
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
        SizedBox(
          height: H * 0.01,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "Reviews ${controller.happyhourModel.reviewStar?.length.toString() ?? ""}",
            style: const TextStyle(fontSize: 16),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: controller.happyhourModel.reviewStar?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: CustomReviewCard(
                subtitle: controller.happyhourModel.reviewStar?[index]
                        ['reviewText'] ??
                    "",
                image: "assets/icons/Group 8.png",
                time: "5421",
                rating: "assets/icons/Path 16148.svg",
                rateCount: "03:00 PM 27/04/2022,",
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
