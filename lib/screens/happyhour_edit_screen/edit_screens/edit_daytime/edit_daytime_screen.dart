import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/colors.dart';
import '../../../../core/constants.dart';
import '../../../../global_widgets/main_button.dart';
import '../edit_controller.dart';

class EditDayTimeScreen extends GetView<EditController> {
  const EditDayTimeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditController>(builder: (controller) {
      return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              ///todo: look into this issue
              //controller.onDayTimeDoneTap();
              Get.back();
            },
            icon: SvgPicture.asset(
              "assets/icons/Group 9108.svg",
              height: 25,
              width: 25,
            ),
          ),
          title: const Text("Edit Happy Hour"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: RawScrollbar(
            thumbColor: primary,
            // trackColor: whiteColor,
          // thumbVisibility: true,
          // trackVisibility: true,
            radius: const Radius.circular(20),
            thickness: 10,
            child: Form(
              key: controller.businessKey,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ListView(
                  children: [
                    SizedBox(
                      height: H * 0.009,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Early Happy Hour Details",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: H * 0.04,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.dayTimeList.length,
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
                                          checkColor:
                                              Theme.of(context).primaryColor,
                                          splashRadius: 20,
                                          shape: const StadiumBorder(),
                                          side: BorderSide.none,
                                          value: controller.dayTimeList[index]
                                              .isSelect.value,
                                          onChanged: (v) {
                                            controller.hUpdateDay(index);
                                            controller
                                                .forKeyAssignDayTime(index);
                                          }),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: W * 0.26,
                                child: Text(
                                  controller.dayTimeList[index].day,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
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
                                        validator: controller.dayTimeList[index]
                                                .isSelect.isTrue
                                            ? (value) {
                                                if (value.toString() ==
                                                        "Select Time" ||
                                                    value.toString() == "" ||
                                                    value == null) {
                                                  return 'select';
                                                } else {
                                                  return null;
                                                }
                                              }
                                            : null,
                                        value: controller.dayTimeList[index]
                                                    .isSelect.isTrue &&
                                                controller.dayTimeList[index]
                                                        .fromTime
                                                        .toString() !=
                                                    ""
                                            ? controller
                                                .dayTimeList[index].fromTime
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
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        items: controller.dayTimeList[index]
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
                                          controller.dayTimeList[index]
                                              .fromTime = fromTime!;
                                          controller.hDayTime(
                                              index,
                                              controller
                                                  .dayTimeList[index].day);
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
                                        validator: (value) {
                                          if (controller.dayTimeList[index]
                                              .isSelect.isTrue) {
                                            if (value.toString() ==
                                                "Select Time") {
                                              return 'select';
                                            }
                                          }
                                          return null;
                                        },
                                        value: controller.dayTimeList[index]
                                                    .isSelect.isTrue &&
                                                controller.dayTimeList[index]
                                                        .toTime
                                                        .toString() !=
                                                    ""
                                            ? controller
                                                .dayTimeList[index].toTime
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
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        items: controller.dayTimeList[index]
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
                                          controller.dayTimeList[index].toTime =
                                              toTime!;
                                          controller.hDayTime(
                                              index,
                                              controller
                                                  .dayTimeList[index].day);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                    SizedBox(
                      height: H * 0.04,
                    ),
                    controller.firestoreObj.dayLate!.isNotEmpty ||
                            controller.showLate
                        ? const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              "Late Happy Hour Details",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              controller.showLate = !controller.showLate;
                              controller.update();
                            },
                            child: const Text(
                              "Add Late Happy Hour",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: primary),
                            )),
                    SizedBox(
                      height: H * 0.02,
                    ),
                    controller.firestoreObj.dayLate!.isNotEmpty ||
                            controller.showLate
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.dayTimeList2.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                              checkColor: Theme.of(context)
                                                  .primaryColor,
                                              splashRadius: 20,
                                              shape: const StadiumBorder(),
                                              side: BorderSide.none,
                                              value: controller
                                                  .dayTimeList2[index]
                                                  .isSelect
                                                  .value,
                                              onChanged: (v) {
                                                controller
                                                    .hUpdateDayLate(index);
                                              }),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: W * 0.26,
                                    child: Text(
                                      controller.dayTimeList2[index].day,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
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
                                            validator: controller
                                                    .dayTimeList2[index]
                                                    .isSelect
                                                    .isTrue
                                                ? (value) {
                                                    if (value.toString() ==
                                                            "Select Time" ||
                                                        value.toString() ==
                                                            "") {
                                                      return 'select';
                                                    }
                                                    return null;
                                                  }
                                                : null,
                                            value: controller
                                                        .dayTimeList2[index]
                                                        .isSelect
                                                        .isTrue &&
                                                    controller
                                                            .dayTimeList2[index]
                                                            .fromTime2
                                                            .toString() !=
                                                        ""
                                                ? controller.dayTimeList2[index]
                                                    .fromTime2
                                                    .toString()
                                                : "Select Time",
                                            elevation: 15,
                                            decoration: const InputDecoration(
                                              enabled: false,
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      16.0, 2.0, 8.0, 2.0),
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
                                            items: controller
                                                    .dayTimeList2[index]
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
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                        ))
                                                    .toList()
                                                : [],
                                            onChanged: (fromTime) {
                                              controller.dayTimeList2[index]
                                                  .fromTime2 = fromTime!;
                                              controller.hDayTimeLate(
                                                  index,
                                                  controller
                                                      .dayTimeList2[index].day);
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
                                        child: DropdownButtonFormField<String>(
                                          validator: (value) {
                                            if (controller.dayTimeList2[index]
                                                .isSelect.isTrue) {
                                              if (value.toString() ==
                                                  "Select Time") {
                                                return 'select';
                                              }
                                            }
                                            return null;
                                          },
                                          value: controller.dayTimeList2[index]
                                                      .isSelect.isTrue &&
                                                  controller.dayTimeList2[index]
                                                          .toTime2
                                                          .toString() !=
                                                      ""
                                              ? controller
                                                  .dayTimeList2[index].toTime2
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
                                          items: controller.dayTimeList2[index]
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
                                          onChanged: (toTime) {
                                            controller.dayTimeList2[index]
                                                .toTime2 = toTime!;
                                            controller.hDayTimeLate(
                                                index,
                                                controller
                                                    .dayTimeList2[index].day);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            })
                        : const SizedBox(),
                  ],
                ),
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
                controller.onDayTimeDoneTap();
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
