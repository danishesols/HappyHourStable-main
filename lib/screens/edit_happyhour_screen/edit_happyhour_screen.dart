import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/constants.dart';
import 'package:happy_hour_app/data/models/happyhour_model.dart';
import 'package:happy_hour_app/global_widgets/happyhour_card.dart';
import 'package:happy_hour_app/screens/edit_happyhour_screen/edit_happyhour_screen_controller.dart';
import 'package:intl/intl.dart';

import '../../core/colors.dart';
import '../../data/providers/add_happyhour_provider.dart';
import '../../global_controller/global_general_controller.dart';
import '../../global_widgets/main_button.dart';
import '../../routes/app_routes.dart';

class EditHappyHourScreen extends GetView<EditHappyHourScreenController> {
  const EditHappyHourScreen({Key? key}) : super(key: key);

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
      ),
      // extendBodyBehindAppBar: true,
      body: GetBuilder<EditHappyHourScreenController>(
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Claimed Happy Hours",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: H * 0.04,
                ),

                // const Center(
                //   child: CircularProgressIndicator(),
                // )
                FirestoreQueryBuilder<HappyHourModel>(
                    query: AddHappyHourProvider().editFetchingQuery,
                    builder: (context, snapshot, _) {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.docs.length,
                          itemBuilder: (context, index) {
                            if (snapshot.hasMore &&
                                index + 1 == snapshot.docs.length) {
                              snapshot.fetchMore();
                            }
                            //===== Data is now typed!
                            HappyHourModel happyHourModel =
                                snapshot.docs[index].data();
                            happyHourModel.id = snapshot.docs[index].id;
                            return InkWell(
                              onTap: () async {
                                Navigator.pop(context);
                                await Get.toNamed(Routes.happyHourEditScreen,
                                    arguments: happyHourModel);
                              },
                              child: ClaimedHappyhourCard(
                                title: happyHourModel.businessName.toString(),
                                image: happyHourModel.businessImage.toString(),
                                subtitle:
                                    happyHourModel.businessAddress.toString(),
                                timeIcon: "assets/icons/Group 11432@2x.png",
                                time: happyHourModel.day!.isNotEmpty
                                    ? "${happyHourModel.day?.first['HfromTime']}  - "
                                        "${happyHourModel.day?.first['HtoTime']}"
                                    : happyHourModel.dayLate!.isNotEmpty
                                        ? "${happyHourModel.dayLate?.first['HfromTime2']}  - "
                                            "${happyHourModel.dayLate?.first['HtoTime2']}"
                                        : happyHourModel
                                                .dailySpecils!.isNotEmpty
                                            ? "${happyHourModel.dailySpecils?.first['fromTime']}  - "
                                                "${happyHourModel.dailySpecils?.first['toTime']}"
                                            : "",
                                rating: "assets/icons/Path 16148.svg",
                                rateCount: happyHourModel.reviewStar?.length
                                        .toString() ??
                                    "",
                                dialogShow: happyHourModel.promoted ?? false
                                    ? "assets/icons/Group 11540-2@2x.png"
                                    : "assets/icons/Group 11540@2x.png",
                                dialogPressed: () {
                                  if (happyHourModel.promoted == true) {
                                    detailDialog(
                                        context,
                                        happyHourModel.businessName.toString(),
                                        happyHourModel.businessAddress,
                                        happyHourModel.day,
                                        happyHourModel.addTime, () {
                                      Get.back();
                                    }, () {
                                      Navigator.pop(context);
                                      controller
                                          .onPromotedClick(happyHourModel.id);
                                    });
                                  } else {
                                    Get.find<GlobalGeneralController>()
                                        .dialogueCard(
                                            context,
                                            "Promote Happy Hour",
                                            "Do you want to promote this Happy hour?",
                                            "Promote", () {
                                      navigator?.pop(context);
                                      Get.toNamed(Routes.checkOutClaimScreen,
                                          arguments: happyHourModel.id);
                                    });
                                  }
                                },
                                popUpMenu: PopupMenuButton(
                                  elevation: 5,
                                  icon: const Icon(
                                    Icons.more_vert_outlined,
                                    size: 40,
                                  ),
                                  itemBuilder: (
                                    context,
                                  ) {
                                    return [
                                      PopupMenuItem(
                                        padding: const EdgeInsets.all(0),
                                        child: InkWell(
                                          onTap: () async {
                                            Navigator.pop(context);
                                            await Get.toNamed(
                                                Routes.happyHourEditScreen,
                                                arguments: happyHourModel);
                                          },
                                          child: const ListTile(
                                            contentPadding: EdgeInsets.all(0),
                                            title: Text("  Edit"),
                                          ),
                                        ),
                                      ),
                                      PopupMenuItem(
                                        padding: const EdgeInsets.all(0),
                                        child: InkWell(
                                          onTap: () async {
                                            Navigator.pop(context);
                                            dialogueCard(
                                                context,
                                                'Duplicate',
                                                "Duplicate Happy Hour",
                                                "Do you want to Duplicate this Happy Hour?",
                                                primary, () {
                                              Navigator.pop(context);
                                              Get.toNamed(
                                                  Routes
                                                      .duplicateBusinessAccountScreen,
                                                  arguments: happyHourModel);
                                            });
                                          },
                                          child: const ListTile(
                                            contentPadding: EdgeInsets.all(0),
                                            title: Text("  Duplicate"),
                                          ),
                                        ),
                                      ),
                                      PopupMenuItem(
                                        padding: const EdgeInsets.all(0),
                                        child: InkWell(
                                          onTap: () async {
                                            Navigator.pop(context);
                                            dialogueCard(
                                                context,
                                                'Delete',
                                                "Delete This Happy Hour",
                                                "Do you want to Delete this business?",
                                                primary, () {
                                              // print(happyHourModel.id);
                                              controller.deleteHour(
                                                  happyHourModel.id);
                                              controller.update();
                                            });
                                          },
                                          child: const ListTile(
                                            contentPadding: EdgeInsets.all(0),
                                            title: Text("  Delete"),
                                          ),
                                        ),
                                      ),
                                      PopupMenuItem(
                                        padding: const EdgeInsets.all(0),
                                        child: InkWell(
                                          onTap: () async {
                                            Navigator.pop(context);
                                            Get.toNamed(Routes.editDetailScreen,
                                                arguments: happyHourModel);
                                          },
                                          child: const ListTile(
                                            contentPadding: EdgeInsets.all(0),
                                            title: Text(" Customer View"),
                                          ),
                                        ),
                                      ),
                                    ];
                                  },
                                ),
                              ),
                            );
                          });
                    }
                    // Expanded(
                    //   child: ListView.builder(
                    //     shrinkWrap: true,
                    //     itemCount: 1,
                    //     itemBuilder: (context, index) {
                    //       return GestureDetector(
                    //         onTap: () {
                    //           Get.toNamed(Routes.happyHourEditScreen);
                    //         },
                    //         child: ClaimedHappyhourCard(
                    //           title: "lorem ipsum Store",
                    //           image: "assets/icons/Group 9200.png",
                    //           subtitle: "New york USA (500 m away)",
                    //           timeIcon: "assets/icons/Group 11432@2x.png",
                    //           time: "Thursday 05:00-06:00",
                    //           rating: "assets/icons/Path 16148.svg",
                    //           rateCount: "(381)",
                    //           dialogShow: 'assets/icons/Group 11540@2x.png',
                    //           dialogPressed: () {
                    //             Get.find<GlobalGeneralController>().dialogueCard(
                    //                 context,
                    //                 "Promote Happy Hour",
                    //                 "Do you want to promote this Happy hour?",
                    //                 "Promote", () {
                    //               Get.find<GlobalGeneralController>().successSnackbar(
                    //                   title: "Happy Hour",
                    //                   description: "Happy Hour Promoted");
                    //               navigator?.pop(context);
                    //             });
                    //           },
                    //           popUpMenu: PopupMenuButton(
                    //             icon: const Icon(
                    //               Icons.more_vert_outlined,
                    //               size: 40,
                    //             ),
                    //             itemBuilder: (
                    //               context,
                    //             ) {
                    //               return [
                    //                 PopupMenuItem(
                    //                   child: InkWell(
                    //                     onTap: () async {
                    //                       Navigator.pop(context);
                    //                       await Get.toNamed(
                    //                         Routes.happyHourEditScreen,
                    //                       );
                    //                     },
                    //                     child: const Text("Edit"),
                    //                   ),
                    //                 ),
                    //                 PopupMenuItem(
                    //                   child: InkWell(
                    //                     onTap: () async {
                    //                       Navigator.pop(context);
                    //                       await Get.toNamed(
                    //                           Routes.duplicateBusinessAccountScreen);
                    //                     },
                    //                     child: const Text("Duplicate"),
                    //                   ),
                    //                 ),
                    //                 PopupMenuItem(
                    //                   child: InkWell(
                    //                     onTap: () async {
                    //                       Navigator.pop(context);
                    //                       await Get.find<GlobalGeneralController>()
                    //                           .errorSnackbar(
                    //                               title: "Deleted",
                    //                               description: "Happy hour Deleted!");
                    //                     },
                    //                     child: const Text("Delete"),
                    //                   ),
                    //                 ),
                    //               ];
                    //             },
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Future<dynamic> dialogueCard(
  BuildContext context,
  String confirm,
  String title,
  String middleText,
  Color? confirmBColor,
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
                        primary: confirmBColor ?? primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35),
                        ),
                        minimumSize: Size(W * 0.32, H * 0.072),
                      ),
                      onPressed: onConfrim,
                      child: Text(
                        confirm,
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

Future<dynamic> detailDialog(
  BuildContext context,
  String name,
  address,
  time1,
  addTime,
  VoidCallback onConfrim,
  VoidCallback onConfrim2,
) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0, right: 16.0),
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/icons/Group 2062.png"),
                    ),
                  ),
                ),
              ),
              onTap: () {
                Get.back();
              },
            ),
            const Center(
              child: Text(
                "Promote Happy Hour",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
            ),
            SizedBox(
              height: H * 0.04,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Title",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Address",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Flexible(
                    child: Text(
                      address,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Happy Hour Time",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  Text(
                    "${time1?[0]['HfromTime'].toString()}"
                    "-  ${time1?[0]['HtoTime'].toString()}",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Date Added",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  Text(
                    DateFormat('dd/MM/yyyy').add_jm().format(
                          DateTime.parse(addTime?.toDate().toString() ?? ""),
                        ),
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: H * 0.04,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Packages detail",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  SizedBox(),
                ],
              ),
            ),
            SizedBox(
              height: H * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Package Name",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  Text(
                    "Lorem Ipsum",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Date Subscribed",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  Text(
                    "Lorem Ipsum",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Duration",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  Text(
                    "Lorem Ipsum",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Price",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                  Text(
                    "Lorem Ipsum",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: H * 0.03,
            ),
            Center(
              child: SizedBox(
                width: W * 0.8,
                child: CustomElevatedButtonWidget(
                  borderRadius: 35,
                  fontSize: 24,
                  textColor: blackColor,
                  text: ("Close"),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ),
            SizedBox(height: H * 0.02),
            Center(
              child: GestureDetector(
                onTap: onConfrim2,
                child: const Text("Unsubscribe"),
              ),
            ),
            SizedBox(height: H * 0.04),
            // const Center(
            //   child: CircularProgressIndicator(),
            // )
          ],
        ),
      );
    },
  );
}

Future<dynamic> threeButtonDialog(
  BuildContext context,
  String buttonText,
  VoidCallback onConfrim,
  String buttonText2,
  VoidCallback onConfrim2,
  String buttonText3,
  VoidCallback onConfrim3,
) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0, right: 16.0),
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/icons/Group 2062.png"),
                    ),
                  ),
                ),
              ),
              onTap: () {
                Get.back();
              },
            ),
            SizedBox(
              height: H * 0.01,
            ),
            Center(
              child: CustomElevatedButtonWidget(
                horizontalPadding: 60,
                verticalPadding: 22,
                borderRadius: 35,
                fontSize: 24,
                textColor: blackColor,
                text: (buttonText),
                onPressed: onConfrim,
              ),
            ),
            SizedBox(
              height: H * 0.03,
            ),
            Center(
              child: CustomElevatedButtonWidget(
                horizontalPadding: 60,
                verticalPadding: 22,
                borderRadius: 35,
                fontSize: 24,
                textColor: blackColor,
                text: (buttonText2),
                onPressed: onConfrim2,
              ),
            ),
            SizedBox(
              height: H * 0.03,
            ),
            Center(
              child: CustomElevatedButtonWidget(
                horizontalPadding: 60,
                verticalPadding: 22,
                borderRadius: 35,
                fontSize: 24,
                textColor: blackColor,
                text: (buttonText3),
                onPressed: onConfrim3,
              ),
            ),
            SizedBox(height: H * 0.03),
          ],
        ),
      );
    },
  );
}
