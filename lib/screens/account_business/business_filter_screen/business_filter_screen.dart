// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:happy_hour_app/core/colors.dart';
import 'package:happy_hour_app/core/constants.dart';
import 'package:happy_hour_app/screens/happyhour_filter_screen/happyhour_filter_screen_controller.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../global_widgets/main_button.dart';
import '../../../global_widgets/text_field.dart';
import '../../../routes/app_routes.dart';
import 'business_filter_screen_controller.dart';

class BusinessFilterScreen extends GetView<BusinessFilterScreenController> {
  const BusinessFilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BusinessFilterScreenController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: bgColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: SvgPicture.asset(
                    "assets/icons/Group 9108.svg",
                    height: 25,
                    width: 25,
                  ),
                )),
            title: const Text("Filters"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: H * 0.009,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Active Specials Shown By Default",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: H * 0.02,
                  ),
                  topText("Futures Happy Hours"),
                  SizedBox(
                    height: H * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: DropdownButton(
                          // width: W * 0.45,
                          hint: "Day",
                          onChange: (day) {
                            controller.days = day!;
                            controller.filter.day = day;
                          },
                          ctrlList: controller.daysList
                              .map((days) => DropdownMenuItem(
                                    value: days,
                                    child: Text(
                                      days,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                      Expanded(
                        child: DropdownButton(
                          hint: 'Time',
                          ctrlList: controller.timesList
                              .map((time) => DropdownMenuItem(
                                    value: time,
                                    child: Text(
                                      time,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          onChange: (time) {
                            controller.time = time!;
                            controller.filter.time = time;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: H * 0.02,
                  ),
                  topText("Radius"),
                  SizedBox(
                    height: H * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(),
                      DropdownButton(
                        height: H * 0.04,
                        width: W * 0.21,
                        padding: const EdgeInsets.all(8),
                        onChange: (String? distance) {
                          controller.distance = distance!;
                          controller.update();
                        },
                        ctrlList: controller.distanceList
                            .map((distance) => DropdownMenuItem<String>(
                                  value: distance,
                                  child: Text(
                                    distance,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ))
                            .toList(),
                        hint: "Mi",
                      ),
                      topText(controller.distance == ""
                          ? "${controller.range.truncate()} ${controller.distance}"
                          : "${controller.range.truncate()} ${controller.distance}")
                    ],
                  ),
                  Obx(
                    () => Slider(
                      activeColor: primary,
                      inactiveColor: whiteColor,
                      value: controller.range,
                      max: 30,
                      min: 0,
                      onChanged: (double value) {
                        controller.setRange(value);

                        // controller.filter.range = value;
                      },
                    ),
                  ),
                  SizedBox(
                    height: H * 0.02,
                  ),
                  topText("City"),
                  SizedBox(
                    height: H * 0.02,
                  ),
                  CustomTextFieldWidget(
                    hintText: "Search",
                    textEditingController: controller.searchController,
                    onChanged: controller.onSearch,
                  ),
                  SizedBox(
                    height: H * 0.02,
                  ),

                  topText("Drink Specials"),
                  SizedBox(
                    height: H * 0.01,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                    child: MultiSelectDialogField(
                      buttonIcon: const Icon(
                        Icons.keyboard_arrow_down,
                        size: 30,
                      ),
                      searchable: true,
                      listType: MultiSelectListType.LIST,
                      cancelText: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 16,
                        ),
                      ),
                      confirmText: const Text(
                        "Add",
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 16,
                        ),
                      ),
                      items: controller.multidrinkList
                          .map(
                            (e) => MultiSelectItem(e, e.name),
                          )
                          .toList(),
                      title: const Text("Drinks"),
                      selectedColor: primary,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                          boxShadow: []),
                      buttonText: const Text(
                        "Please Select",
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 16,
                        ),
                      ),
                      onConfirm: controller.addDrinkFromDropDownList,
                    ),
                  ),
                  // SizedBox(
                  //   height: H * 0.02,
                  // ),
                  // DropdownButton(
                  //   width: W,
                  //   hint: "Please select",
                  //   ctrlList: controller.drinkList
                  //       .map((drink) => DropdownMenuItem(
                  //             value: drink,
                  //             child: Text(
                  //               drink,
                  //               style: const TextStyle(
                  //                 fontSize: 16,
                  //               ),
                  //             ),
                  //           ))
                  //       .toList(),
                  //   onChange: (drink) {
                  //     controller.drink = drink!;
                  //     controller.searchListItem.add(controller.drink);
                  //     controller.filter.drink = drink;

                  //     //controller.update();
                  //   },
                  // ),
                  SizedBox(
                    height: H * 0.02,
                  ),
                  topText("Food Specials"),
                  SizedBox(
                    height: H * 0.02,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                    child: MultiSelectDialogField(
                      buttonIcon: const Icon(
                        Icons.keyboard_arrow_down,
                        size: 30,
                      ),
                      searchable: true,
                      listType: MultiSelectListType.LIST,
                      cancelText: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 16,
                        ),
                      ),
                      confirmText: const Text(
                        "Add",
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 16,
                        ),
                      ),
                      items: controller.multiFoodList
                          .map(
                            (e) => MultiSelectItem(e, e.name),
                          )
                          .toList(),
                      title: const Text("Food"),
                      selectedColor: primary,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                          boxShadow: []),
                      buttonText: const Text(
                        "Please Select",
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 16,
                        ),
                      ),
                      onConfirm: controller.addFoodFromDropDownList,
                    ),
                  ),
                  SizedBox(
                    height: H * 0.02,
                  ),
                  topText("Amenities"),
                  SizedBox(
                    height: H * 0.02,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                    child: MultiSelectDialogField(
                      buttonIcon: const Icon(
                        Icons.keyboard_arrow_down,
                        size: 30,
                      ),
                      searchable: true,
                      listType: MultiSelectListType.LIST,
                      cancelText: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 16,
                        ),
                      ),
                      confirmText: const Text(
                        "Add",
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 16,
                        ),
                      ),
                      items: controller.multiAmenitiesList
                          .map(
                            (e) => MultiSelectItem(e, e.name),
                          )
                          .toList(),
                      title: const Text("Amenities"),
                      selectedColor: primary,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                          boxShadow: []),
                      buttonText: const Text(
                        "Please Select",
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 16,
                        ),
                      ),
                      onConfirm: controller.addAmenitiesFromDropDownList,
                    ),
                  ),
                  // DropdownButton(
                  //   width: W,
                  //   hint: "Please select",
                  //   ctrlList: controller.amenitiesList
                  //       .map((amenities) => DropdownMenuItem(
                  //             value: amenities,
                  //             child: Text(
                  //               amenities,
                  //               style: const TextStyle(
                  //                 fontSize: 16,
                  //               ),
                  //             ),
                  //           ))
                  //       .toList(),
                  //   onChange: (amenity) {
                  //     controller.amenities = amenity ?? "";
                  //     controller.searchListItem.add(controller.amenities);
                  //     controller.filter.amenity = amenity;
                  //     //controller.update();
                  //   },
                  // ),
                  SizedBox(
                    height: H * 0.02,
                  ),
                  topText("Events"),
                  SizedBox(
                    height: H * 0.02,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                    child: MultiSelectDialogField(
                      buttonIcon: const Icon(
                        Icons.keyboard_arrow_down,
                        size: 30,
                      ),
                      searchable: true,
                      listType: MultiSelectListType.LIST,
                      cancelText: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 16,
                        ),
                      ),
                      confirmText: const Text(
                        "Add",
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 16,
                        ),
                      ),
                      items: controller.multiEventList
                          .map(
                            (e) => MultiSelectItem(e, e.name),
                          )
                          .toList(),
                      title: const Text("Events"),
                      selectedColor: primary,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                          boxShadow: []),
                      buttonText: const Text(
                        "Please Select",
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 16,
                        ),
                      ),
                      onConfirm: controller.addEventFromDropDownList,
                    ),
                  ),
                  // DropdownButton(
                  //   width: W,
                  //   hint: "Please select",
                  //   ctrlList: controller.eventsList
                  //       .map((event) => DropdownMenuItem(
                  //             value: event,
                  //             child: Text(
                  //               event,
                  //               style: const TextStyle(
                  //                 fontSize: 16,
                  //               ),
                  //             ),
                  //           ))
                  //       .toList(),
                  //   onChange: (event) {
                  //     controller.events = event ?? "";
                  //     controller.searchListItem.add(controller.events);
                  //     controller.filter.event = event;
                  //     //controller.update();
                  //   },
                  // ),
                  SizedBox(
                    height: H * 0.02,
                  ),
                  topText("Restaurants/Bar types"),
                  SizedBox(
                    height: H * 0.02,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                    child: MultiSelectDialogField(
                      buttonIcon: const Icon(
                        Icons.keyboard_arrow_down,
                        size: 30,
                      ),
                      searchable: true,
                      listType: MultiSelectListType.LIST,
                      cancelText: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 16,
                        ),
                      ),
                      confirmText: const Text(
                        "Add",
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 16,
                        ),
                      ),
                      items: controller.multiBarList
                          .map(
                            (e) => MultiSelectItem(e, e.name),
                          )
                          .toList(),
                      title: const Text("Bar Types"),
                      selectedColor: primary,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(24)),
                          boxShadow: []),
                      buttonText: const Text(
                        "Please Select",
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 16,
                        ),
                      ),
                      onConfirm: controller.addBarTypeFromDropDownList,
                    ),
                  ),
                  // DropdownButton(
                  //   width: W,
                  //   hint: "Please select",
                  //   ctrlList: controller.barList
                  //       .map((barType) => DropdownMenuItem(
                  //             value: barType,
                  //             child: Text(
                  //               barType,
                  //               style: const TextStyle(
                  //                 fontSize: 16,
                  //               ),
                  //             ),
                  //           ))
                  //       .toList(),
                  //   onChange: (bar) {
                  //     controller.barType = bar ?? "";
                  //     controller.searchListItem.add(controller.barType);
                  //     controller.filter.bartype = bar;
                  //     //controller.update();
                  //   },
                  // ),
                  SizedBox(
                    height: H * 0.02,
                  ),
                  SizedBox(
                    height: H * 0.09,
                    width: W,
                    child: CustomElevatedButtonWidget(
                      onPressed: () async {
                        Get.toNamed(Routes.businessSearchResultScreen,
                            arguments: [
                              controller.searchListItem,
                              controller.hoursInRadiusList,
                              controller.hoursCityListFilter,
                            ]);
                      },
                      verticalPadding: 0,
                      borderRadius: 45,
                      text: "Search",
                      textColor: blackColor,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget topText(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class DropdownButton extends GetView<HappyHourFilterScreenController> {
  const DropdownButton({
    Key? key,
    this.width,
    this.height,
    this.hint,
    required this.onChange,
    required this.ctrlList,
    this.padding,
  }) : super(key: key);
  final double? width;
  final double? height;
  final String? hint;
  final Function(String?)? onChange;
  final List<DropdownMenuItem<String>> ctrlList;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(45),
      ),
      elevation: 5,
      child: SizedBox(
        height: height,
        width: width,
        child: DropdownButtonFormField<String>(
          elevation: 15,
          decoration: InputDecoration(
            enabled: false,
            contentPadding:
                padding ?? const EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 30.0),
            filled: true,
            fillColor: Colors.white,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(45)),
            ),
          ),
          isExpanded: true,
          hint: Text(hint ?? ""),
          icon: const Icon(Icons.keyboard_arrow_down),
          items: ctrlList,
          onChanged: onChange,
        ),
      ),
    );
  }
}
