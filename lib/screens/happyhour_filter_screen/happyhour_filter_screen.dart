// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/colors.dart';
import 'package:happy_hour_app/core/constants.dart';
import 'package:happy_hour_app/global_widgets/circular_indicator.dart';
import 'package:happy_hour_app/screens/happyhour_filter_screen/happyhour_filter_screen_controller.dart';
import '../../global_widgets/main_button.dart';
import '../../global_widgets/text_field.dart';
import '../../routes/app_routes.dart';

class HappyHourFilterScreen extends GetView<HappyHourFilterScreenController> {
  const HappyHourFilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HappyHourFilterScreenController>(
      builder: (controller) {
      //  return Scaffold(
      //    body: Padding(
      //     padding: const EdgeInsets.all(16.0),
      //     child: Container(
      //       height: Get.height,
      //       width: Get.width,
       
      //       child: Center(
      //         child: SizedBox(
      //         //  child:   Lottie.asset('assets/animations/coming-soon.json'),
      //         //child: Image.asset('assets/images/coming-soon.jpg'),
      //           child: Image.asset('assets/images/coming-soon5.png'),
      //         ),
      //       ),
      //     ),
      //        ),
      //  );
        return CustomCircleIndicator(
          isEnabled: controller.isLoading,
          opacity: 0.6,
          child: Scaffold(
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
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: InkWell(
                        onTap: () {
                          controller.showFutureHours =
                              !controller.showFutureHours;
                          controller.update();
                        },
                        child: Text(
                          !controller.showFutureHours
                              ? "Show Active Specials ⬇"
                              : "Hide Active Specials ⬆",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: H * 0.02,
                    ),
                    Visibility(
                      visible: controller.showFutureHours,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                                  hint: "Days",
                                  onChange: (day) {
                                    controller.days = day!;
                                    controller.filter.day = day;
                                    print(
                                        'filter.day: ${controller.filter.day}');
                                    controller.searchListItem.add(day);
                                    controller.update();
                                  },
                                  ctrlList: controller.daysList
                                      .map(
                                        (days) => DropdownMenuItem(
                                          value: days,
                                          child: Text(
                                            days,
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      )
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
                                    print(
                                        'filter.time: ${controller.filter.time}');

                                    controller.searchListItem.add(time);
                                    controller.update();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
                            controller.filter.locationUnit = distance;
                            print(
                                'filter.locationUnit: ${controller.filter.locationUnit}');
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

                          controller.filter.range = value;
                          controller.update();
                          print('filter.range: ${controller.filter.range}');
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

                    /// previous code
                    // CustomTextFieldWidget(
                    //   hintText: "Search",
                    //   textEditingController: controller.searchController,
                    //   onChanged: controller.assignValueToCity,
                    // ),
                    CustomTextFieldWidget(
                      onTap: () => controller.onBusinessNameClick(),
                      readOnly: true,
                      validator: controller.nameValidator,
                      labelText: "City Name",
                      textEditingController: controller.searchController,
                    ),
                    SizedBox(
                      height: H * 0.02,
                    ),
                    topText("Drink Specials"),
                    SizedBox(
                      height: H * 0.02,
                    ),
                    DropdownButton(
                      width: W,
                      hint: "Please select",
                      ctrlList: controller.drinkList
                          .map((drink) => DropdownMenuItem(
                                value: drink,
                                child: Text(
                                  drink,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ))
                          .toList(),
                      onChange: (drink) {
                        controller.drink = drink ?? "";
                        controller.searchListItem.add(controller.drink);
                        controller.filter.drink = drink;

                        controller.update();
                      },
                    ),
                    SizedBox(
                      height: H * 0.02,
                    ),
                    topText("Food Specials"),
                    SizedBox(
                      height: H * 0.02,
                    ),
                    DropdownButton(
                      width: W,
                      hint: "Please select",
                      ctrlList: controller.foodsList
                          .map((food) => DropdownMenuItem(
                                value: food,
                                child: Text(
                                  food,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ))
                          .toList(),
                      onChange: (food) {
                        controller.food = food ?? "";
                        controller.filter.food = food;
                        controller.searchListItem.add(controller.food);
                        controller.update();
                      },
                    ),
                    SizedBox(
                      height: H * 0.02,
                    ),
                    topText("Amenities"),
                    SizedBox(
                      height: H * 0.02,
                    ),
                    DropdownButton(
                      width: W,
                      hint: "Please select",
                      ctrlList: controller.amenitiesList
                          .map((amenities) => DropdownMenuItem(
                                value: amenities,
                                child: Text(
                                  amenities,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ))
                          .toList(),
                      onChange: (amenity) {
                        controller.amenities = amenity ?? "";
                        controller.searchListItem.add(controller.amenities);
                        controller.filter.amenity = amenity;
                        controller.update();
                      },
                    ),
                    SizedBox(
                      height: H * 0.02,
                    ),
                    topText("Events"),
                    SizedBox(
                      height: H * 0.02,
                    ),
                    DropdownButton(
                      width: W,
                      hint: "Please select",
                      ctrlList: controller.eventsList
                          .map((event) => DropdownMenuItem(
                                value: event,
                                child: Text(
                                  event,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ))
                          .toList(),
                      onChange: (event) {
                        controller.events = event ?? "";
                        controller.searchListItem.add(controller.events);
                        controller.filter.event = event;
                        controller.update();
                      },
                    ),
                    SizedBox(
                      height: H * 0.02,
                    ),
                    topText("Restaurants/Bar types"),
                    SizedBox(
                      height: H * 0.02,
                    ),
                    DropdownButton(
                      width: W,
                      hint: "Please select",
                      ctrlList: controller.barList
                          .map((barType) => DropdownMenuItem(
                                value: barType,
                                child: Text(
                                  barType,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ))
                          .toList(),
                      onChange: (bar) {
                        controller.barType = bar ?? "";
                        controller.searchListItem.add(controller.barType);
                        controller.filter.bartype = bar;
                        controller.update();
                      },
                    ),
                    SizedBox(
                      height: H * 0.02,
                    ),
                    SizedBox(
                      height: H * 0.09,
                      width: W,
                      child: CustomElevatedButtonWidget(
                        onPressed: () async {
                          await controller.getResults();
                          Get.toNamed(Routes.happyHourSearchResultScreen,
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
