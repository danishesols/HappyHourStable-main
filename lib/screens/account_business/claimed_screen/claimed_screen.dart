import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/constants.dart';
import 'package:happy_hour_app/data/models/happyhour_model.dart';
import 'package:happy_hour_app/global_widgets/happyhour_card.dart';
import 'package:happy_hour_app/screens/account_business/claimed_screen/claimed_controller.dart';

import '../../../core/colors.dart';
import '../../../data/providers/add_happyhour_provider.dart';
import '../../../global_controller/global_general_controller.dart';

class ClaimedScreen extends GetView<ClaimedController> {
  const ClaimedScreen({Key? key}) : super(key: key);

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
      body: GetBuilder<ClaimedController>(
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
                    query: AddHappyHourProvider().claimedFetchingQuery,
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
                            return GestureDetector(
                              onTap: () {
                                // Get.toNamed(
                                //     Routes.businessHappyHourDetailScreen,
                                //     arguments: happyHourModel);
                              },
                              child: ClaimedHappyhourCard(
                                title: happyHourModel.businessName.toString(),
                                image: happyHourModel.menuImage.toString(),
                                subtitle:
                                    happyHourModel.businessAddress.toString(),
                                timeIcon: "assets/icons/Group 11432@2x.png",
                                time: happyHourModel.day!.isEmpty
                                    ? ""
                                    : "${happyHourModel.day?[0]['HfromTime']}  - "
                                        "${happyHourModel.day?[0]['HtoTime']}",
                                rating: "assets/icons/Path 16148.svg",
                                rateCount: "(381)",
                                dialogShow: 'assets/icons/Group 11540@2x.png',
                                dialogPressed: () {
                                  Get.find<GlobalGeneralController>().dialogueCard(
                                      context,
                                      "Promote Happy Hour",
                                      "Do you want to promote this Happy hour?",
                                      "Promote", () {
                                    Get.find<GlobalGeneralController>()
                                        .successSnackbar(
                                            title: "Happy Hour",
                                            description: "Happy Hour Promoted");
                                    navigator?.pop(context);
                                  });
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
                                        child: InkWell(
                                          onTap: () async {
                                            // Navigator.pop(context);
                                            // await Get.toNamed(
                                            //     Routes.happyHourEditScreen,
                                            //     arguments: happyHourModel);
                                          },
                                          child: const Text("Edit"),
                                        ),
                                      ),
                                      PopupMenuItem(
                                        child: InkWell(
                                          onTap: () async {
                                            Navigator.pop(context);
                                            dialogueCard(
                                                context,
                                                'Duplicate',
                                                "Duplicate Happy Hour",
                                                "Do you want to Duplicate this Happy Hour?",
                                                primary, () {
                                              // Get.toNamed(
                                              //     Routes
                                              //         .duplicateBusinessAccountScreen,
                                              //     arguments: happyHourModel);
                                            });
                                          },
                                          child: const Text("Duplicate"),
                                        ),
                                      ),
                                      PopupMenuItem(
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
                                              // controller.deleteHour(
                                              //     happyHourModel.id);
                                            });
                                          },
                                          child: const Text("Delete"),
                                        ),
                                      ),
                                    ];
                                  },
                                ),
                              ),
                            );
                          });
                    }),
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
