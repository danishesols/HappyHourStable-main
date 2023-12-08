import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/colors.dart';
import '../../../../core/constants.dart';
import '../../../../global_widgets/main_button.dart';
import '../claim_controller.dart';

class ClaimDayTimeScreen extends GetView<ClaimController> {
  const ClaimDayTimeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClaimController>(builder: (controller) {
      return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                for (var e in controller.dayTimeList) {
                  e.isSelect = false.obs;
                }
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
        body: SingleChildScrollView(
          child: Form(
            key: controller.businessKey,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: H * 0.009,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Add Happy Hour Details",
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
                    padding: EdgeInsets.only(left: W * 0.08, right: W * 0.14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        SizedBox(
                          width: 1,
                        ),
                        Text(
                          "Day",
                          style: TextStyle(
                            fontSize: 18,
                            color: blackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "From Time",
                          style: TextStyle(
                            fontSize: 18,
                            color: blackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "To Time",
                          style: TextStyle(
                            fontSize: 18,
                            color: blackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: H * 0.02,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.dayTimeList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding:
                              EdgeInsets.only(left: W * 0.01, right: W * 0.06),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                              checkColor: Colors.amber,
                                              splashRadius: 20,
                                              shape: const StadiumBorder(),
                                              side: BorderSide.none,
                                              value: controller
                                                  .dayTimeList[index]
                                                  .isSelect
                                                  .value,
                                              onChanged: (val) {
                                                controller.hUpdateDay(index);
                                              }),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: W * 0.24,
                                    child: Text(
                                      controller.dayTimeList[index].day,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Obx(
                                    () => Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(45),
                                      ),
                                      elevation: 5,
                                      child: SizedBox(
                                        height: H * 0.04,
                                        width: W * 0.24,
                                        child: DropdownButtonFormField<String>(
                                          value: controller.dayTimeList[index]
                                                  .isSelect.isTrue
                                              ? controller
                                                  .hour.day![0]['HfromTime']
                                                  .toString()
                                              : "Select Time",
                                          validator: controller
                                                  .dayTimeList[index]
                                                  .isSelect
                                                  .isTrue
                                              ? (value) {
                                                  if (value == null ||
                                                      value.trim().isEmpty) {
                                                    return 'select';
                                                  }
                                                  if (value.trim().length < 4) {
                                                    return 'select';
                                                  }
                                                  // Return null if the entered Business name is valid
                                                  return null;
                                                }
                                              : null,
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
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ),
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),
                                          items: controller.dayTimeList[index]
                                                  .isSelect.isTrue
                                              ? controller.timesList
                                                  .map((time) =>
                                                      DropdownMenuItem(
                                                        value: time,
                                                        child: Text(
                                                          time,
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ))
                                                  .toList()
                                              : [],
                                          onChanged: (time) {
                                            controller.hFromTime = time;
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Obx(
                                    () => Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(45),
                                      ),
                                      elevation: 5,
                                      child: SizedBox(
                                        height: H * 0.04,
                                        width: W * 0.24,
                                        child: DropdownButtonFormField<String>(
                                          value: controller.dayTimeList[index]
                                                  .isSelect.isTrue
                                              ? controller
                                                  .hour.day![0]['HtoTime']
                                                  .toString()
                                              : "Select Time",
                                          validator: controller
                                                  .dayTimeList[index]
                                                  .isSelect
                                                  .isTrue
                                              ? (value) {
                                                  if (value == null ||
                                                      value.trim().isEmpty) {
                                                    return 'select';
                                                  }

                                                  // Return null if the entered Business name is valid
                                                  return null;
                                                }
                                              : null,
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
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ),
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down),
                                          items: controller.dayTimeList[index]
                                                  .isSelect.isTrue
                                              ? controller.timesList
                                                  .map((time) =>
                                                      DropdownMenuItem(
                                                        value: time,
                                                        child: Text(
                                                          time,
                                                          style:
                                                              const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ))
                                                  .toList()
                                              : [],
                                          onChanged: (time) {
                                            controller.hToTime = time;
                                            controller.hDayTime();
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Obx(
                                    () => Visibility(
                                      visible: controller
                                          .dayTimeList[index].isSelect.value,
                                      child: Flexible(
                                        child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                height: H * 0.04,
                                              ),
                                              // Container(
                                              //   width: W * 0.2,
                                              // ),
                                              controller
                                                          .dayTimeList[index]
                                                          .secondTime
                                                          ?.isEmpty ??
                                                      true
                                                  ? Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            controller
                                                                .dayTimeList[
                                                                    index]
                                                                .secondTime
                                                                ?.add(
                                                                    "selected");
                                                            controller.update();
                                                          },
                                                          child: const Text(
                                                            "+ Add Additional Time",
                                                            style: TextStyle(
                                                              color: primary,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Row(
                                                      children: [
                                                        IconButton(
                                                          onPressed: () {
                                                            controller
                                                                .dayTimeList[
                                                                    index]
                                                                .secondTime
                                                                ?.remove(
                                                                    "selected");
                                                            controller.update();
                                                          },
                                                          icon: const Icon(
                                                            Icons.delete,
                                                            color: Colors.red,
                                                            size: 20,
                                                          ),
                                                        ),
                                                        Obx(
                                                          () => Card(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          45),
                                                            ),
                                                            elevation: 5,
                                                            child: SizedBox(
                                                              height: H * 0.04,
                                                              width: W * 0.27,
                                                              child:
                                                                  DropdownButtonFormField<
                                                                      String>(
                                                                validator:
                                                                    (val) {
                                                                  if (val !=
                                                                          null &&
                                                                      controller
                                                                          .dayTimeList[
                                                                              index]
                                                                          .isSelect
                                                                          .isTrue) {
                                                                    return null;
                                                                  }
                                                                  return "";
                                                                },
                                                                elevation: 15,
                                                                decoration:
                                                                    const InputDecoration(
                                                                  enabled:
                                                                      false,
                                                                  contentPadding:
                                                                      EdgeInsets.fromLTRB(
                                                                          12.0,
                                                                          2.0,
                                                                          8.0,
                                                                          2.0),
                                                                  filled: true,
                                                                  fillColor:
                                                                      Colors
                                                                          .white,
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(45)),
                                                                  ),
                                                                ),
                                                                isExpanded:
                                                                    true,
                                                                hint:
                                                                    const Text(
                                                                  "Select Time",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .grey),
                                                                ),
                                                                icon: const Icon(
                                                                    Icons
                                                                        .keyboard_arrow_down),
                                                                items: controller
                                                                        .dayTimeList[
                                                                            index]
                                                                        .isSelect
                                                                        .isTrue
                                                                    ? controller
                                                                        .timesList
                                                                        .map((time) =>
                                                                            DropdownMenuItem(
                                                                              value: time,
                                                                              child: Text(
                                                                                time,
                                                                                style: const TextStyle(
                                                                                  color: Colors.black,
                                                                                  fontSize: 14,
                                                                                ),
                                                                              ),
                                                                            ))
                                                                        .toList()
                                                                    : [],
                                                                onChanged:
                                                                    (time) {
                                                                  controller
                                                                          .hFromTime2 =
                                                                      time;
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: W * 0.018,
                                                        ),
                                                        Obx(
                                                          () => Card(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          45),
                                                            ),
                                                            elevation: 5,
                                                            child: SizedBox(
                                                              height: H * 0.04,
                                                              width: W * 0.28,
                                                              child:
                                                                  DropdownButtonFormField<
                                                                      String>(
                                                                validator: controller
                                                                        .dayTimeList[
                                                                            index]
                                                                        .isSelect
                                                                        .isTrue
                                                                    ? (value) {
                                                                        if (value ==
                                                                                null ||
                                                                            value.trim().isEmpty) {
                                                                          return 'select';
                                                                        }

                                                                        return null;
                                                                      }
                                                                    : null,
                                                                elevation: 15,
                                                                decoration:
                                                                    const InputDecoration(
                                                                  enabled:
                                                                      false,
                                                                  contentPadding:
                                                                      EdgeInsets.fromLTRB(
                                                                          12.0,
                                                                          2.0,
                                                                          8.0,
                                                                          2.0),
                                                                  filled: true,
                                                                  fillColor:
                                                                      Colors
                                                                          .white,
                                                                  border:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(45)),
                                                                  ),
                                                                ),
                                                                isExpanded:
                                                                    true,
                                                                hint:
                                                                    const Text(
                                                                  "Select Time",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .grey),
                                                                ),
                                                                icon: const Icon(
                                                                    Icons
                                                                        .keyboard_arrow_down),
                                                                items: controller
                                                                        .dayTimeList[
                                                                            index]
                                                                        .isSelect
                                                                        .isTrue
                                                                    ? controller
                                                                        .timesList
                                                                        .map((time) =>
                                                                            DropdownMenuItem(
                                                                              value: time,
                                                                              child: Text(
                                                                                time,
                                                                                style: const TextStyle(
                                                                                  color: Colors.black,
                                                                                  fontSize: 14,
                                                                                ),
                                                                              ),
                                                                            ))
                                                                        .toList()
                                                                    : [],
                                                                onChanged:
                                                                    (time) {
                                                                  controller
                                                                          .hToTime2 =
                                                                      time;
                                                                  controller
                                                                      .hDayTime();
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                            ]),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      }),
                  SizedBox(
                    height: H * 0.3,
                  ),
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
              onPressed: () {
                controller.update();
                Get.back();
                //controller.onDayTimeNextTap();
              },
              verticalPadding: 0,
              text: "Done",
              textColor: blackColor,
              fontSize: 24,
              borderRadius: 45,
            ),
          ),
        ),
      );
    });
  }
}
