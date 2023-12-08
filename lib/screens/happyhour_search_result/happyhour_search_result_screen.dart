import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/constants.dart';
import 'package:happy_hour_app/screens/happyhour_search_result/happyhour_search_result_controller.dart';

import '../../core/colors.dart';
import '../../global_widgets/happyhour_card.dart';
import '../../routes/app_routes.dart';
import '../happyhour_filter_screen/happyhour_filter_screen_controller.dart';

class HappyHourSearchResultScreen
    extends GetView<HappyHourSearchResultController> {
  const HappyHourSearchResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              // controller.clearSearchList;
              Get.back();
            },
            icon: SvgPicture.asset(
              "assets/icons/Group 9108.svg",
              height: 25,
              width: 25,
            )),
        title: const Text(
          "Happy Hour",
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24),
        ),
        centerTitle: true,
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 16.0),
        //     child: GestureDetector(
        //       onTap: () {
        //         Get.toNamed(Routes.happyHourFilterScreen);
        //       },
        //       child: CircleAvatar(
        //         radius: 23,
        //         backgroundColor: primary,
        //         child: SvgPicture.asset(
        //           "assets/icons/Group 4822.svg",
        //           height: 25,
        //           width: 25,
        //         ),
        //         // backgroundImage: SvgPicture.asset(""),
        //       ),
        //     ),
        //   )
        // ],
      ),
      // extendBodyBehindAppBar: true,
      body: GetBuilder<HappyHourSearchResultController>(
        builder: (_) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Your Search Results",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                      GestureDetector(
                       child: Chip(
                          padding: const EdgeInsets.all(10),
                          avatar: Image.asset(
                            "assets/images/Group 3809.png",
                          ),
                          label: const Text("View Map" ,style: TextStyle(color: Colors.white),),
                          backgroundColor: Colors.grey[400],
                          elevation: 5,
                        ),
                        onTap: () {
                          Get.find<HappyHourFilterScreenController>()
                                  .searchController
                                  .text
                                  .isEmpty
                              ? Get.toNamed(
                                  Routes.mapScreen,
                                  arguments: controller.hourSearch,
                                )
                              : Get.toNamed(
                                  Routes.mapScreen,
                                  arguments: controller.citySearch,
                                );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: H * 0.005),
                  const Text(
                    "Filters",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
                  ),
                  SizedBox(height: H * 0.005),
                  SizedBox(
                    width: W,
                    height: 50,
                    child: ListView.builder(
                        physics: const ScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: controller.searchItem.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: chipWidget(
                                controller.searchItem[index].toString(), () {
                              controller.removeItem(index);
                            }),
                          );
                        }),
                  ),
                  SizedBox(height: H * 0.009),
                  Get.find<HappyHourFilterScreenController>()
                          .searchController
                          .text
                          .isEmpty
                      ? searchHour()
                      : citysearchHour(),
                  // controller.hourSearch.isNotEmpty ? searchHour() : allHour(),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          //Get.toNamed(Routes.addHappyHourBusinessScreen);
          // controller.allHOur();
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.asset(
            "assets/icons/Group 9711.png",
            height: H * 0.2,
          ),
        ),
      ),
    );
  }

  ListView searchHour() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: controller.hourSearch.length,
      itemBuilder: (context, index) {
        if (index == 3) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () =>
                      controller.onAdsTap("https://www.google.com/ads"),
                  child: Image.asset("assets/icons/Group 11527.png"),
                ),
                SizedBox(height: H * 0.01),
                CustomHappyhourSearchCard(
                  onTap: () {
                    Get.toNamed(Routes.happyHourDetailScreen,
                        arguments: controller.hourSearch[index]);
                  },
                  title: controller.hourSearch[index].businessName.toString(),
                  image: controller.hourSearch[index].menuImage.toString(),
                  subtitle:
                      controller.hourSearch[index].businessAddress.toString(),
                  timeIcon: "assets/icons/Group 11432.svg",
                  yellowText: controller.searchItem.isEmpty
                      ? controller.hourSearch[index].foodName?.isNotEmpty ??
                              false
                          ? "${controller.hourSearch[index].foodName?.first['foodname']}: \$${controller.hourSearch[index].foodName?.first['foodprice']}   ${controller.hourSearch[index].foodName?.last['foodname']}:  \$${controller.hourSearch[index].foodName?.last['foodprice']}"
                          : controller.searchItem.isNotEmpty
                              ? "${controller.searchItem.first}"
                                  ": \$${9}  ${controller.searchItem.last}"
                                  ": \$${12}"
                              : ""
                      : "",
                  yellowText2: controller.hourSearch[index].drinkitemName ==
                          null
                      ? "${controller.hourSearch[index].drinkitemName?[0]['drinkname']}: \$${controller.hourSearch[index].drinkitemName?[0]["drinkprice"]}   ${controller.hourSearch[index].drinkitemName?.last['drinkname']}:  \$${controller.hourSearch[index].drinkitemName?.last["drinkprice"]}"
                      : "",
                  rating: "assets/icons/Path 16148.svg",
                  rateCount: "",
                  // rateCount: controller
                  //         .hourSearch[index].reviewStar?[index].length
                  //         .toString() ??
                  //     "",
                  //   "(${happyHourModel.foodName?[index]['foodcount']})",
                  share: InkWell(
                    onTap: () {
                      controller.onDirectionTap(
                          "https://www.google.com/maps/search/?api=1&query=${controller.hourSearch[index].latitude},${controller.hourSearch[index].longitude}");
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Image.asset(
                        "assets/icons/Direction.png",
                        height: 60,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: CustomHappyhourSearchCard(
            onTap: () {
              Get.toNamed(
                Routes.happyHourDetailScreen,
                arguments: controller.hourSearch[index],
              );
            },
            title: controller.hourSearch[index].businessName.toString(),
            image: controller.hourSearch[index].menuImage.toString(),
            subtitle: controller.hourSearch[index].businessAddress.toString(),
            timeIcon: "assets/icons/Group 11432.svg",
            yellowText: controller.searchItem.isEmpty
                ? controller.hourSearch[index].foodName == null
                    ? "${controller.hourSearch[index].foodName?.first['foodname']}: \$${controller.hourSearch[index].foodName?.first['foodprice']}   ${controller.hourSearch[index].foodName?.last['foodname']}:  \$${controller.hourSearch[index].foodName?.last['foodprice']}"
                    : ""
                : "${controller.searchItem.first}"
                    ": \$${9}  ${controller.searchItem.last}"
                    ": \$${12}",
            yellowText2: controller.hourSearch[index].drinkitemName == null
                ? "${controller.hourSearch[index].drinkitemName?.first['drinkname']}: \$${controller.hourSearch[index].drinkitemName?.first["drinkprice"]}   ${controller.hourSearch[index].drinkitemName?.last['drinkname']}:  \$${controller.hourSearch[index].drinkitemName?.last["drinkprice"]}"
                : "",
            rating: "assets/icons/Path 16148.svg",
            rateCount: "",
            // rateCount: controller.hourSearch[index].reviewStar?[index].length
            //         .toString() ??
            //     "",
            //   "(${happyHourModel.foodName?[index]['foodcount']})",
            share: InkWell(
              onTap: () {
                controller.onDirectionTap(
                    "https://www.google.com/maps/search/?api=1&query=${controller.hourSearch[index].latitude},${controller.hourSearch[index].longitude}");
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Image.asset(
                  "assets/icons/Direction.png",
                  height: 60,
                ),
              ),
            ),
          ),
        );
      },
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

  ListView citysearchHour() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: controller.citySearch.length,
        itemBuilder: (context, index) {
          if (index == 3) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () =>
                        controller.onAdsTap("https://www.google.com/ads"),
                    child: Image.asset("assets/icons/Group 11527.png"),
                  ),
                  SizedBox(height: H * 0.01),
                  CustomHappyhourSearchCard(
                    onTap: () {
                      Get.toNamed(Routes.happyHourDetailScreen,
                          arguments: controller.citySearch[index]);
                    },
                    title: controller.citySearch[index].businessName.toString(),
                    image: controller.citySearch[index].menuImage.toString(),
                    subtitle:
                        controller.citySearch[index].businessAddress.toString(),
                    timeIcon: "assets/icons/Group 11432.svg",
                    yellowText: controller.searchItem.isEmpty
                        ? controller.citySearch[index].foodName == null
                            ? "${controller.citySearch[index].foodName?.first['foodname']}: \$${controller.citySearch[index].foodName?.first['foodprice']}   ${controller.citySearch[index].foodName?.last['foodname']}:  \$${controller.citySearch[index].foodName?.last['foodprice']}"
                            : ""
                        : "${controller.searchItem.first}"
                            ": \$${9}  ${controller.searchItem.last}"
                            ": \$${12}",
                    yellowText2: controller
                            .citySearch[index].drinkitemName!.isNotEmpty
                        ? "${controller.citySearch[index].drinkitemName?.first['drinkname']}: \$${controller.citySearch[index].drinkitemName?.first["drinkprice"]}   ${controller.citySearch[index].drinkitemName?.last['drinkname']}:  \$${controller.citySearch[index].drinkitemName?.last["drinkprice"]}"
                        : "",
                    rating: "assets/icons/Path 16148.svg",
                    rateCount: controller
                            .citySearch[index].reviewStar?[index].length
                            .toString() ??
                        "",
                    //   "(${happyHourModel.foodName?[index]['foodcount']})",
                    share: InkWell(
                      onTap: () {
                        controller.onDirectionTap(
                            "https://www.google.com/maps/search/?api=1&query=${controller.citySearch[index].latitude},${controller.citySearch[index].longitude}");
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Image.asset(
                          "assets/icons/Direction.png",
                          height: 60,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: CustomHappyhourSearchCard(
              onTap: () {
                Get.toNamed(Routes.happyHourDetailScreen,
                    arguments: controller.citySearch[index]);
              },
              title: controller.citySearch[index].businessName.toString(),
              image: controller.citySearch[index].menuImage.toString(),
              subtitle: controller.citySearch[index].businessAddress.toString(),
              timeIcon: "assets/icons/Group 11432.svg",
              yellowText: controller.searchItem.isEmpty
                  ? controller.citySearch[index].foodName == null
                      ? "${controller.citySearch[index].foodName?[0]['foodname']}: \$${controller.citySearch[index].foodName?[0]['foodprice']}   ${controller.citySearch[index].foodName?.last['foodname']}:  \$${controller.citySearch[index].foodName?.last['foodprice']}"
                      : ""
                  : "${controller.searchItem.first}"
                      ": \$${9}  ${controller.searchItem.last}"
                      ": \$${12}",
              // yellowText2:
              //    "${controller.citySearch[index].drinkitemName?[0]['drinkname']}: \$${controller.citySearch[index].drinkitemName?[0]["drinkprice"]}   ${controller.citySearch[index].drinkitemName?.last['drinkname']}:  \$${controller.citySearch[index].drinkitemName?.last["drinkprice"]}",
              rating: "assets/icons/Path 16148.svg",
              rateCount: "",

              //rateCount:controller.citySearch[index].reviewStar?[index].length.toString() ?? "",
              share: InkWell(
                onTap: () {
                  controller.onDirectionTap(
                      "https://www.google.com/maps/search/?api=1&query=${controller.citySearch[index].latitude},${controller.citySearch[index].longitude}");
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Image.asset(
                    "assets/icons/Direction.png",
                    height: 60,
                  ),
                ),
              ),
            ),
          );
        });

        
  }

  // FirestoreQueryBuilder<HappyHourModel> allHour() {
  //   return FirestoreQueryBuilder<HappyHourModel>(
  //       query: AddHappyHourProvider().happyhourFetchingQuery,
  //       builder: (context, snapshot, _) {
  //         return ListView.builder(
  //             shrinkWrap: true,
  //             physics: const BouncingScrollPhysics(),
  //             itemCount: snapshot.docs.length,
  //             itemBuilder: (context, index) {
  //               HappyHourModel happyHourModel = snapshot.docs[index].data();
  //               if (index == 3) {
  //                 return Padding(
  //                   padding:
  //                       const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
  //                   child: Column(
  //                     children: [
  //                       GestureDetector(
  //                         onTap: () =>
  //                             controller.onAdsTap("https://www.google.com/ads"),
  //                         child: Image.asset("assets/icons/Group 11527.png"),
  //                       ),
  //                       SizedBox(height: H * 0.01),
  //                       CustomHappyhourSearchCard(
  //                         onTap: () {
  //                           Get.toNamed(Routes.claimHappyHourDetailScreen,
  //                               arguments: happyHourModel);
  //                         },
  //                         title: happyHourModel.businessName.toString(),
  //                         image: happyHourModel.menuImage.toString(),
  //                         subtitle: happyHourModel.businessAddress.toString(),
  //                         timeIcon: "assets/icons/Group 11432.svg",
  //                         yellowText:
  //                             "${happyHourModel.foodName!.isEmpty ? "" : happyHourModel.foodName?.first['foodname']}: \$ ${happyHourModel.foodName!.isEmpty ? "" : happyHourModel.foodName?.first['foodprice'] ?? ""}   ${happyHourModel.foodName!.isEmpty ? "" : happyHourModel.foodName?.last['foodname'] ?? ""}:  \$${happyHourModel.foodName!.isEmpty ? "" : happyHourModel.foodName?.last['foodprice'] ?? ""}",
  //                         yellowText2:
  //                             "${happyHourModel.drinkitemName!.isEmpty ? "" : happyHourModel.drinkitemName?[0]['drinkname']}: \$${happyHourModel.drinkitemName!.isEmpty ? "" : happyHourModel.drinkitemName?.first["drinkprice"] ?? ""}   ${happyHourModel.drinkitemName!.isEmpty ? "" : happyHourModel.drinkitemName?.last['drinkname'] ?? ""}:  \$${happyHourModel.drinkitemName!.isEmpty ? "" : happyHourModel.drinkitemName?.last["drinkprice"] ?? ""}",
  //                         rating: "assets/icons/Path 16148.svg",
  //                         rateCount: "",
  //                         //   "(${happyHourModel.foodName?[index]['foodcount']})",
  //                         share: Padding(
  //                           padding: const EdgeInsets.only(right: 8.0),
  //                           child: Image.asset(
  //                             "assets/icons/Direction.png",
  //                             height: 50,
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 );
  //               }
  //               return Padding(
  //                 padding: const EdgeInsets.only(bottom: 8.0),
  //                 child: CustomHappyhourSearchCard(
  //                   onTap: () {
  //                     Get.toNamed(Routes.claimHappyHourDetailScreen,
  //                         arguments: happyHourModel);
  //                   },
  //                   title: happyHourModel.businessName.toString(),
  //                   image: happyHourModel.menuImage.toString(),
  //                   subtitle: happyHourModel.businessAddress.toString(),
  //                   timeIcon: "assets/icons/Group 11432.svg",
  //                   yellowText:
  //                       "${happyHourModel.foodName!.isEmpty ? "" : happyHourModel.foodName?.first['foodname']}: \$ ${happyHourModel.foodName!.isEmpty ? "" : happyHourModel.foodName?.first['foodprice'] ?? ""}   ${happyHourModel.foodName!.isEmpty ? "" : happyHourModel.foodName?.last['foodname'] ?? ""}:  \$${happyHourModel.foodName!.isEmpty ? "" : happyHourModel.foodName?.last['foodprice'] ?? ""}",
  //                   yellowText2:
  //                       "${happyHourModel.drinkitemName!.isEmpty ? "" : happyHourModel.drinkitemName?[0]['drinkname']}: \$${happyHourModel.drinkitemName!.isEmpty ? "" : happyHourModel.drinkitemName?.first["drinkprice"] ?? ""}   ${happyHourModel.drinkitemName!.isEmpty ? "" : happyHourModel.drinkitemName?.last['drinkname'] ?? ""}:  \$${happyHourModel.drinkitemName!.isEmpty ? "" : happyHourModel.drinkitemName?.last["drinkprice"] ?? ""}",
  //                   rating: "assets/icons/Path 16148.svg",
  //                   rateCount: "",
  //                   //   "(${happyHourModel.foodName?[index]['foodcount']})",
  //                   share: Padding(
  //                     padding: const EdgeInsets.only(right: 8.0),
  //                     child: Image.asset(
  //                       "assets/icons/Direction.png",
  //                       height: 50,
  //                     ),
  //                   ),
  //                 ),
  //               );
  //             });
  //       });
  // }

  Chip chipWidget(String text, function) {
    return Chip(
      padding: const EdgeInsets.only(right: 8, bottom: 8, top: 4),
      deleteIcon: const Icon(
        Icons.close,
        color: whiteColor,
      ),
      onDeleted: function,
      deleteIconColor: Colors.green,
      label: Text(
        text,
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
      ),
      backgroundColor: primary,
      elevation: 5,
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutterfire_ui/firestore.dart';
// import 'package:get/get.dart';
// import 'package:happy_hour_app/core/constants.dart';
// import 'package:happy_hour_app/data/models/search_model.dart';
// import 'package:happy_hour_app/screens/happyhour_search_result/happyhour_search_result_controller.dart';

// import '../../core/colors.dart';
// import '../../data/models/happyhour_model.dart';
// import '../../data/providers/add_happyhour_provider.dart';
// import '../../global_widgets/happyhour_card.dart';
// import '../../routes/app_routes.dart';

// class HappyHourSearchResultScreen
//     extends GetView<HappyHourSearchResultController> {
//   const HappyHourSearchResultScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//             onPressed: () {
//               Get.back();
//               controller.clearSearchList;
//             },
//             icon: SvgPicture.asset(
//               "assets/icons/Group 9108.svg",
//               height: 25,
//               width: 25,
//             )),
//         title: const Text(
//           "Your Search Results",
//           style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24),
//         ),
//         centerTitle: true,
//         // actions: [
//         //   Padding(
//         //     padding: const EdgeInsets.only(right: 16.0),
//         //     child: GestureDetector(
//         //       onTap: () {
//         //         Get.toNamed(Routes.happyHourFilterScreen);
//         //       },
//         //       child: CircleAvatar(
//         //         radius: 23,
//         //         backgroundColor: primary,
//         //         child: SvgPicture.asset(
//         //           "assets/icons/Group 4822.svg",
//         //           height: 25,
//         //           width: 25,
//         //         ),
//         //         // backgroundImage: SvgPicture.asset(""),
//         //       ),
//         //     ),
//         //   )
//         // ],
//       ),
//       // extendBodyBehindAppBar: true,
//       body: GetBuilder<HappyHourSearchResultController>(
//         builder: (_) {
//           return SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         "Search results",
//                         style: TextStyle(
//                             fontWeight: FontWeight.w700, fontSize: 16),
//                       ),
//                       GestureDetector(
//                         child: Chip(
//                           padding: const EdgeInsets.all(12),
//                           avatar: Image.asset(
//                             "assets/icons/Group 3809.png",
//                           ),
//                           label: const Text("View Map"),
//                           backgroundColor: whiteColor,
//                           elevation: 5,
//                         ),
//                         onTap: () {
//                           Get.toNamed(Routes.happyHourMapScreen);
//                         },
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: H * 0.005),
//                   const Text(
//                     "Filters",
//                     style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
//                   ),
//                   SizedBox(height: H * 0.005),
//                   SizedBox(
//                     width: W,
//                     height: 50,
//                     child: ListView.builder(
//                         physics: const ScrollPhysics(),
//                         scrollDirection: Axis.horizontal,
//                         shrinkWrap: true,
//                         itemCount: controller.searchItem.length,
//                         itemBuilder: (context, index) {
//                           return Padding(
//                             padding: const EdgeInsets.only(left: 8.0),
//                             child: chipWidget(
//                                 controller.searchItem[index].toString(), () {
//                               controller.removeItem(index);
//                             }),
//                           );
//                         }),
//                   ),

//                   SizedBox(height: H * 0.009),
//                   // FirestoreListView<HappyHourModel>(
//                   //   shrinkWrap: true,
//                   //   query: AddHappyHourProvider().happyhourFetchingQuery,
//                   //   itemBuilder: (context, snapshot) {
//                   //     HappyHourModel happyHourModel = snapshot.data();

//                   //     return
//                   // FirestoreQueryBuilder<HappyHourModel>(
//                   //   query: AddHappyHourProvider().happyhourFetchingQuery,
//                   //   builder: (context, snapshot, _) {
//                   //     // Data is now typed!

//                   //     //print(happyHourModel.menuImage.toString());
//                   //     //if(snapshot.data()[index]){}

//                   //     return
//                   ListView.builder(
//                     shrinkWrap: true,
//                     physics: const BouncingScrollPhysics(),
//                     itemCount: controller.fetchList.length,
//                     itemBuilder: (context, index) {
//                       // HappyHourModel happyHourModel =
//                       //     snapshot.docs[index].data();

//                       if (index == 3) {
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 16, horizontal: 4),
//                           child: Column(
//                             children: [
//                               Image.asset("assets/icons/Group 11527.png"),
//                               SizedBox(height: H * 0.01),
//                               CustomHappyhourSearchCard(
//                                 onTap: () {
//                                   Get.toNamed(Routes.claimHappyHourDetailScreen,
//                                       arguments: controller.fetchList);
//                                 },
//                                 title: controller.fetchList[index].businessName
//                                     .toString(),
//                                 image: controller.fetchList[index].menuImage
//                                     .toString(),
//                                 subtitle: controller
//                                     .fetchList[index].businessAddress
//                                     .toString(),
//                                 timeIcon: "assets/icons/Group 11432.svg",
//                                 yellowText:
//                                     "${controller.fetchList[index].foodName?[0]['foodname']}: \$ ${controller.fetchList[index].foodName?[0]['foodprice']}   ${controller.fetchList[index].foodName?.last['foodname']}:  \$${controller.fetchList[index].foodName?.last['foodprice']}",
//                                 yellowText2:
//                                     "${controller.fetchList[index].drinkitemName?[0]['drinkname']}: \$${controller.fetchList[index].drinkitemName?[0]["drinkprice"]}   ${controller.fetchList[index].drinkitemName?.last['drinkname']}:  \$${controller.fetchList[index].drinkitemName?.last["drinkprice"]}",
//                                 rating: "assets/icons/Path 16148.svg",
//                                 rateCount: "",
//                                 //   "(${happyHourModel.foodName?[index]['foodcount']})",
//                                 share: Padding(
//                                   padding: const EdgeInsets.only(right: 8.0),
//                                   child: Image.asset(
//                                     "assets/icons/Direction.png",
//                                     height: 50,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       }
//                       return Padding(
//                         padding: const EdgeInsets.only(bottom: 8.0),
//                         child: CustomHappyhourSearchCard(
//                           onTap: () {
//                             Get.toNamed(Routes.claimHappyHourDetailScreen,
//                                 arguments: controller.fetchList);
//                           },
//                           title: controller.fetchList[index].businessName
//                               .toString(),
//                           image:
//                               controller.fetchList[index].menuImage.toString(),
//                           subtitle: controller.fetchList[index].businessAddress
//                               .toString(),
//                           timeIcon: "assets/icons/Group 11432.svg",
//                           yellowText:
//                               "${controller.fetchList[index].foodName?[0]['foodname']}: \$ ${controller.fetchList[index].foodName?[0]['foodprice']}   ${controller.fetchList[index].foodName?.last['foodname']}:  \$${controller.fetchList[index].foodName?.last['foodprice']}",
//                           yellowText2:
//                               "${controller.fetchList[index].drinkitemName?[0]['drinkname']}: \$${controller.fetchList[index].drinkitemName?[0]["drinkprice"]}   ${controller.fetchList[index].drinkitemName?.last['drinkname']}:  \$${controller.fetchList[index].drinkitemName?.last["drinkprice"]}",
//                           rating: "assets/icons/Path 16148.svg",
//                           rateCount: "",
//                           //   "(${happyHourModel.foodName?[index]['foodcount']})",
//                           share: Padding(
//                             padding: const EdgeInsets.only(right: 8.0),
//                             child: Image.asset(
//                               "assets/icons/Direction.png",
//                               height: 50,
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//       bottomNavigationBar: GestureDetector(
//         onTap: () {
//           //Get.toNamed(Routes.addHappyHourBusinessScreen);
//           controller.onDataGet();
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Image.asset(
//             "assets/icons/Group 9711.png",
//             height: H * 0.2,
//           ),
//         ),
//       ),
//     );
//   }

//   Chip chipWidget(String text, function) {
//     return Chip(
//       padding: const EdgeInsets.only(right: 8, bottom: 8, top: 4),
//       deleteIcon: const Icon(
//         Icons.close,
//         color: whiteColor,
//       ),
//       onDeleted: function,
//       deleteIconColor: Colors.green,
//       label: Text(
//         text,
//         style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
//       ),
//       backgroundColor: primary,
//       elevation: 5,
//     );
//   }
// }
