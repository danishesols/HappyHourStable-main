import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/colors.dart';
import '../../../../core/constants.dart';
import '../../../../global_controller/global_general_controller.dart';
import '../../../../global_widgets/circular_indicator.dart';
import '../../../../global_widgets/main_button.dart';
import '../addhappyhour_business_controller.dart';

class BusinessEventsScreen extends GetView<AddHappyhourBusinessController> {
  const BusinessEventsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddHappyhourBusinessController>(builder: (con) {
      return Obx(
        () => CustomCircleIndicator(
          opacity: 0.5,
          isEnabled: controller.isLoading,
          child: Scaffold(
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
              padding: const EdgeInsets.only(right: 8.0),
              child: RawScrollbar(
                thumbColor: primary,
                // trackColor: whiteColor,
                // thumbVisibility: true,
                // trackVisibility: true,
                radius: const Radius.circular(20),
                thickness: 10,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: controller.eventKey,
                    child: ListView(
                      children: [
                        SizedBox(
                          height: H * 0.009,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Weekly Events",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: H * 0.04,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Text(
                              "Event Name",
                              style: TextStyle(
                                fontSize: 16,
                                color: blackColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Day ",
                              style: TextStyle(
                                fontSize: 16,
                                color: blackColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "From",
                              style: TextStyle(
                                fontSize: 16,
                                color: blackColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "To",
                              style: TextStyle(
                                fontSize: 16,
                                color: blackColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: H * 0.01,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.eventList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Transform.scale(
                                    scale: 0.5,
                                    child: Obx(
                                      () => Card(
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
                                            value: controller.eventList[index]
                                                .isSelect.value,
                                            onChanged: (v) {
                                              controller.eventList[index]
                                                      .isSelect.value =
                                                  !controller.eventList[index]
                                                      .isSelect.value;
                                              controller.addIntoList(
                                                  controller
                                                      .eventList[index].event,
                                                  index);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: W * 0.2,
                                    child: Row(
                                      children: [
                                        //SizedBox(width: W * 0.018),
                                        Flexible(
                                          child: Text(
                                            controller.eventList[index].event,
                                            maxLines: 2,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: W * 0.2,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(45),
                                      ),
                                      elevation: 5,
                                      child: SizedBox(
                                        height: H * 0.04,
                                        child: Obx(
                                          () => DropdownButtonFormField<String>(
                                            validator: controller
                                                        .eventList[index]
                                                        .isSelect
                                                        .value ==
                                                    true
                                                ? (value) {
                                                    if (value == null ||
                                                        value.trim().isEmpty) {
                                                      return 'select day';
                                                    }
                                                    if (value.trim().length <
                                                        4) {
                                                      return 'select';
                                                    }
                                                    return null;
                                                  }
                                                : null,
                                            elevation: 15,
                                            decoration: const InputDecoration(
                                              enabled: false,
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      6.0, 2.0, 4.0, 2.0),
                                              filled: true,
                                              fillColor: Colors.white,
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(45)),
                                              ),
                                            ),
                                            isExpanded: true,
                                            hint: const Text(
                                              "Select day",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey),
                                            ),
                                            icon: const Icon(
                                                Icons.keyboard_arrow_down),
                                            items: controller.eventList[index]
                                                        .isSelect.value ==
                                                    true
                                                ? controller.dayList
                                                    .map((day) =>
                                                        DropdownMenuItem(
                                                          value: day,
                                                          child: Text(
                                                            day,
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
                                            onChanged: (day) {
                                              controller.assignDayValue(
                                                  day!,
                                                  controller
                                                      .eventList[index].event);

                                              // controller.eventListadded();
                                              //  controller.day = day!;
                                            },
                                            value: controller.eventList[index]
                                                        .isSelect.isTrue &&
                                                    controller.eventList[index]
                                                            .day
                                                            .toString() !=
                                                        ''
                                                ? controller
                                                    .eventList[index].day
                                                    .toString()
                                                : controller.dayList.first,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: W * 0.2,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(45),
                                      ),
                                      elevation: 5,
                                      child: SizedBox(
                                        height: H * 0.04,
                                        child: Obx(
                                          () => DropdownButtonFormField<String>(
                                            validator: controller
                                                        .eventList[index]
                                                        .isSelect
                                                        .value ==
                                                    true
                                                ? (value) {
                                                    if (value == null ||
                                                        value.trim().isEmpty) {
                                                      return 'select';
                                                    }
                                                    if (value.trim().length <
                                                        4) {
                                                      return 'select';
                                                    }
                                                    return null;
                                                  }
                                                : null,
                                            elevation: 15,
                                            decoration: const InputDecoration(
                                              enabled: false,
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      6.0, 2.0, 4.0, 2.0),
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
                                                  fontSize: 10,
                                                  color: Colors.grey),
                                            ),
                                            icon: const Icon(
                                                Icons.keyboard_arrow_down),
                                            items: controller.eventList[index]
                                                        .isSelect.value ==
                                                    true
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
                                            value: controller.eventList[index]
                                                        .isSelect.isTrue &&
                                                    controller.eventList[index]
                                                            .fromtime
                                                            .toString() !=
                                                        ""
                                                ? controller
                                                    .eventList[index].fromtime
                                                    .toString()
                                                : controller.timesList.last,
                                            onChanged: (time) {
                                              controller.assignFromTimeValue(
                                                  time!,
                                                  controller
                                                      .eventList[index].event);

                                              controller.eventList[index].day =
                                                  time;
                                              //  controller.eventListadded();
                                              //controller.selectedEvent.add(time);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: W * 0.2,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(45),
                                      ),
                                      elevation: 5,
                                      child: SizedBox(
                                        height: H * 0.04,
                                        child: Obx(
                                          () => DropdownButtonFormField<String>(
                                            validator: controller
                                                        .eventList[index]
                                                        .isSelect
                                                        .value ==
                                                    true
                                                ? (value) {
                                                    if (value == null ||
                                                        value.trim().isEmpty) {
                                                      return 'select';
                                                    }
                                                    if (value.trim().length <
                                                        4) {
                                                      return 'select';
                                                    }
                                                    return null;
                                                  }
                                                : null,
                                            elevation: 15,
                                            decoration: const InputDecoration(
                                              enabled: false,
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      6.0, 2.0, 4.0, 2.0),
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
                                                  fontSize: 10,
                                                  color: Colors.grey),
                                            ),
                                            value: controller.eventList[index]
                                                        .isSelect.isTrue &&
                                                    controller.eventList[index]
                                                            .totime
                                                            .toString() !=
                                                        ""
                                                ? controller
                                                    .eventList[index].totime
                                                    .toString()
                                                : controller.timesList.last,
                                            icon: const Icon(
                                                Icons.keyboard_arrow_down),
                                            items: controller.eventList[index]
                                                        .isSelect.value ==
                                                    true
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
                                            onChanged: (time) {
                                              controller.assignToTimeValue(
                                                  time!,
                                                  controller
                                                      .eventList[index].event);
                                              //  controller.eventListadded();
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
                          height: H * 0.02,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(
                    () => Row(
                      children: [
                        Material(
                          color: bgColor,
                          shadowColor: bgColor,
                          child: Checkbox(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            value: controller.isTermChecked,
                            onChanged: controller.onCheckboxChange,
                          ),
                        ),
                        const Text(
                            " Agree to Terms and Conditions before Submitting."),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: H * 0.09,
                    width: W,
                    child: CustomElevatedButtonWidget(
                      onPressed: () {
                        if (controller.eventKey.currentState!.validate() ==
                            false) {
                          Get.find<GlobalGeneralController>().errorSnackbar(
                              title: "Error",
                              description: "Select Day and Times");
                        }
                        if (controller.eventKey.currentState?.validate() ??
                            false) {
                          bool found = false;
                          if (controller.isTermChecked == true) {
                            for (int i = 0;
                                i < controller.selectedEvent.length;
                                i++) {
                              if (controller.checkEmptyEventValues(i)) {
                                found = true;
                              }
                            }
                            if (!found) {
                              controller.uploadBusinessHourToFireStore();
                            } else {
                              Get.find<GlobalGeneralController>().errorSnackbar(
                                  title: "Error",
                                  description: "Select Day and Times");
                            }
                          } else {
                            Get.find<GlobalGeneralController>().errorSnackbar(
                                title: "Error",
                                description: "Check Term and Condition");
                          }
                        }
                      },
                      text: "Submit",
                      textColor: blackColor,
                      fontSize: 24,
                      verticalPadding: 0,
                      borderRadius: 45,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
