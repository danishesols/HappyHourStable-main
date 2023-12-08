import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/constants.dart';
import 'package:happy_hour_app/data/models/happyhour_model.dart';
import 'package:happy_hour_app/global_widgets/happyhour_card.dart';
import 'package:happy_hour_app/routes/app_routes.dart';
import 'package:happy_hour_app/screens/account_business/subcription_screen/subcription_controller.dart';

import '../../../core/colors.dart';
import '../../../data/providers/add_happyhour_provider.dart';

class SubcriptionScreen extends GetView<SubcriptionController> {
  const SubcriptionScreen({Key? key}) : super(key: key);

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
          "Subscription",
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24),
        ),
        centerTitle: true,
      ),
      // extendBodyBehindAppBar: true,
      body: GetBuilder<SubcriptionController>(
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    "All Happy Hours Subscriptions",
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
                    query: AddHappyHourProvider().subcriptionFetchingQuery,
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
                              child: CustomHappyhourCard(
                                title: happyHourModel.businessName.toString(),
                                subtitle:
                                    happyHourModel.businessAddress.toString(),
                                timeIcon: "assets/icons/Group 11432.svg",
                                image: happyHourModel.businessImage.toString(),
                                time: "Thursday 07:00 : 08:00",
                                rating: const SizedBox(
                                  child: Text(
                                    "Monthly Package",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                  ),
                                ),
                                rateCount: "",
                                ontap: () {
                                  Get.toNamed(Routes.subcriptionDetail,
                                      arguments: happyHourModel);
                                },
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
