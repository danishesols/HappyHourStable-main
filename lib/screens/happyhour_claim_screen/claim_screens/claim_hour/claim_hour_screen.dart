import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/constants.dart';

import '../../../../core/colors.dart';
import '../../../../global_widgets/main_button.dart';
import '../claim_controller.dart';

class ClaimHourScreen extends GetView<ClaimController> {
  const ClaimHourScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
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
        title: const Text("Add Happy Hour"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.hourBformKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: H * 0.009,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  "Add Business Hour",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: H * 0.02,
              ),
              Padding(
                padding: EdgeInsets.only(left: W * 0.11, right: W * 0.2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Day",
                      style: TextStyle(
                        fontSize: 18,
                        color: blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "From",
                      style: TextStyle(
                        fontSize: 18,
                        color: blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "To",
                      style: TextStyle(
                        fontSize: 18,
                        color: blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: H * 0.01,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.dayFromTimeToTimeList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => Transform.scale(
                            scale: 0.6,
                            child: Card(
                              margin: const EdgeInsets.all(1),
                              elevation: 6,
                              shape: const StadiumBorder(),
                              child: Transform.scale(
                                scale: 2.0,
                                child: Checkbox(
                                    checkColor: Theme.of(context).primaryColor,
                                    splashRadius: 20,
                                    shape: const StadiumBorder(),
                                    side: BorderSide.none,
                                    value: controller
                                        .dayFromTimeToTimeList[index]
                                        .isSelect
                                        .value,
                                    onChanged: (v) {
                                      controller.bUpdateDay(index);
                                    }),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: W * 0.26,
                          child: Text(
                            controller.dayFromTimeToTimeList[index].day,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                        ),
                        SizedBox(
                          width: W * 0.3,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(45),
                            ),
                            elevation: 5,
                            child: SizedBox(
                              height: H * 0.04,
                              width: W * 0.3,
                              child: Obx(
                                () => DropdownButtonFormField<String>(
                                  value: controller.dayFromTimeToTimeList[index]
                                          .isSelect.isTrue
                                      ? controller
                                          .hour.fromTimeToTime![0]['bFtime']
                                          .toString()
                                      : "Select Time",
                                  elevation: 15,
                                  decoration: const InputDecoration(
                                    enabled: false,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        16.0, 2.0, 8.0, 2.0),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(45)),
                                    ),
                                  ),
                                  isExpanded: true,
                                  hint: const Text(
                                    "Select Time",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: controller.dayFromTimeToTimeList[index]
                                          .isSelect.isTrue
                                      ? controller.timesList
                                          .map((time) => DropdownMenuItem(
                                                value: time,
                                                child: Text(
                                                  time,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ))
                                          .toList()
                                      : [],
                                  onChanged: (fromTime) {
                                    controller.bFromtime = fromTime!;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: W * 0.3,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(45),
                            ),
                            elevation: 5,
                            child: SizedBox(
                              height: H * 0.04,
                              width: W * 0.3,
                              child: Obx(
                                () => DropdownButtonFormField<String>(
                                  value: controller.dayFromTimeToTimeList[index]
                                          .isSelect.isTrue
                                      ? controller
                                          .hour.fromTimeToTime![0]['bTtime']
                                          .toString()
                                      : "Select Time",
                                  elevation: 15,
                                  decoration: const InputDecoration(
                                    enabled: false,
                                    contentPadding: EdgeInsets.fromLTRB(
                                        16.0, 2.0, 8.0, 2.0),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(45)),
                                    ),
                                  ),
                                  isExpanded: true,
                                  hint: const Text(
                                    "Select Time",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: controller.dayFromTimeToTimeList[index]
                                          .isSelect.isTrue
                                      ? controller.timesList
                                          .map((time) => DropdownMenuItem(
                                                value: time,
                                                child: Text(
                                                  time,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ))
                                          .toList()
                                      : [],
                                  onChanged: (toTime) {
                                    controller.bTotime = toTime!;
                                    controller.bDayTime();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 30.0),
        child: SizedBox(
          height: H * 0.09,
          width: W,
          child: CustomElevatedButtonWidget(
            onPressed: () {
              controller.onHourScreenDoneTap();
              // Get.toNamed(Routes.businessDayTimeScreen);
            },
            text: "Done",
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
