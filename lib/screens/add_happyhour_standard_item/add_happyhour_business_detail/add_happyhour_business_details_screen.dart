import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/colors.dart';
import '../../../core/constants.dart';
import '../../../global_controller/global_general_controller.dart';
import '../../../global_widgets/main_button.dart';
import '../add_happyhour_controller.dart';

class AddHappyHourBusinessDetailScreen extends GetView<AddHappyhourController> {
  const AddHappyHourBusinessDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddHappyhourController>(builder: (controller) {
      return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                for (var e in controller.testingDayTimeList) {
                  e.isSelect = false.obs;
                }
                Get.back();
              },
              icon: SvgPicture.asset(
                "assets/icons/Group 9108.svg",
                height: 25,
                width: 25,
              )),
          title: const Text("Add Happy Hour Hours"),
          centerTitle: true,
        ),
        body: Form(
          key: controller.businessKey,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: RawScrollbar(
              thumbColor: primary,
              // trackColor: whiteColor,
              // thumbVisibility: true,
              // trackVisibility: true,
              radius: const Radius.circular(20),
              thickness: 10,
              child: ListView(
                controller: controller.scrollController,
                children: [
                  SizedBox(
                    height: H * 0.009,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Happy Hour",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: H * 0.009,
                  ),
                  titleFromTo(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45),
                        ),
                        elevation: 5,
                        child: SizedBox(
                          height: H * 0.05,
                          width: W * 0.36,
                          child: DropdownButtonFormField<String>(
                            // validator: (value) {
                            //   if (value == null || value.trim().isEmpty) {
                            //     return 'select';
                            //   }

                            //   return null;
                            // },
                            elevation: 15,
                            value: controller.hfromTime ?? "Select Time",
                            decoration: const InputDecoration(
                              enabled: false,
                              contentPadding:
                                  EdgeInsets.fromLTRB(12.0, 2.0, 8.0, 2.0),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(45),
                                ),
                              ),
                            ),
                            isExpanded: true,
                            hint: const Text(
                              "Select Time",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: controller.timesList
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
                                .toList(),
                            onChanged: controller.showDayList
                                ? null
                                : (time) {
                                    controller.hfromTime = time!;
                                  },
                          ),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45),
                        ),
                        elevation: 5,
                        child: SizedBox(
                          height: H * 0.05,
                          width: W * 0.36,
                          child: DropdownButtonFormField<String>(
                            // validator: (value) {
                            //   if (value == null || value.trim().isEmpty) {
                            //     return 'select';
                            //   }

                            //   return null;
                            // },
                            value: controller.htoTime ?? "Select Time",
                            elevation: 15,
                            decoration: const InputDecoration(
                              enabled: false,
                              contentPadding:
                                  EdgeInsets.fromLTRB(12.0, 2.0, 8.0, 2.0),
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
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: controller.timesList
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
                                .toList(),
                            onChanged: controller.showDayList
                                ? null
                                : (time) {
                                    controller.htoTime = time!;
                                  },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Obx(
                    () => AbsorbPointer(
                      absorbing: controller.showDayList,
                      child: SizedBox(
                        height: 50,
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: [
                            Row(
                              children: [
                                Transform.scale(
                                  scale: 0.47,
                                  child: Obx(
                                    () => Card(
                                      margin: const EdgeInsets.all(1),
                                      elevation: 3,
                                      shape: const StadiumBorder(),
                                      child: Transform.scale(
                                        scale: 2.0,
                                        child: Checkbox(
                                            activeColor: primary,
                                            checkColor: Colors.amber,
                                            splashRadius: 20,
                                            shape: const StadiumBorder(),
                                            side: BorderSide.none,
                                            value: controller
                                                .testingDayTimeList[0].isSelect.value,
                                            onChanged: (val) {
                                              controller.testingDayTimeList[0].isSelect
                                                      .value =
                                                  !controller.testingDayTimeList[0]
                                                      .isSelect.value;
                                              if (controller.testingDayTimeList[0]
                                                  .isSelect.isTrue) {
                                                controller.testingDayTimeList[0]
                                                    .isEarly.value = true;
                                                controller.testingDayTimeList[0]
                                                        .fromTime =
                                                    controller.hfromTime!;
                                                controller
                                                        .testingDayTimeList[0].toTime =
                                                    controller.htoTime!;
                                                controller.addToHday(0);
                                              }
                                            }),
                                      ),
                                    ),
                                  ),
                                ),
                                const Text(
                                  "S",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Transform.scale(
                                  scale: 0.47,
                                  child: Obx(
                                    () => Card(
                                      margin: const EdgeInsets.all(1),
                                      elevation: 3,
                                      shape: const StadiumBorder(),
                                      child: Transform.scale(
                                        scale: 2.0,
                                        child: Checkbox(
                                            activeColor: primary,
                                            checkColor: Colors.amber,
                                            splashRadius: 20,
                                            shape: const StadiumBorder(),
                                            side: BorderSide.none,
                                            value: controller
                                                .testingDayTimeList[1].isSelect.value,
                                            onChanged: (val) {
                                              // controller.isTue = !controller.isTue;
                                              controller.testingDayTimeList[1].isSelect
                                                      .value =
                                                  !controller.testingDayTimeList[1]
                                                      .isSelect.value;
                                              if (controller.testingDayTimeList[1]
                                                  .isSelect.isTrue) {
                                                controller.testingDayTimeList[1]
                                                    .isEarly.value = true;
                                                controller.testingDayTimeList[1]
                                                        .fromTime =
                                                    controller.hfromTime!;
                                                controller
                                                        .testingDayTimeList[1].toTime =
                                                    controller.htoTime!;
                                                controller.addToHday(1);
                                              }
                                            }),
                                      ),
                                    ),
                                  ),
                                ),
                                const Text(
                                  "M",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Transform.scale(
                                  scale: 0.47,
                                  child: Obx(
                                    () => Card(
                                      margin: const EdgeInsets.all(1),
                                      elevation: 3,
                                      shape: const StadiumBorder(),
                                      child: Transform.scale(
                                        scale: 2.0,
                                        child: Checkbox(
                                            activeColor: primary,
                                            checkColor: Colors.amber,
                                            splashRadius: 20,
                                            shape: const StadiumBorder(),
                                            side: BorderSide.none,
                                            value: controller
                                                .testingDayTimeList[2].isSelect.value,
                                            onChanged: (val) {
                                              controller.testingDayTimeList[2].isSelect
                                                      .value =
                                                  !controller.testingDayTimeList[2]
                                                      .isSelect.value;
                                              //controller.isWed = !controller.isWed;
                                              if (controller.testingDayTimeList[2]
                                                  .isSelect.isTrue) {
                                                controller.testingDayTimeList[2]
                                                    .isEarly.value = true;
                                                controller.testingDayTimeList[2]
                                                        .fromTime =
                                                    controller.hfromTime!;
                                                controller
                                                        .testingDayTimeList[2].toTime =
                                                    controller.hfromTime!;

                                                controller.addToHday(2);
                                              }
                                            }),
                                      ),
                                    ),
                                  ),
                                ),
                                const Text(
                                  "T",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Transform.scale(
                                  scale: 0.47,
                                  child: Obx(
                                    () => Card(
                                      margin: const EdgeInsets.all(1),
                                      elevation: 3,
                                      shape: const StadiumBorder(),
                                      child: Transform.scale(
                                        scale: 2.0,
                                        child: Checkbox(
                                            activeColor: primary,
                                            checkColor: Colors.amber,
                                            splashRadius: 20,
                                            shape: const StadiumBorder(),
                                            side: BorderSide.none,
                                            value: controller
                                                .testingDayTimeList[3].isSelect.value,
                                            onChanged: (val) {
                                              // controller.isThu = !controller.isThu;

                                              controller.testingDayTimeList[3].isSelect
                                                      .value =
                                                  !controller.testingDayTimeList[3]
                                                      .isSelect.value;
                                              if (controller.testingDayTimeList[3]
                                                  .isSelect.isTrue) {
                                                controller.testingDayTimeList[3]
                                                    .isEarly.value = true;
                                                controller.testingDayTimeList[3]
                                                        .fromTime =
                                                    controller.hfromTime!;
                                                controller
                                                        .testingDayTimeList[3].toTime =
                                                    controller.htoTime!;
                                                controller.addToHday(3);
                                              }
                                            }),
                                      ),
                                    ),
                                  ),
                                ),
                                const Text(
                                  "W",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Transform.scale(
                                  scale: 0.47,
                                  child: Obx(
                                    () => Card(
                                      margin: const EdgeInsets.all(1),
                                      elevation: 3,
                                      shape: const StadiumBorder(),
                                      child: Transform.scale(
                                        scale: 2.0,
                                        child: Checkbox(
                                            activeColor: primary,
                                            checkColor: Colors.amber,
                                            splashRadius: 20,
                                            shape: const StadiumBorder(),
                                            side: BorderSide.none,
                                            value: controller
                                                .testingDayTimeList[4].isSelect.value,
                                            onChanged: (val) {
                                              controller.testingDayTimeList[4].isSelect
                                                      .value =
                                                  !controller.testingDayTimeList[4]
                                                      .isSelect.value;
                                              if (controller.testingDayTimeList[4]
                                                  .isSelect.isTrue) {
                                                controller.testingDayTimeList[4]
                                                    .isEarly.value = true;
                                                controller.testingDayTimeList[4]
                                                        .fromTime =
                                                    controller.hfromTime!;
                                                controller
                                                        .testingDayTimeList[4].toTime =
                                                    controller.htoTime!;
                                                controller.addToHday(4);
                                              }
                                            }),
                                      ),
                                    ),
                                  ),
                                ),
                                const Text(
                                  "T",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Transform.scale(
                                  scale: 0.47,
                                  child: Obx(
                                    () => Card(
                                      margin: const EdgeInsets.all(1),
                                      elevation: 3,
                                      shape: const StadiumBorder(),
                                      child: Transform.scale(
                                        scale: 2.0,
                                        child: Checkbox(
                                            activeColor: primary,
                                            checkColor: Colors.amber,
                                            splashRadius: 20,
                                            shape: const StadiumBorder(),
                                            side: BorderSide.none,
                                            value: controller
                                                .testingDayTimeList[5].isSelect.value,
                                            onChanged: (val) {
                                              // controller.isSat = !controller.isSat;
                                              controller.testingDayTimeList[5].isSelect
                                                      .value =
                                                  !controller.testingDayTimeList[5]
                                                      .isSelect.value;
                                              if (controller.testingDayTimeList[5]
                                                  .isSelect.isTrue) {
                                                controller.testingDayTimeList[5]
                                                    .isEarly.value = true;
                                                controller.testingDayTimeList[5]
                                                        .fromTime =
                                                    controller.hfromTime!;
                                                controller
                                                        .testingDayTimeList[5].toTime =
                                                    controller.htoTime!;
                                                controller.addToHday(5);
                                              }
                                            }),
                                      ),
                                    ),
                                  ),
                                ),
                                const Text(
                                  "F",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Transform.scale(
                                  scale: 0.47,
                                  child: Obx(
                                    () => Card(
                                      margin: const EdgeInsets.all(1),
                                      elevation: 3,
                                      shape: const StadiumBorder(),
                                      child: Transform.scale(
                                        scale: 2.0,
                                        child: Checkbox(
                                            activeColor: primary,
                                            checkColor: Colors.amber,
                                            splashRadius: 20,
                                            shape: const StadiumBorder(),
                                            side: BorderSide.none,
                                            value: controller
                                                .testingDayTimeList[6].isSelect.value,
                                            onChanged: (val) {
                                              // controller.isSun = !controller.isSun;
                                              controller.testingDayTimeList[6].isSelect
                                                      .value =
                                                  !controller.testingDayTimeList[6]
                                                      .isSelect.value;
                                              if (controller.testingDayTimeList[6]
                                                  .isSelect.isTrue) {
                                                controller.testingDayTimeList[6]
                                                    .isEarly.value = true;
                                                controller.testingDayTimeList[6]
                                                        .fromTime =
                                                    controller.hfromTime!;
                                                controller
                                                        .testingDayTimeList[6].toTime =
                                                    controller.htoTime!;
                                                controller.addToHday(6);
                                              }
                                            }),
                                      ),
                                    ),
                                  ),
                                ),
                                const Text(
                                  "S",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: W * 0.3,
                      right: W * 0.34,
                    ),
                    child: CustomElevatedButtonWidget(
                      onPressed: () {
                        var index = controller.testingDayTimeList
                            .where((e) => e.isSelect.isTrue)
                            .length;

                        if (controller.hfromTime != null &&
                            controller.htoTime != null &&
                            index != 0) {
                          controller.showDayList = true;

                          controller.update();
                          controller.animateToIndex(5);
                        } else {
                          Get.find<GlobalGeneralController>().errorSnackbar(
                              title: "Time",
                              description: "Select Time and day ");
                          controller.update();
                        }
                      },
                      verticalPadding: 0,
                      text: "submit",
                      textColor: blackColor,
                      fontSize: 16,
                      borderRadius: 45,
                    ),
                  ),
                  SizedBox(
                    height: H * 0.03,
                  ),
                  Obx(() => Visibility(
                        visible: controller.showDayList,
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.testingDayTimeList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    left: W * 0.01, right: W * 0.06),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Transform.scale(
                                          scale: 0.6,
                                          child: Obx(
                                            () => Card(
                                              margin: const EdgeInsets.all(1),
                                              elevation: 3,
                                              shape: const StadiumBorder(),
                                              child: Transform.scale(
                                                scale: 2.0,
                                                child: Checkbox(
                                                    checkColor: Colors.amber,
                                                    splashRadius: 20,
                                                    shape:
                                                        const StadiumBorder(),
                                                    side: BorderSide.none,
                                                    value: controller
                                                        .testingDayTimeList[index]
                                                        .isSelect
                                                        .value,
                                                    onChanged: (val) {
                                                      controller
                                                              .testingDayTimeList[index]
                                                              .isSelect
                                                              .value =
                                                          !controller
                                                              .testingDayTimeList[
                                                                  index]
                                                              .isSelect
                                                              .value;

                                                      controller
                                                          .hUpdateDay(index);
                                                      if (controller
                                                          .testingDayTimeList[index]
                                                          .isSelect
                                                          .isTrue) {
                                                        controller
                                                            .testingDayTimeList[index]
                                                            .isEarly
                                                            .value = true;
                                                        controller
                                                            .testingDayTimeList[index]
                                                            .fromTime = controller
                                                                .hfromTime ??
                                                            "";
                                                        controller
                                                            .testingDayTimeList[index]
                                                            .toTime = controller
                                                                .htoTime ??
                                                            "";
                                                        controller
                                                            .addToHday(index);
                                                        // controller.businessKey
                                                        //     .currentState!
                                                        //     .reset();
                                                        // controller
                                                        //     .dayTimeList[index]
                                                        //     .isEarly
                                                        //     .value = false;
                                                        // controller
                                                        //     .dayTimeList[index]
                                                        //     .isLate
                                                        //     .value = false;
                                                      } else {}
                                                    }),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: W * 0.24,
                                          child: Text(
                                            controller.testingDayTimeList[index].day,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        Obx(
                                          () => Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(45),
                                            ),
                                            elevation: 5,
                                            child: SizedBox(
                                              height: H * 0.04,
                                              width: W * 0.26,
                                              child: DropdownButtonFormField<
                                                  String>(
                                                validator: controller
                                                        .testingDayTimeList[index]
                                                        .isSelect
                                                        .isTrue
                                                    ? (value) {
                                                        if (value == null ||
                                                            value
                                                                .trim()
                                                                .isEmpty) {
                                                          return 'select';
                                                        }

                                                        return null;
                                                      }
                                                    : null,
                                                value: controller.hfromTime,
                                                elevation: 15,
                                                decoration:
                                                    const InputDecoration(
                                                  enabled: false,
                                                  contentPadding:
                                                      EdgeInsets.fromLTRB(
                                                          12.0, 2.0, 8.0, 2.0),
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                45)),
                                                  ),
                                                ),
                                                isExpanded: true,
                                                hint: const Text(
                                                  "Select Time",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey),
                                                ),
                                                icon: const Icon(
                                                    Icons.keyboard_arrow_down),
                                                items: controller
                                                        .testingDayTimeList[index]
                                                        .isSelect
                                                        .isTrue
                                                    ? controller.timesList
                                                        .map((time) =>
                                                            DropdownMenuItem(
                                                              value: time,
                                                              child: Text(
                                                                time,
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ))
                                                        .toList()
                                                    : [],
                                                onChanged: (time) {
                                                  controller.testingDayTimeList[index]
                                                      .fromTime = time!;
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Obx(
                                          () => Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(45),
                                            ),
                                            elevation: 5,
                                            child: SizedBox(
                                              height: H * 0.04,
                                              width: W * 0.26,
                                              child: DropdownButtonFormField<
                                                  String>(
                                                value: controller.htoTime,
                                                validator: controller
                                                        .testingDayTimeList[index]
                                                        .isSelect
                                                        .isTrue
                                                    ? (value) {
                                                        if (value == null ||
                                                            value
                                                                .trim()
                                                                .isEmpty) {
                                                          return 'select';
                                                        }
                                                        return null;
                                                      }
                                                    : null,
                                                elevation: 15,
                                                decoration:
                                                    const InputDecoration(
                                                  enabled: false,
                                                  contentPadding:
                                                      EdgeInsets.fromLTRB(
                                                          12.0, 2.0, 8.0, 2.0),
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                45)),
                                                  ),
                                                ),
                                                isExpanded: true,
                                                hint: const Text(
                                                  "Select Time",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey),
                                                ),
                                                icon: const Icon(
                                                    Icons.keyboard_arrow_down),
                                                items: controller
                                                        .testingDayTimeList[index]
                                                        .isSelect
                                                        .isTrue
                                                    ? controller.timesList
                                                        .map((time) =>
                                                            DropdownMenuItem(
                                                              value: time,
                                                              child: Text(
                                                                time,
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ))
                                                        .toList()
                                                    : [],
                                                onChanged: (time) {
                                                  controller.testingDayTimeList[index]
                                                      .toTime = time!;
                                                  controller.hDayTime(index);
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
                      )),
                  SizedBox(
                    height: H * 0.04,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.showLate = !controller.showLate;
                      controller.update();
                    },
                    child: Center(
                      child: Text(
                        !controller.showLate
                            ? "▼ Add Late Happy Hour"
                            : "▲ Remove Late Happy Hour",
                        style: const TextStyle(
                          fontSize: 24,
                          color: primary,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => Visibility(
                      visible: controller.showLate,
                      child: Column(
                        children: [
                          SizedBox(
                            height: H * 0.009,
                          ),
                          titleFromTo(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(45),
                                ),
                                elevation: 5,
                                child: SizedBox(
                                  height: H * 0.05,
                                  width: W * 0.36,
                                  child: DropdownButtonFormField<String>(
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'select';
                                      }

                                      return null;
                                    },
                                    elevation: 15,
                                    decoration: const InputDecoration(
                                      enabled: false,
                                      contentPadding: EdgeInsets.fromLTRB(
                                          12.0, 2.0, 8.0, 2.0),
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(45)),
                                      ),
                                    ),
                                    isExpanded: true,
                                    hint: const Text(
                                      "Select Time",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: controller.timesList
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
                                        .toList(),
                                    onChanged: controller.showLateDayList
                                        ? null
                                        : (time) {
                                            controller.hfromTime2 = time!;
                                          },
                                  ),
                                ),
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(45),
                                ),
                                elevation: 5,
                                child: SizedBox(
                                  height: H * 0.05,
                                  width: W * 0.36,
                                  child: DropdownButtonFormField<String>(
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'select';
                                      }

                                      return null;
                                    },
                                    elevation: 15,
                                    decoration: const InputDecoration(
                                      enabled: false,
                                      contentPadding: EdgeInsets.fromLTRB(
                                          12.0, 2.0, 8.0, 2.0),
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(45)),
                                      ),
                                    ),
                                    isExpanded: true,
                                    hint: const Text(
                                      "Select Time",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey),
                                    ),
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    items: controller.timesList
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
                                        .toList(),
                                    onChanged: controller.showLateDayList
                                        ? null
                                        : (time) {
                                            controller.htoTime2 = time!;
                                          },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Obx(
                            () => AbsorbPointer(
                              absorbing: controller.showLateDayList,
                              child: SizedBox(
                                height: 50,
                                child: ListView(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    Row(
                                      children: [
                                        Transform.scale(
                                          scale: 0.5,
                                          child: Obx(
                                            () => Card(
                                              margin: const EdgeInsets.all(1),
                                              elevation: 3,
                                              shape: const StadiumBorder(),
                                              child: Transform.scale(
                                                scale: 2.0,
                                                child: Checkbox(
                                                    activeColor: primary,
                                                    checkColor: Colors.amber,
                                                    splashRadius: 20,
                                                    shape:
                                                        const StadiumBorder(),
                                                    side: BorderSide.none,
                                                    value: controller
                                                        .testingDayTimeList[0]
                                                        .isLate
                                                        .value,
                                                    onChanged: (val) {
                                                      // controller.isSun = !controller.isSun;
                                                      controller.testingDayTimeList[0]
                                                              .isLate.value =
                                                          !controller
                                                              .testingDayTimeList[0]
                                                              .isLate
                                                              .value;
                                                      if (controller
                                                          .testingDayTimeList[0]
                                                          .isLate
                                                          .isTrue) {
                                                        controller
                                                            .testingDayTimeList[0]
                                                            .isLate
                                                            .value = true;
                                                        controller
                                                                .testingDayTimeList[0]
                                                                .fromTime2 =
                                                            controller
                                                                .hfromTime2!;
                                                        controller
                                                                .testingDayTimeList[0]
                                                                .toTime2 =
                                                            controller
                                                                .htoTime2!;
                                                        controller
                                                            .addToHdaySecond(0);
                                                      }
                                                    }),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Text(
                                          "S",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Transform.scale(
                                          scale: 0.5,
                                          child: Obx(
                                            () => Card(
                                              margin: const EdgeInsets.all(1),
                                              elevation: 3,
                                              shape: const StadiumBorder(),
                                              child: Transform.scale(
                                                scale: 2.0,
                                                child: Checkbox(
                                                    activeColor: primary,
                                                    checkColor: Colors.amber,
                                                    splashRadius: 20,
                                                    shape:
                                                        const StadiumBorder(),
                                                    side: BorderSide.none,
                                                    value: controller
                                                        .testingDayTimeList[1]
                                                        .isLate
                                                        .value,
                                                    onChanged: (val) {
                                                      controller.testingDayTimeList[1]
                                                              .isLate.value =
                                                          !controller
                                                              .testingDayTimeList[1]
                                                              .isLate
                                                              .value;
                                                      if (controller
                                                          .testingDayTimeList[1]
                                                          .isLate
                                                          .isTrue) {
                                                        controller
                                                            .testingDayTimeList[1]
                                                            .isLate
                                                            .value = true;
                                                        controller
                                                                .testingDayTimeList[1]
                                                                .fromTime2 =
                                                            controller
                                                                .hfromTime2!;
                                                        controller
                                                                .testingDayTimeList[1]
                                                                .toTime2 =
                                                            controller
                                                                .htoTime2!;
                                                        controller
                                                            .addToHdaySecond(1);
                                                      }
                                                    }),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Text(
                                          "M",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Transform.scale(
                                          scale: 0.5,
                                          child: Obx(
                                            () => Card(
                                              margin: const EdgeInsets.all(1),
                                              elevation: 3,
                                              shape: const StadiumBorder(),
                                              child: Transform.scale(
                                                scale: 2.0,
                                                child: Checkbox(
                                                    activeColor: primary,
                                                    checkColor: Colors.amber,
                                                    splashRadius: 20,
                                                    shape:
                                                        const StadiumBorder(),
                                                    side: BorderSide.none,
                                                    value: controller
                                                        .testingDayTimeList[2]
                                                        .isLate
                                                        .value,
                                                    onChanged: (val) {
                                                      // controller.isTue = !controller.isTue;
                                                      controller.testingDayTimeList[2]
                                                              .isLate.value =
                                                          !controller
                                                              .testingDayTimeList[2]
                                                              .isLate
                                                              .value;
                                                      if (controller
                                                          .testingDayTimeList[2]
                                                          .isLate
                                                          .isTrue) {
                                                        controller
                                                            .testingDayTimeList[2]
                                                            .isLate
                                                            .value = true;
                                                        controller
                                                                .testingDayTimeList[2]
                                                                .fromTime2 =
                                                            controller
                                                                .hfromTime2!;
                                                        controller
                                                                .testingDayTimeList[2]
                                                                .toTime2 =
                                                            controller
                                                                .htoTime2!;
                                                        controller
                                                            .addToHdaySecond(2);
                                                      }
                                                    }),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Text(
                                          "T",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Transform.scale(
                                          scale: 0.5,
                                          child: Obx(
                                            () => Card(
                                              margin: const EdgeInsets.all(1),
                                              elevation: 3,
                                              shape: const StadiumBorder(),
                                              child: Transform.scale(
                                                scale: 2.0,
                                                child: Checkbox(
                                                    activeColor: primary,
                                                    checkColor: Colors.amber,
                                                    splashRadius: 20,
                                                    shape:
                                                        const StadiumBorder(),
                                                    side: BorderSide.none,
                                                    value: controller
                                                        .testingDayTimeList[3]
                                                        .isLate
                                                        .value,
                                                    onChanged: (val) {
                                                      controller.testingDayTimeList[3]
                                                              .isLate.value =
                                                          !controller
                                                              .testingDayTimeList[3]
                                                              .isLate
                                                              .value;
                                                      if (controller
                                                          .testingDayTimeList[3]
                                                          .isLate
                                                          .isTrue) {
                                                        controller
                                                            .testingDayTimeList[3]
                                                            .isLate
                                                            .value = true;
                                                        controller
                                                                .testingDayTimeList[3]
                                                                .fromTime2 =
                                                            controller
                                                                .hfromTime2!;
                                                        controller
                                                                .testingDayTimeList[3]
                                                                .toTime2 =
                                                            controller
                                                                .htoTime2!;
                                                        controller
                                                            .addToHdaySecond(3);
                                                      }

                                                      //controller.isWed = !controller.isWed;
                                                    }),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Text(
                                          "W",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Transform.scale(
                                          scale: 0.5,
                                          child: Obx(
                                            () => Card(
                                              margin: const EdgeInsets.all(1),
                                              elevation: 3,
                                              shape: const StadiumBorder(),
                                              child: Transform.scale(
                                                scale: 2.0,
                                                child: Checkbox(
                                                    activeColor: primary,
                                                    checkColor: Colors.amber,
                                                    splashRadius: 20,
                                                    shape:
                                                        const StadiumBorder(),
                                                    side: BorderSide.none,
                                                    value: controller
                                                        .testingDayTimeList[4]
                                                        .isLate
                                                        .value,
                                                    onChanged: (val) {
                                                      // controller.isThu = !controller.isThu;

                                                      controller.testingDayTimeList[4]
                                                              .isLate.value =
                                                          !controller
                                                              .testingDayTimeList[4]
                                                              .isLate
                                                              .value;
                                                      if (controller
                                                          .testingDayTimeList[4]
                                                          .isLate
                                                          .isTrue) {
                                                        controller
                                                            .testingDayTimeList[4]
                                                            .isLate
                                                            .value = true;
                                                        controller
                                                                .testingDayTimeList[4]
                                                                .fromTime2 =
                                                            controller
                                                                .hfromTime2!;
                                                        controller
                                                                .testingDayTimeList[4]
                                                                .toTime2 =
                                                            controller
                                                                .htoTime2!;
                                                        controller
                                                            .addToHdaySecond(4);
                                                      }
                                                    }),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Text(
                                          "T",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Transform.scale(
                                          scale: 0.5,
                                          child: Obx(
                                            () => Card(
                                              margin: const EdgeInsets.all(1),
                                              elevation: 3,
                                              shape: const StadiumBorder(),
                                              child: Transform.scale(
                                                scale: 2.0,
                                                child: Checkbox(
                                                    activeColor: primary,
                                                    checkColor: Colors.amber,
                                                    splashRadius: 20,
                                                    shape:
                                                        const StadiumBorder(),
                                                    side: BorderSide.none,
                                                    value: controller
                                                        .testingDayTimeList[5]
                                                        .isLate
                                                        .value,
                                                    onChanged: (val) {
                                                      controller.testingDayTimeList[5]
                                                              .isLate.value =
                                                          !controller
                                                              .testingDayTimeList[5]
                                                              .isLate
                                                              .value;
                                                      if (controller
                                                          .testingDayTimeList[5]
                                                          .isLate
                                                          .isTrue) {
                                                        controller
                                                            .testingDayTimeList[5]
                                                            .isLate
                                                            .value = true;
                                                        controller
                                                                .testingDayTimeList[5]
                                                                .fromTime2 =
                                                            controller
                                                                .hfromTime2!;
                                                        controller
                                                                .testingDayTimeList[5]
                                                                .toTime2 =
                                                            controller
                                                                .htoTime2!;
                                                        controller
                                                            .addToHdaySecond(5);
                                                      }
                                                    }),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Text(
                                          "F",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Transform.scale(
                                          scale: 0.5,
                                          child: Obx(
                                            () => Card(
                                              margin: const EdgeInsets.all(1),
                                              elevation: 3,
                                              shape: const StadiumBorder(),
                                              child: Transform.scale(
                                                scale: 2.0,
                                                child: Checkbox(
                                                    activeColor: primary,
                                                    checkColor: Colors.amber,
                                                    splashRadius: 20,
                                                    shape:
                                                        const StadiumBorder(),
                                                    side: BorderSide.none,
                                                    value: controller
                                                        .testingDayTimeList[6]
                                                        .isLate
                                                        .value,
                                                    onChanged: (val) {
                                                      // controller.isSat = !controller.isSat;
                                                      controller.testingDayTimeList[6]
                                                              .isLate.value =
                                                          !controller
                                                              .testingDayTimeList[6]
                                                              .isLate
                                                              .value;
                                                      if (controller
                                                          .testingDayTimeList[6]
                                                          .isLate
                                                          .isTrue) {
                                                        controller
                                                            .testingDayTimeList[6]
                                                            .isLate
                                                            .value = true;
                                                        controller
                                                                .testingDayTimeList[6]
                                                                .fromTime2 =
                                                            controller
                                                                .hfromTime2!;
                                                        controller
                                                                .testingDayTimeList[6]
                                                                .toTime2 =
                                                            controller
                                                                .htoTime2!;
                                                        controller
                                                            .addToHdaySecond(6);
                                                      }
                                                    }),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Text(
                                          "S",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          CustomElevatedButtonWidget(
                            onPressed: () {
                              var index = controller.testingDayTimeList
                                  .where((e) => e.isLate.isTrue)
                                  .length;

                              if (controller.hfromTime2 != null &&
                                  controller.htoTime2 != null &&
                                  index != 0) {
                                controller.showLateDayList = true;
                                controller.lateHappyHourForValidationOnly =
                                    true;
                                controller.animateToIndex(5);
                                controller.update();
                              } else {
                                Get.find<GlobalGeneralController>()
                                    .errorSnackbar(
                                        title: "Time",
                                        description: "Select Time and days ");

                                controller.update();
                              }
                            },
                            horizontalPadding: 40,
                            verticalPadding: 0,
                            text: "submit",
                            textColor: blackColor,
                            fontSize: 16,
                            borderRadius: 45,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Obx(() => Visibility(
                        visible: controller.showLateDayList,
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.testingDayTimeList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    left: W * 0.01, right: W * 0.06),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Transform.scale(
                                          scale: 0.6,
                                          child: Obx(
                                            () => Card(
                                              margin: const EdgeInsets.all(1),
                                              elevation: 3,
                                              shape: const StadiumBorder(),
                                              child: Transform.scale(
                                                scale: 2.0,
                                                child: Checkbox(
                                                    checkColor: Colors.amber,
                                                    splashRadius: 20,
                                                    shape:
                                                        const StadiumBorder(),
                                                    side: BorderSide.none,
                                                    value: controller
                                                        .testingDayTimeList[index]
                                                        .isLate
                                                        .value,
                                                    onChanged: (val) {
                                                      controller
                                                              .testingDayTimeList[index]
                                                              .isLate
                                                              .value =
                                                          !controller
                                                              .testingDayTimeList[
                                                                  index]
                                                              .isLate
                                                              .value;
                                                      controller
                                                          .hUpdateDaySecond(
                                                              index);
                                                      if (controller
                                                          .testingDayTimeList[index]
                                                          .isLate
                                                          .isTrue) {
                                                        controller
                                                            .testingDayTimeList[index]
                                                            .isLate
                                                            .value = true;
                                                        controller
                                                            .testingDayTimeList[index]
                                                            .fromTime = controller
                                                                .hfromTime2 ??
                                                            "";
                                                        controller
                                                            .testingDayTimeList[index]
                                                            .toTime = controller
                                                                .htoTime2 ??
                                                            "";
                                                        controller
                                                            .addToHdaySecond(
                                                                index);
                                                      }
                                                    }),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: W * 0.24,
                                          child: Text(
                                            controller.testingDayTimeList[index].day,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        Obx(
                                          () => Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(45),
                                            ),
                                            elevation: 5,
                                            child: SizedBox(
                                              height: H * 0.04,
                                              width: W * 0.26,
                                              child: DropdownButtonFormField<
                                                  String>(
                                                validator: controller
                                                        .testingDayTimeList[index]
                                                        .isLate
                                                        .isTrue
                                                    ? (value) {
                                                        if (value == null ||
                                                            value
                                                                .trim()
                                                                .isEmpty) {
                                                          return 'select';
                                                        }

                                                        return null;
                                                      }
                                                    : null,
                                                value: controller.hfromTime2,
                                                elevation: 15,
                                                decoration:
                                                    const InputDecoration(
                                                  enabled: false,
                                                  contentPadding:
                                                      EdgeInsets.fromLTRB(
                                                          12.0, 2.0, 8.0, 2.0),
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                45)),
                                                  ),
                                                ),
                                                isExpanded: true,
                                                hint: const Text(
                                                  "Select Time",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey),
                                                ),
                                                icon: const Icon(
                                                    Icons.keyboard_arrow_down),
                                                items: controller
                                                        .testingDayTimeList[index]
                                                        .isLate
                                                        .isTrue
                                                    ? controller.timesList
                                                        .map((time) =>
                                                            DropdownMenuItem(
                                                              value: time,
                                                              child: Text(
                                                                time,
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ))
                                                        .toList()
                                                    : [],
                                                onChanged: (time) {
                                                  controller.testingDayTimeList[index]
                                                      .fromTime2 = time!;
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Obx(
                                          () => Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(45),
                                            ),
                                            elevation: 5,
                                            child: SizedBox(
                                              height: H * 0.04,
                                              width: W * 0.26,
                                              child: DropdownButtonFormField<
                                                  String>(
                                                value: controller.htoTime2,
                                                validator: controller
                                                        .testingDayTimeList[index]
                                                        .isLate
                                                        .isTrue
                                                    ? (value) {
                                                        if (value == null ||
                                                            value
                                                                .trim()
                                                                .isEmpty) {
                                                          return 'select';
                                                        }

                                                        return null;
                                                      }
                                                    : null,
                                                elevation: 15,
                                                decoration:
                                                    const InputDecoration(
                                                  enabled: false,
                                                  contentPadding:
                                                      EdgeInsets.fromLTRB(
                                                          12.0, 2.0, 8.0, 2.0),
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                45)),
                                                  ),
                                                ),
                                                isExpanded: true,
                                                hint: const Text(
                                                  "Select Time",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey),
                                                ),
                                                icon: const Icon(
                                                    Icons.keyboard_arrow_down),
                                                items: controller
                                                        .testingDayTimeList[index]
                                                        .isLate
                                                        .isTrue
                                                    ? controller.timesList
                                                        .map((time) =>
                                                            DropdownMenuItem(
                                                              value: time,
                                                              child: Text(
                                                                time,
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ))
                                                        .toList()
                                                    : [],
                                                onChanged: (time) {
                                                  controller.testingDayTimeList[index]
                                                      .toTime2 = time!;
                                                  controller
                                                      .hDayTimeSecond(index);
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }),
                      )),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 32),
          child: SizedBox(
            height: H * 0.09,
            child: CustomElevatedButtonWidget(
              onPressed: () async {
                //print('controller.dayTimesList: ${controller.dayTimeList[1].fromTime}');
                controller.hourDetailTap();
              },
              verticalPadding: 0,
              text: "Next",
              textColor: blackColor,
              fontSize: 24,
              borderRadius: 45,
            ),
          ),
        ),
      );
    });
  }

  Row titleFromTo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        Text(
          "From",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          "To",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
