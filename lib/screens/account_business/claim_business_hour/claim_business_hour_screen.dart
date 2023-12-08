import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/colors.dart';
import 'package:happy_hour_app/global_controller/global_general_controller.dart';
import 'package:happy_hour_app/global_widgets/happyhour_card.dart';
import 'package:happy_hour_app/screens/account_business/claim_business_hour/claim_business_hour_controller.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../../core/constants.dart';
import '../../../routes/app_routes.dart';

class ClaimBusinessHourScreen extends GetView<ClaimBusinessHourController> {
  const ClaimBusinessHourScreen({Key? key}) : super(key: key);

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
                      Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          return Image.asset(
                            "assets/icons/Group 8588.png",
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
                          onTap: () {
                            Get.find<GlobalGeneralController>().favoriteCard(
                                context,
                                "Account Needed",
                                "In order to add happy hour as favorite you have to create or login into account",
                                "Login or Create", () {
                              Get.toNamed(Routes.loginCreateAccountScreen);
                            });
                          },
                          child: Image.asset(
                            "assets/icons/Group 11553.png",
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
                            //Get.toNamed(Routes.reportScreen);
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: whiteColor,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/icons/Group 11639@2x.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: H * 0.01,
                ),
                NewCard(
                  title: "Lorem Ipsum Business",
                  subtitle: "the ultimate 5 5star business",
                  image: "assets/icons/Group 11550@2x.png",
                  timeIcon: "assets/icons/Group 11609@2x.png",
                  time: "5421",
                  rating: Container(),
                  rateCount: "(381)",
                  share: GestureDetector(
                    onTap: () {
                      //print(object)
                      Get.find<GlobalGeneralController>().favoriteCard(
                          context,
                          "Business Account Needed",
                          "In order to claim this business you must have business account.",
                          "Create Account", () {
                        Get.toNamed(Routes.createBusinessAccountScreen);
                      });
                    },
                    child: Image.asset(
                      "assets/icons/Group 11598.png",
                      height: H * 0.06,
                    ),
                  ),
                  flag: Image.asset(
                    "assets/icons/Group 11614@2x.png",
                    height: H * 0.06,
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

class Reviews extends StatelessWidget {
  const Reviews({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            "Reviews (24)",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return const Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: CustomReviewCard(
                subtitle:
                    "Lorem ipsum dolor sit amet, Suspendisse\n Lorem ipsum dolor sit amet, Suspendisse",
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

class OverView extends StatelessWidget {
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
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: H * 0.01,
          ),
          const Text(
            "Lorem ipsum dolor sit amet, Suspendisse rhoncus lacus fermentum convallis lobortis. Aliquam ac purus non purus finibus aliquet. Nam justo mauris, tincidunt nec tincidunt eget, faucibus at arcu. Sed egestas in massa nec vestibulum. Vivamus pharetra malesuada elit.consectetur adipiscing elit. Nulla rutrum vehicula ornare. Donec ac arcu turpis. Fusce elit diam, auctor quis leo quis, pretium euismod erat. ",
            textAlign: TextAlign.left,
            // overflow: TextOverflow.ellipsis,
            //softWrap: false,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
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
          Image.asset("assets/icons/Group 11650.png"),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("• Lorem ipsum dolor"),
              Text("• Lorem ipsum dolor"),
            ],
          ),
          SizedBox(
            height: H * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("• Lorem ipsum dolor"),
              Text("• Lorem ipsum dolor"),
            ],
          ),
          SizedBox(
            height: H * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("• Lorem ipsum dolor"),
              Text("• Lorem ipsum dolor"),
            ],
          ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("• Lorem ipsum dolor"),
              Text("• Lorem ipsum dolor"),
            ],
          ),
          SizedBox(
            height: H * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("• Lorem ipsum dolor"),
              Text("• Lorem ipsum dolor"),
            ],
          ),
          SizedBox(
            height: H * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("• Lorem ipsum dolor"),
              Text("• Lorem ipsum dolor"),
            ],
          ),
        ],
      ),
    );
  }
}
