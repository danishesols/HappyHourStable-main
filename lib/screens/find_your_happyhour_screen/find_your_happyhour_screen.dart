import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/colors.dart';
import 'package:happy_hour_app/core/constants.dart';
import 'package:happy_hour_app/global_controller/global_general_controller.dart';
import 'package:happy_hour_app/global_widgets/happyhour_card.dart';

import '../../global_widgets/circular_indicator.dart';
import '../../routes/app_routes.dart';
import '../account_standard/standard_find_your_happyhour/find_your_happyhour_standard_controller.dart';
import 'find_your_happyhour_screen_controller.dart';

class FindYourHappyHourScreen
    extends GetView<FindYourHappyHourScreenController> {
  const FindYourHappyHourScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: SvgPicture.asset(
                "assets/icons/Group 9108.svg",
                height: 25,
                width: 25,
              ),
            )),
        title: const Text(
          "Happy Hours",
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Active Specials",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                  ),
                  const Spacer(),
                  GetBuilder<FindYourHappyHourScreenController>(
                    builder: (con) {
                    return SizedBox(
                      height: 35,
                      width: 100,
                      child: GestureDetector(
                        child: Chip(
                          padding: const EdgeInsets.all(10),
                          avatar: Image.asset(
                            "assets/images/Group 3809.png",
                          ),
                          label: const Text("View Map" ,style: TextStyle(color: Colors.white),),
                          backgroundColor: Colors.grey[400],
                          elevation: 5,
                        ),
                        // onTap: (){
                        //   showCustomDialog(context);
                        // },
                        onTap: controller.isLoading
                            ? () {
                                Get.find<GlobalGeneralController>().infoSnackbar(
                                    title: 'Loading...',
                                    description:
                                        'Let the Happy Hours load first');
                              }
                            : () {
                                Get.toNamed(Routes.mapScreen,
                                    arguments: controller.hoursInRadiusList);
                              },
                      ),
                    );
                  }),
                  const SizedBox(
                    width: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Get.toNamed(Routes.happyHourFilterScreen);
                      showCustomDialog(context);
                    },
                    child: SizedBox(
                      height: 35,
                      width: 100,
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // SvgPicture.asset(
                            //  // "assets/icons/Group 4822.svg",
                            //   "assets/images/Group 11724.png",
                            //   height: 20,
                            //   width: 20,
                            // ),
                            SizedBox(
                              height: 20,
                              width: 20,
                              child:Image.asset("assets/images/Group 11724.png")
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            const Text(
                              'Filters',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),

              SizedBox(height: H * 0.009),

              //*Hour In 10 Miles Radius
              GetBuilder<FindYourHappyHourScreenController>(
                builder: (con) {
                  return CustomCircleIndicator(
                    isEnabled: controller.isLoading,
                    opacity: 0.7,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0,),
                      child: controller.locationPermissionStatus !=
                                  LocationPermissionStatus.enabled &&
                              controller.isLoading == false
                          ? Center(
                              child: GestureDetector(
                                child: const Chip(
                                  padding: EdgeInsets.all(12),
                                  label: Text("Go Back & Enable Location"),
                                  backgroundColor: whiteColor,
                                  elevation: 5,
                                ),
                                onTap: () {
                                  Get.back();
                                },
                              ),
                            )
                          : controller.hoursInRadiusList.isEmpty
                          ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Currently there is no active Happy Hour",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      )
                          : ListView.builder(
                             // itemCount: controller.hoursInRadiusList.length,
                              itemCount: controller.hoursInRadiusList.length,
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              itemBuilder: (context, index) {
                                // String time = controller.hoursInRadiusList[index].showTimeInCard?.first ?? "";
                                // String time = controller
                                //                 .hoursInRadiusList[index].day !=
                                //             null &&
                                //         controller.hoursInRadiusList[index].day!
                                //             .isNotEmpty
                                //     ? "${controller.hoursInRadiusList[index].day?[0]['HfromTime']}  - "
                                //         "${controller.hoursInRadiusList[index].day?[0]['HtoTime']}"
                                //     : controller.hoursInRadiusList[index]
                                //                     .dayLate !=
                                //                 null &&
                                //             controller.hoursInRadiusList[index]
                                //                 .dayLate!.isNotEmpty
                                //         ? "${controller.hoursInRadiusList[index].dayLate?[0]['HfromTime2']}  - "
                                //             "${controller.hoursInRadiusList[index].dayLate?[0]['HtoTime2']}"
                                //         : controller.hoursInRadiusList[index]
                                //                         .dailySpecils !=
                                //                     null &&
                                //                 controller
                                //                     .hoursInRadiusList[index]
                                //                     .dailySpecils!
                                //                     .isNotEmpty
                                //             ? "${controller.hoursInRadiusList[index].dailySpecils?[0]['fromTime']}  - "
                                //                 "${controller.hoursInRadiusList[index].dailySpecils?[0]['toTime']}"
                                //             : '';
                                String time = controller.hoursInRadiusList[index].showTime ?? "";
                                if (index % 4 == 3) {
                                  return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        GestureDetector(
                                          onTap: () =>
                                              controller.onDirectionTap(
                                                  "https://www.google.com/ads"),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.asset(
                                                "assets/icons/Group 11527.png"),
                                          ),
                                        ),
                                        SizedBox(
                                          height: H * 0.012,
                                        ),
                                        CustomHappyhourCard(
                                          title: controller
                                              .hoursInRadiusList[index]
                                              .businessName
                                              .toString(),
                                          image: controller
                                              .hoursInRadiusList[index]
                                              .menuImage
                                              .toString(),
                                          subtitle: controller
                                              .hoursInRadiusList[index]
                                              .businessAddress
                                              .toString(),
                                          timeIcon:
                                              "assets/icons/Group 11432.svg",
                                          time: time,
                                          rating: RatingBarIndicator(
                                            unratedColor: Colors.grey.shade300,
                                            direction: Axis.horizontal,
                                            rating: 0,
                                            itemCount: 5,
                                            itemSize: 20,
                                            itemBuilder: (context, index) =>
                                                Image.asset(
                                              "assets/icons/Path 602@2x.png",
                                              height: 7,
                                              width: 10,
                                              color: primary,
                                            ),
                                          ),
                                          rateCount: controller
                                                  .hoursInRadiusList[index]
                                                  .reviewStar
                                                  ?.length
                                                  .toString() ??
                                              "",
                                          arrowImage: InkWell(
                                            onTap: () {
                                              controller.onDirectionTap(
                                                  "https://www.google.com/maps/search/?api=1&query=${controller.hoursInRadiusList[index].latitude},${controller.hoursInRadiusList[index].longitude}");
                                            },
                                            child: Image.asset(
                                              "assets/icons/Direction.png",
                                              height: 60,
                                              //color: whiteColor,
                                            ),
                                          ),
                                          ontap: () {
                                            controller.viewCount(controller
                                                .hoursInRadiusList[index].hid);
                                            //  print(controller.hoursInRadiusList[index].hid);

                                            Get.toNamed(
                                                Routes.happyHourDetailScreen,
                                                arguments: controller
                                                    .hoursInRadiusList[index]);
                                          },
                                        ),
                                      ]);
                                } else {
                                  return CustomHappyhourCard(
                                    title: controller
                                        .hoursInRadiusList[index].businessName
                                        .toString(),
                                    image: controller
                                        .hoursInRadiusList[index].menuImage
                                        .toString(),
                                    subtitle: controller
                                        .hoursInRadiusList[index]
                                        .businessAddress
                                        .toString(),
                                    timeIcon: "assets/icons/Group 11432.svg",
                                    time: time,
                                    rating: RatingBarIndicator(
                                      unratedColor: Colors.grey.shade300,
                                      direction: Axis.horizontal,
                                      rating: 0,
                                      itemCount: 5,
                                      itemSize: 20,
                                      itemBuilder: (context, index) =>
                                          Image.asset(
                                        "assets/icons/Path 602@2x.png",
                                        height: 7,
                                        width: 10,
                                        color: primary,
                                      ),
                                    ),
                                    rateCount: controller
                                            .hoursInRadiusList[index]
                                            .reviewStar
                                            ?.length
                                            .toString() ??
                                        "",
                                    arrowImage: InkWell(
                                      onTap: () {
                                        controller.onDirectionTap(
                                            "https://www.google.com/maps/search/?api=1&query=${controller.hoursInRadiusList[index].latitude},${controller.hoursInRadiusList[index].longitude}");
                                      },
                                      child: Image.asset(
                                        "assets/icons/Direction.png",
                                        height: 60,
                                        //color: whiteColor,
                                      ),
                                    ),
                                    ontap: () {
                                      controller.viewCount(controller
                                          .hoursInRadiusList[index].hid);
                                      //  print(controller.hoursInRadiusList[index].hid);

                                      Get.toNamed(Routes.happyHourDetailScreen,
                                          arguments: controller
                                              .hoursInRadiusList[index]);
                                    },
                                  );
                                }
                              }),
                    ),
                  );
                },
              ),
//* All Hours Show Here
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 8.0),
              //   child: FirestoreQueryBuilder<HappyHourModel>(
              //       query: AddHappyHourProvider().happyhourFetchingQuery,
              //       builder: (context, snapshot, _) {
              //         // Data is now typed!
              //         //print(happyHourModel.menuImage.toString());
              //         //if(snapshot.data()[index]){}
              //         return ListView.builder(
              //           shrinkWrap: true,
              //           physics: const BouncingScrollPhysics(),
              //           itemCount: snapshot.docs.length,
              //           itemBuilder: (context, index) {
              //             if (snapshot.hasMore &&
              //                 index + 1 == snapshot.docs.length) {
              //               snapshot.fetchMore();
              //             }
              //             HappyHourModel happyHourModel =
              //                 snapshot.docs[index].data();
              //             happyHourModel.id = snapshot.docs[index].id;
              //             if (index % 4 == 3) {
              //               return Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   const SizedBox(
              //                     height: 5,
              //                   ),
              //                   GestureDetector(
              //                     onTap: () => controller.onDirectionTap(
              //                         "https://www.google.com/ads"),
              //                     child: Padding(
              //                       padding: const EdgeInsets.all(8.0),
              //                       child: Image.asset(
              //                           "assets/icons/Group 11527.png"),
              //                     ),
              //                   ),
              //                   SizedBox(
              //                     height: H * 0.012,
              //                   ),
              //                   CustomHappyhourCard(
              //                     title: happyHourModel.businessName.toString(),
              //                     image: happyHourModel.menuImage.toString(),
              //                     subtitle:
              //                         happyHourModel.businessAddress.toString(),
              //                     timeIcon: "assets/icons/Group 11432.svg",
              //                     time:
              //                         "${happyHourModel.day?[0]['HfromTime']}  - "
              //                         "${happyHourModel.day?[0]['HtoTime']}",
              //                     rating: RatingBarIndicator(
              //                       unratedColor: Colors.grey.shade300,
              //                       direction: Axis.horizontal,
              //                       rating: happyHourModel.reviewStar?[0]
              //                               ["stars"] ??
              //                           0,
              //                       itemCount: 5,
              //                       itemSize: 20,
              //                       itemBuilder: (context, index) =>
              //                           Image.asset(
              //                         "assets/icons/Path 602@2x.png",
              //                         height: 7,
              //                         width: 10,
              //                         color: primary,
              //                       ),
              //                     ),
              //                     rateCount: happyHourModel.reviewStar?.length
              //                             .toString() ??
              //                         "",
              //                     arrowImage: InkWell(
              //                       onTap: () {
              //                         controller.onDirectionTap(
              //                             "https://www.google.com/maps/search/?api=1&query=${happyHourModel.latitude},${happyHourModel.longitude}");
              //                       },
              //                       child: Image.asset(
              //                         "assets/icons/Direction.png",
              //                         height: 60,
              //                         //color: whiteColor,
              //                       ),
              //                     ),
              //                     ontap: () {
              //                       controller.viewCount(happyHourModel.id);
              //                       Get.toNamed(Routes.happyHourDetailScreen,
              //                           arguments: happyHourModel);
              //                     },
              //                   ),
              //                 ],
              //               );
              //             }
              //             return CustomHappyhourCard(
              //               title: happyHourModel.businessName.toString(),
              //               image: happyHourModel.menuImage.toString(),
              //               subtitle: happyHourModel.businessAddress.toString(),
              //               timeIcon: "assets/icons/Group 11432.svg",
              //               time: "${happyHourModel.day?[0]['HfromTime']}  - "
              //                   "${happyHourModel.day?[0]['HtoTime']}",
              //               rating: RatingBarIndicator(
              //                 unratedColor: Colors.grey.shade300,
              //                 direction: Axis.horizontal,
              //                 rating:
              //                     happyHourModel.reviewStar?[0]["stars"] ?? 0,
              //                 itemCount: 5,
              //                 itemSize: 20,
              //                 itemBuilder: (context, index) => Image.asset(
              //                   "assets/icons/Path 602@2x.png",
              //                   height: 7,
              //                   width: 10,
              //                   color: primary,
              //                 ),
              //               ),
              //               rateCount:
              //                   happyHourModel.reviewStar?.length.toString() ??
              //                       "",
              //               arrowImage: InkWell(
              //                 onTap: () {
              //                   controller.onDirectionTap(
              //                       "https://www.google.com/maps/search/?api=1&query=${happyHourModel.latitude},${happyHourModel.longitude}");
              //                 },
              //                 child: Image.asset(
              //                   "assets/icons/Direction.png",
              //                   height: 60,
              //                   //color: whiteColor,
              //                 ),
              //               ),
              //               ontap: () {
              //                 controller.viewCount(happyHourModel.id);
              //                 // controller.viewCount(happyHourModel);
              //                 Get.toNamed(Routes.happyHourDetailScreen,
              //                     arguments: happyHourModel);
              //               },
              //             );
              //           },
              //         );
              //       }),
              // ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Get.toNamed(Routes.addHappyHourBusinessScreen);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.asset(
          //  "assets/icons/Group 9711.png",
          "assets/images/new-banner2.png",
            height: H * 0.16,
          ),
        ),
      ),
    );
  }



void showCustomDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  height: 200.0,
                  width: 200.0,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                    image: DecorationImage(
                      image: AssetImage('assets/images/coming-soon5.png'), // Replace with your image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Positioned(
                //   top: 0,
                //   right: 0,
                //   child: IconButton(
                //     icon: const Icon(Icons.close, color: Colors.yellow),
                //     onPressed: () {
                //       Navigator.of(context).pop();
                //     },
                //   ),
                // ),
              ],
            ),
            //const SizedBox(height: 100.0), // Set the height of the dialog
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(8.0)
                  ),
                  child: const Center(
                    child:  Text(
                      'close',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

// Example usage
// Call `showCustomDialog(context);` to display the dialog.


// Example usage
// Call `showCustomDialog(context);` to display the dialog.


}
