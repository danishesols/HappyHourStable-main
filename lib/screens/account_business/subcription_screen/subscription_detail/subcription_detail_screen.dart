import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/constants.dart';
import 'package:happy_hour_app/screens/account_business/subcription_screen/subscription_detail/subscription_detail_controller.dart';
import 'package:intl/intl.dart';

import '../../../../core/colors.dart';
import '../../../../global_widgets/main_button.dart';

class SubcriptionDetail extends GetView<SubcriptionDetailController> {
  const SubcriptionDetail({Key? key}) : super(key: key);

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
      body: GetBuilder<SubcriptionDetailController>(
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Happy Hours detail",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: H * 0.04,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 24.0, right: 24, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Title",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      Text(
                        controller.hour.businessName.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 24.0, right: 24, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Address",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Flexible(
                        child: Text(
                          controller.hour.businessAddress.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 24.0, right: 24, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Happy Hour Time",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      Text(
                        "${controller.hour.day?[0]['HfromTime'].toString()}"
                        "-  ${controller.hour.day?[0]['HtoTime'].toString()}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 24.0, right: 24, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Date Added",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      Text(
                        DateFormat('dd/MM/yyyy').add_jm().format(
                              DateTime.parse(controller.hour.addTime
                                      ?.toDate()
                                      .toString() ??
                                  ""),
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
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Packages detail",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: H * 0.02,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 24.0, right: 24, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Package Name",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      Text(
                        "Lorem Ipsum",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 24.0, right: 24, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Date Subscribed",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      Text(
                        "Lorem Ipsum",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 24.0, right: 24, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Duration",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      Text(
                        "Lorem Ipsum",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 24.0, right: 24, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Price",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                      Text(
                        "Lorem Ipsum",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                // const Center(
                //   child: CircularProgressIndicator(),
                // )
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 32),
        child: SizedBox(
          height: H * 0.09,
          child: CustomElevatedButtonWidget(
            onPressed: () {
              dialogueCard(context, "Yes", "Unsubscibe",
                  "Are you sure you want to unsubscribe?", primary, () {
                Get.back();
                successDialog(context, "Successfully Unsubscribed", "Done", () {
                  Get.back();
                });
              });
            },
            text: "Unsubscribe",
            textColor: blackColor,
            fontSize: 24,
            verticalPadding: 0,
            borderRadius: 45,
          ),
        ),
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
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
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

Future<dynamic> successDialog(
  BuildContext context,
  String text,
  String confirmText,
  VoidCallback onConfrim,
) {
  return showDialog(
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
            SizedBox(
              height: H * 0.04,
            ),
            Center(
              child: Container(
                height: 150,
                width: 400,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/icons/Group 8550@2x.png"),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: H * 0.04,
            ),
            Center(
              child: Text(
                text,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: H * 0.05,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45),
                  ),
                  minimumSize: Size(W * 0.8, H * 0.08),
                ),
                onPressed: onConfrim,
                child: Text(
                  confirmText,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SizedBox(height: H * 0.03),
          ],
        ),
      );
    },
  );
}
