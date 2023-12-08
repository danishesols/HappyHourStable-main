import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/screens/duplicate_happyhour/duplicate_happyhour_controller.dart';

import '../../../../core/colors.dart';
import '../../../../core/constants.dart';
import '../../../../global_controller/global_general_controller.dart';
import '../../../../global_widgets/main_button.dart';
import '../../../../global_widgets/price_field.dart';
import '../../../../global_widgets/text_field.dart';

class DuplicateDailySpecialScreen extends GetView<DuplicateController> {
  const DuplicateDailySpecialScreen({Key? key}) : super(key: key);

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
      body: GetBuilder<DuplicateController>(builder: (_) {
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: RawScrollbar(
            thumbColor: primary,
            // trackColor: whiteColor,
          // thumbVisibility: true,
          // trackVisibility: true,
            radius: const Radius.circular(20),
            thickness: 8,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: controller.dailySpecialKey,
                child: ListView(
                  children: [
                    SizedBox(
                      height: H * 0.009,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Daily Specials",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: H * 0.01,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
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
                                          shape: const StadiumBorder(),
                                          side: BorderSide.none,
                                          value: controller
                                              .daysList[0].isSelect.value,
                                          onChanged: (val) {
                                            controller.daysList[0].isSelect
                                                    .value =
                                                !controller
                                                    .daysList[0].isSelect.value;
                                            controller.dailyspecialsunDay =
                                                controller.daysList[0].day;
                                            if (controller
                                                .daysList[0].isSelect.isFalse) {
                                              controller
                                                  .sundaydailySpecialItemList
                                                  .clear();
                                            }
                                          }),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: W * 0.02,
                              ),
                              Text(
                                controller.daysList[0].day,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          sundayList(0, context),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: H * 0.01,
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Transform.scale(
                                  scale: 0.6,
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
                                            value: controller
                                                .daysList[1].isSelect.value,
                                            onChanged: (v) {
                                              controller.daysList[1].isSelect
                                                      .value =
                                                  !controller.daysList[1]
                                                      .isSelect.value;
                                              controller.dailyspecialmonDay =
                                                  controller.daysList[1].day;
                                              if (controller.daysList[1]
                                                  .isSelect.isFalse) {
                                                controller
                                                    .mondaydailySpecialItemList
                                                    .clear();
                                              }
                                            }),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: W * 0.02,
                                ),
                                Text(
                                  controller.daysList[1].day,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            mondayList(1, context),
                          ],
                        )),
                    SizedBox(
                      height: H * 0.01,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
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
                                          shape: const StadiumBorder(),
                                          side: BorderSide.none,
                                          value: controller
                                              .daysList[2].isSelect.value,
                                          onChanged: (val) {
                                            controller.daysList[2].isSelect
                                                    .value =
                                                !controller
                                                    .daysList[2].isSelect.value;
                                            controller.dailyspecialtuesDay =
                                                controller.daysList[2].day;
                                            if (controller
                                                .daysList[2].isSelect.isFalse) {
                                              controller
                                                  .tuesdaydailySpecialItemList
                                                  .clear();
                                            }
                                          }),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: W * 0.02,
                              ),
                              Text(
                                controller.daysList[2].day,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          tuesdayList(2, context),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: H * 0.01,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
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
                                          shape: const StadiumBorder(),
                                          side: BorderSide.none,
                                          value: controller
                                              .daysList[3].isSelect.value,
                                          onChanged: (val) {
                                            controller.daysList[3].isSelect
                                                    .value =
                                                !controller
                                                    .daysList[3].isSelect.value;
                                            controller.dailyspecialwedDay =
                                                controller.daysList[3].day;
                                            if (controller
                                                .daysList[3].isSelect.isFalse) {
                                              controller
                                                  .wednesdaydailySpecialItemList
                                                  .clear();
                                            }
                                          }),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: W * 0.02,
                              ),
                              Text(
                                controller.daysList[3].day,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          wednesdayList(3, context),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: H * 0.01,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
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
                                          shape: const StadiumBorder(),
                                          side: BorderSide.none,
                                          value: controller
                                              .daysList[4].isSelect.value,
                                          onChanged: (val) {
                                            controller.daysList[4].isSelect
                                                    .value =
                                                !controller
                                                    .daysList[4].isSelect.value;
                                            controller.dailyspecialthursDay =
                                                controller.daysList[4].day;
                                            if (controller
                                                .daysList[4].isSelect.isFalse) {
                                              controller
                                                  .thursdaydailySpecialItemList
                                                  .clear();
                                            }
                                          }),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: W * 0.02,
                              ),
                              Text(
                                controller.daysList[4].day,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          thursdayList(4, context),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: H * 0.01,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
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
                                          shape: const StadiumBorder(),
                                          side: BorderSide.none,
                                          value: controller
                                              .daysList[5].isSelect.value,
                                          onChanged: (val) {
                                            controller.daysList[5].isSelect
                                                    .value =
                                                !controller
                                                    .daysList[5].isSelect.value;
                                            controller.dailyspecialfriDay =
                                                controller.daysList[5].day;
                                            if (controller
                                                .daysList[5].isSelect.isFalse) {
                                              controller
                                                  .fridaydailySpecialItemList
                                                  .clear();
                                            }
                                          }),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: W * 0.02,
                              ),
                              Text(
                                controller.daysList[5].day,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          fridayList(5, context),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: H * 0.01,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Transform.scale(
                                scale: 0.6,
                                child: Obx(
                                  () => Card(
                                    margin: const EdgeInsets.all(0),
                                    elevation: 5,
                                    shape: const StadiumBorder(),
                                    child: Transform.scale(
                                      scale: 2.0,
                                      child: Checkbox(
                                          checkColor: Colors.amber,
                                          splashRadius: 20,
                                          shape: const StadiumBorder(),
                                          side: BorderSide.none,
                                          value: controller
                                              .daysList[6].isSelect.value,
                                          onChanged: (val) {
                                            controller.daysList[6].isSelect
                                                    .value =
                                                !controller
                                                    .daysList[6].isSelect.value;
                                            controller.dailyspecialsaturDay =
                                                controller.daysList[6].day;
                                            if (controller
                                                .daysList[6].isSelect.isFalse) {
                                              controller
                                                  .saturdaydailySpecialItemList
                                                  .clear();
                                            }
                                          }),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: W * 0.02,
                              ),
                              Text(
                                controller.daysList[6].day,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          saturdayList(6, context),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: H * 0.02,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 32),
        child: SizedBox(
          height: H * 0.09,
          child: CustomElevatedButtonWidget(
            onPressed: () {
              controller.dailySpecialDoneTap();
              // Get.to(() => const DuplicateAmenitiesScreen());
              // controller.dailySpecialTap();
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

  Obx sundayList(int index, BuildContext context) {
    return Obx(
          () => Visibility(
        visible: controller.daysList[index].isSelect.value,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //* if dailySpecialItemList is Not Empty Title will Show Here
            // controller.sundaydailySpecialItemList.isNotEmpty
            //     ? ListView.builder(
            //         shrinkWrap: true,
            //         itemCount: controller.sundaydailySpecialItemList.length,
            //         itemBuilder: ((context, index) {
            //           return
            //         }),
            //       )
            //     : const SizedBox(),

//*if Not Empty dailySpecialItemList ListView Builder Will show Here the food OR Drinks Item
            const SizedBox(
              height: 10,
            ),

            sundaydailspecialItemNameBuilder(index),
            const SizedBox(
              height: 10,
            ),
            //* Add New Item Button
            sundayaddButtonPopUP(context, index),
          ],
        ),
      ),
    );
  }

  Obx mondayList(int index, BuildContext context) {
    return Obx(
          () => Visibility(
        visible: controller.daysList[index].isSelect.value,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //* if dailySpecialItemList is Not Empty Title will Show Here

//*if Not Empty dailySpecialItemList ListView Builder Will show Here the food OR Drinks Item
            const SizedBox(
              height: 10,
            ),
            //* Add New Item Button
            mondaydailspecialItemNameBuilder(index),
            const SizedBox(
              height: 10,
            ),
            mondayaddButtonPopUP(context, index),
          ],
        ),
      ),
    );
  }

  Obx tuesdayList(int index, BuildContext context) {
    return Obx(
          () => Visibility(
        visible: controller.daysList[index].isSelect.value,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //* if dailySpecialItemList is Not Empty Title will Show Here

//*if Not Empty dailySpecialItemList ListView Builder Will show Here the food OR Drinks Item
            const SizedBox(
              height: 10,
            ),
            //* Add New Item Button
            tuesdaydailspecialItemNameBuilder(index),
            const SizedBox(
              height: 10,
            ),
            tuesdayaddButtonPopUP(context, index),
          ],
        ),
      ),
    );
  }

  Obx wednesdayList(int index, BuildContext context) {
    return Obx(
          () => Visibility(
        visible: controller.daysList[index].isSelect.value,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //* if dailySpecialItemList is Not Empty Title will Show Here

//*if Not Empty dailySpecialItemList ListView Builder Will show Here the food OR Drinks Item
            const SizedBox(
              height: 10,
            ),
            //* Add New Item Button
            wednesdaydailspecialItemNameBuilder(index),
            const SizedBox(
              height: 10,
            ),
            wednesdayaddButtonPopUP(context, index),
          ],
        ),
      ),
    );
  }

  Obx thursdayList(int index, BuildContext context) {
    return Obx(
          () => Visibility(
        visible: controller.daysList[index].isSelect.value,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //* if dailySpecialItemList is Not Empty Title will Show Here

//*if Not Empty dailySpecialItemList ListView Builder Will show Here the food OR Drinks Item
            const SizedBox(
              height: 10,
            ),
            //* Add New Item Button
            thursdaydailspecialItemNameBuilder(index),
            const SizedBox(
              height: 10,
            ),
            thursdayaddButtonPopUP(context, index),
          ],
        ),
      ),
    );
  }

  Obx fridayList(int index, BuildContext context) {
    return Obx(
          () => Visibility(
        visible: controller.daysList[index].isSelect.value,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //* if dailySpecialItemList is Not Empty Title will Show Here

//*if Not Empty dailySpecialItemList ListView Builder Will show Here the food OR Drinks Item
            const SizedBox(
              height: 10,
            ),
            //* Add New Item Button
            fridaydailspecialItemNameBuilder(index),
            const SizedBox(
              height: 10,
            ),
            fridayaddButtonPopUP(context, index),
          ],
        ),
      ),
    );
  }

  Obx saturdayList(int index, BuildContext context) {
    return Obx(
          () => Visibility(
        visible: controller.daysList[index].isSelect.value,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //* if dailySpecialItemList is Not Empty Title will Show Here

//*if Not Empty dailySpecialItemList ListView Builder Will show Here the food OR Drinks Item
            const SizedBox(
              height: 10,
            ),
            //* Add New Item Button
            saturdaydailspecialItemNameBuilder(index),
            const SizedBox(
              height: 10,
            ),
            saturdayaddButtonPopUP(context, index),
          ],
        ),
      ),
    );
  }

// //*Add New Item Button
//   Center sundayaddButtonPopUP(BuildContext context, int index) {
//     return Center(
//       child: SizedBox(
//         height: H * 0.06,
//         width: W * 0.5,
//         child: CustomElevatedButtonWidget(
//           onPressed: () {
//             //*It Will Show PopUP
//             addNewItemDialog(
//               context,
//               "Add new item",
//               () {
//                 navigator?.pop(context);
//                 addSundayManually(
//                   context,
//                   "Add Manually",
//                   CustomElevatedButtonWidget(
//                     horizontalPadding: 100,
//                     verticalPadding: 22,
//                     borderRadius: 45,
//                     fontSize: 24,
//                     textColor: blackColor,
//                     text: ("Add"),
//                     onPressed: () {
//                       if (controller.sundaydailySpecialType != "" &&
//                           controller.adddailySpecialManuallyController.text !=
//                               "") {
//                         controller.addManuallysundayAddTodailySpecialItemList();
//
//                         controller.adddailySpecialManuallyController.clear();
//                         controller.sundaydailySpecialType = "";
//                         Navigator.pop(context);
//                       } else {
//                         Get.find<GlobalGeneralController>()
//                             .errorSnackbar(description: "Select Type and Name",title:'Error');
//                       }
//                     },
//                   ),
//                   controller.adddailySpecialManuallyController,
//                 );
//               },
//               GetBuilder<EditController>(
//                 builder: (_) {
//                   return Column(
//                     children: [
//                       Card(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(45),
//                         ),
//                         elevation: 5,
//                         child: SizedBox(
//                           height: H * 0.07,
//                           width: W * 0.8,
//                           child: DropdownButtonFormField<String>(
//                             elevation: 15,
//                             decoration: const InputDecoration(
//                               enabled: false,
//                               contentPadding:
//                                   EdgeInsets.fromLTRB(16.0, 30.0, 18.0, 12.0),
//                               filled: true,
//                               fillColor: Colors.white,
//                               border: OutlineInputBorder(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(45)),
//                               ),
//                             ),
//                             isExpanded: true,
//                             hint: const Text(
//                               "Select Type",
//                               style:
//                                   TextStyle(fontSize: 14, color: Colors.grey),
//                             ),
//                             icon: const Icon(Icons.keyboard_arrow_down),
//                             items: controller.dailyDropDown
//                                 .map((foodOrDrink) => DropdownMenuItem(
//                                       value: foodOrDrink,
//                                       child: Text(
//                                         foodOrDrink,
//                                         style: const TextStyle(
//                                           color: Colors.black,
//                                           fontSize: 14,
//                                         ),
//                                       ),
//                                     ))
//                                 .toList(),
//                             onChanged: (daily) {
//                               controller.sundaydailySpecialType = daily!;
//                               controller.update();
//                             },
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Card(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(45),
//                         ),
//                         elevation: 5,
//                         child: SizedBox(
//                           height: H * 0.07,
//                           width: W * 0.8,
//                           child: DropdownButtonFormField<String>(
//                             elevation: 15,
//                             decoration: const InputDecoration(
//                               enabled: false,
//                               contentPadding:
//                                   EdgeInsets.fromLTRB(16.0, 30.0, 18.0, 12.0),
//                               filled: true,
//                               fillColor: Colors.white,
//                               border: OutlineInputBorder(
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(45)),
//                               ),
//                             ),
//                             isExpanded: true,
//                             hint: const Text(
//                               "Select Item",
//                               style:
//                                   TextStyle(fontSize: 14, color: Colors.grey),
//                             ),
//                             icon: const Icon(Icons.keyboard_arrow_down),
//                             items: controller.sundaydailySpecialType == "Drinks"
//                                 ? controller.dri
//                                     .map((name) => DropdownMenuItem(
//                                           value: name,
//                                           child: Text(
//                                             name,
//                                             style: const TextStyle(
//                                               color: Colors.black,
//                                               fontSize: 14,
//                                             ),
//                                           ),
//                                         ))
//                                     .toList()
//                                 : controller.sundaydailySpecialType == "Foods"
//                                     ? controller.foo
//                                         .map((name) => DropdownMenuItem(
//                                               value: name,
//                                               child: Text(
//                                                 name,
//                                                 style: const TextStyle(
//                                                   color: Colors.black,
//                                                   fontSize: 14,
//                                                 ),
//                                               ),
//                                             ))
//                                         .toList()
//                                     : [],
//                             onChanged: (time) {
//                               controller.dailSpecialName = time!;
//                             },
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       CustomElevatedButtonWidget(
//                         onPressed: () {
//                           //* add first drop down button
//                           if (controller.sundaydailySpecialType != null &&
//                               controller.dailSpecialName != null) {
//                             controller.sundayAddTodailySpecialItemList();
//                             Get.back();
//                             controller.sundaydailySpecialType = "";
//                           }
//                           // if (controller.sundaydailySpecialType != null &&
//                           //     controller.dailSpecialName != null) {
//                           //   controller.sundayAddTodailySpecialItemList();
//                           //   Get.back();
//                           // }
//                         },
//                         text: "Add",
//                         textColor: blackColor,
//                         fontSize: 24,
//                         verticalPadding: 20,
//                         horizontalPadding: 100,
//                         borderRadius: 45,
//                       ),
//                     ],
//                   );
//                 },
//               ),
//               Container(),
//             );
//           },
//           text: "Add new item",
//           textColor: blackColor,
//           fontSize: 16,
//           verticalPadding: 0,
//           borderRadius: 45,
//         ),
//       ),
//     );
//   }

  //*Add New Item Button
  Center sundayaddButtonPopUP(BuildContext context, int index) {
    return Center(
      child: SizedBox(
        height: H * 0.06,
        width: W * 0.5,
        child: CustomElevatedButtonWidget(
          onPressed: () {
            //*It Will Show PopUP
            controller.sundaydailySpecialType = null;
            controller.update();
            addNewItemDialog(
              context,
              "Add new item",
                  () {
                navigator?.pop(context);
                addSundayManually(
                  context,
                  "Add Manually",
                  CustomElevatedButtonWidget(
                    horizontalPadding: 100,
                    verticalPadding: 22,
                    borderRadius: 45,
                    fontSize: 24,
                    textColor: blackColor,
                    text: ("Add"),
                    onPressed: () {
                      if (controller.adddailySpecialManuallyController.text
                          .trim() !=
                          "") {
                        controller.addManuallysundayAddTodailySpecialItemList();
                        Navigator.pop(context);
                        controller.adddailySpecialManuallyController.clear();
                      } else {
                        Get.find<GlobalGeneralController>().infoSnackbar(
                            title: 'Empty',
                            description: 'Empty value is not allowed');
                      }
                    },
                  ),
                  controller.adddailySpecialManuallyController,
                );
              },
              GetBuilder<DuplicateController>(
                builder: (_) {
                  return Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45),
                        ),
                        elevation: 5,
                        child: SizedBox(
                          height: H * 0.07,
                          width: W * 0.8,
                          child: DropdownButtonFormField<String>(
                            elevation: 15,
                            decoration: const InputDecoration(
                              enabled: false,
                              contentPadding:
                              EdgeInsets.fromLTRB(16.0, 30.0, 18.0, 12.0),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(45)),
                              ),
                            ),
                            isExpanded: true,
                            hint: const Text(
                              "Select Type",
                              style:
                              TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: controller.dailyDropDown
                                .map((foodOrDrink) => DropdownMenuItem(
                              value: foodOrDrink,
                              child: Text(
                                foodOrDrink,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ))
                                .toList(),
                            onChanged: (daily) {
                              controller.sundaydailySpecialType = daily!;
                              controller.update();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45),
                        ),
                        elevation: 5,
                        child: SizedBox(
                          height: H * 0.07,
                          width: W * 0.8,
                          child: DropdownButtonFormField<String>(
                            elevation: 15,
                            decoration: const InputDecoration(
                              enabled: false,
                              contentPadding:
                              EdgeInsets.fromLTRB(16.0, 30.0, 18.0, 12.0),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(45)),
                              ),
                            ),
                            isExpanded: true,
                            hint: const Text(
                              "Select Item",
                              style:
                              TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: controller.sundaydailySpecialType == "Drinks"
                                ? controller.dri
                                .map((name) => DropdownMenuItem(
                              value: name,
                              child: Text(
                                name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ))
                                .toList()
                                : controller.foo
                                .map((name) => DropdownMenuItem(
                              value: name,
                              child: Text(
                                name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ))
                                .toList(),
                            onChanged: controller.sundaydailySpecialType != null
                                ? (time) {
                              controller.dailSpecialName = time!;
                              controller.dailySpecialfromtime =
                                  controller.timesList.last;
                              controller.dailySpecialtotime =
                                  controller.timesList.last;
                            }
                                : null,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomElevatedButtonWidget(
                        onPressed: () {
                          //* add first drop down button
                          if (controller.sundaydailySpecialType != null &&
                              controller.dailSpecialName != null) {
                            controller.sundayAddTodailySpecialItemList();
                            Get.back();
                          }
                        },
                        text: "Add",
                        textColor: blackColor,
                        fontSize: 24,
                        verticalPadding: 20,
                        horizontalPadding: 100,
                        borderRadius: 45,
                      ),
                    ],
                  );
                },
              ),
              Container(),
            );
          },
          text: "Add new item",
          textColor: blackColor,
          fontSize: 16,
          verticalPadding: 0,
          borderRadius: 45,
        ),
      ),
    );
  }

  Center mondayaddButtonPopUP(BuildContext context, int index) {
    return Center(
      child: SizedBox(
        height: H * 0.06,
        width: W * 0.5,
        child: CustomElevatedButtonWidget(
          onPressed: () {
            //*It Will Show PopUP
            controller.mondaydailySpecialType = null;
            addNewItemDialog(
              context,
              "Add new item",
                  () {
                navigator?.pop(context);
                addMondayManually(
                  context,
                  "Add Manually",
                  CustomElevatedButtonWidget(
                    horizontalPadding: 100,
                    verticalPadding: 22,
                    borderRadius: 45,
                    fontSize: 24,
                    textColor: blackColor,
                    text: ("Add"),
                    onPressed: () {
                      if (controller.adddailySpecialManuallyController.text
                          .trim() !=
                          "") {
                        controller.addManuallymondayAddTodailySpecialItemList();
                        Navigator.pop(context);
                        controller.adddailySpecialManuallyController.clear();
                      } else {
                        Get.find<GlobalGeneralController>().infoSnackbar(
                            title: 'Empty',
                            description: 'Empty value is not allowed');
                      }
                    },
                  ),
                  controller.adddailySpecialManuallyController,
                );
              },
              GetBuilder<DuplicateController>(
                builder: (_) {
                  return Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45),
                        ),
                        elevation: 5,
                        child: SizedBox(
                          height: H * 0.07,
                          width: W * 0.8,
                          child: DropdownButtonFormField<String>(
                            elevation: 15,
                            decoration: const InputDecoration(
                              enabled: false,
                              contentPadding:
                              EdgeInsets.fromLTRB(16.0, 30.0, 18.0, 12.0),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(45)),
                              ),
                            ),
                            isExpanded: true,
                            hint: const Text(
                              "Select Type",
                              style:
                              TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: controller.dailyDropDown
                                .map((foodOrDrink) => DropdownMenuItem(
                              value: foodOrDrink,
                              child: Text(
                                foodOrDrink,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ))
                                .toList(),
                            onChanged: (daily) {
                              controller.mondaydailySpecialType = daily!;
                              controller.update();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45),
                        ),
                        elevation: 5,
                        child: SizedBox(
                          height: H * 0.07,
                          width: W * 0.8,
                          child: DropdownButtonFormField<String>(
                            elevation: 15,
                            decoration: const InputDecoration(
                              enabled: false,
                              contentPadding:
                              EdgeInsets.fromLTRB(16.0, 30.0, 18.0, 12.0),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(45)),
                              ),
                            ),
                            isExpanded: true,
                            hint: const Text(
                              "Select Item",
                              style:
                              TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: controller.mondaydailySpecialType == "Drinks"
                                ? controller.dri
                                .map((name) => DropdownMenuItem(
                              value: name,
                              child: Text(
                                name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ))
                                .toList()
                                : controller.foo
                                .map((name) => DropdownMenuItem(
                              value: name,
                              child: Text(
                                name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ))
                                .toList(),
                            onChanged: controller.mondaydailySpecialType != null
                                ? (time) {
                              controller.dailSpecialName = time!;
                              controller.dailySpecialfromtime =
                                  controller.timesList.last;
                              controller.dailySpecialtotime =
                                  controller.timesList.last;
                            }
                                : null,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomElevatedButtonWidget(
                        onPressed: () {
                          //* add first drop down button

                          controller.mondayAddTodailySpecialItemList();

                          Get.back();
                        },
                        text: "Add",
                        textColor: blackColor,
                        fontSize: 24,
                        verticalPadding: 20,
                        horizontalPadding: 100,
                        borderRadius: 45,
                      ),
                    ],
                  );
                },
              ),
              Container(),
            );
          },
          text: "Add new item",
          textColor: blackColor,
          fontSize: 16,
          verticalPadding: 0,
          borderRadius: 45,
        ),
      ),
    );
  }

  Center tuesdayaddButtonPopUP(BuildContext context, int index) {
    return Center(
      child: SizedBox(
        height: H * 0.06,
        width: W * 0.5,
        child: CustomElevatedButtonWidget(
          onPressed: () {
            //*It Will Show PopUP
            controller.tuesdaydailySpecialType = null;
            addNewItemDialog(
              context,
              "Add new item",
                  () {
                navigator?.pop(context);
                addTuesdayManually(
                  context,
                  "Add Manually",
                  CustomElevatedButtonWidget(
                    horizontalPadding: 100,
                    verticalPadding: 22,
                    borderRadius: 45,
                    fontSize: 24,
                    textColor: blackColor,
                    text: ("Add"),
                    onPressed: () {
                      if (controller.adddailySpecialManuallyController.text
                          .trim() !=
                          "") {
                        controller
                            .addManuallytuesdayAddTodailySpecialItemList();
                        Navigator.pop(context);
                        controller.adddailySpecialManuallyController.clear();
                      } else {
                        Get.find<GlobalGeneralController>().infoSnackbar(
                            title: 'Empty',
                            description: 'Empty value is not allowed');
                      }
                    },
                  ),
                  controller.adddailySpecialManuallyController,
                );
              },
              GetBuilder<DuplicateController>(
                builder: (_) {
                  return Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45),
                        ),
                        elevation: 5,
                        child: SizedBox(
                          height: H * 0.07,
                          width: W * 0.8,
                          child: DropdownButtonFormField<String>(
                            elevation: 15,
                            decoration: const InputDecoration(
                              enabled: false,
                              contentPadding:
                              EdgeInsets.fromLTRB(16.0, 30.0, 18.0, 12.0),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(45)),
                              ),
                            ),
                            isExpanded: true,
                            hint: const Text(
                              "Select Type",
                              style:
                              TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: controller.dailyDropDown
                                .map((foodOrDrink) => DropdownMenuItem(
                              value: foodOrDrink,
                              child: Text(
                                foodOrDrink,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ))
                                .toList(),
                            onChanged: (daily) {
                              controller.tuesdaydailySpecialType = daily!;
                              controller.update();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45),
                        ),
                        elevation: 5,
                        child: SizedBox(
                          height: H * 0.07,
                          width: W * 0.8,
                          child: DropdownButtonFormField<String>(
                            elevation: 15,
                            decoration: const InputDecoration(
                              enabled: false,
                              contentPadding:
                              EdgeInsets.fromLTRB(16.0, 30.0, 18.0, 12.0),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(45)),
                              ),
                            ),
                            isExpanded: true,
                            hint: const Text(
                              "Select Item",
                              style:
                              TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items:
                            controller.tuesdaydailySpecialType == "Drinks"
                                ? controller.dri
                                .map((name) => DropdownMenuItem(
                              value: name,
                              child: Text(
                                name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ))
                                .toList()
                                : controller.foo
                                .map((name) => DropdownMenuItem(
                              value: name,
                              child: Text(
                                name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ))
                                .toList(),
                            onChanged:
                            controller.tuesdaydailySpecialType != null
                                ? (time) {
                              controller.dailSpecialName = time!;
                              controller.dailySpecialfromtime =
                                  controller.timesList.last;
                              controller.dailySpecialtotime =
                                  controller.timesList.last;
                            }
                                : null,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomElevatedButtonWidget(
                        onPressed: () {
                          //* add first drop down button

                          controller.tuesdayAddTodailySpecialItemList();

                          Get.back();
                        },
                        text: "Add",
                        textColor: blackColor,
                        fontSize: 24,
                        verticalPadding: 20,
                        horizontalPadding: 100,
                        borderRadius: 45,
                      ),
                    ],
                  );
                },
              ),
              Container(),
            );
          },
          text: "Add new item",
          textColor: blackColor,
          fontSize: 16,
          verticalPadding: 0,
          borderRadius: 45,
        ),
      ),
    );
  }

  Center wednesdayaddButtonPopUP(BuildContext context, int index) {
    return Center(
      child: SizedBox(
        height: H * 0.06,
        width: W * 0.5,
        child: CustomElevatedButtonWidget(
          onPressed: () {
            //*It Will Show PopUP
            controller.wednesdaydailySpecialType = null;
            addNewItemDialog(
              context,
              "Add new item",
                  () {
                navigator?.pop(context);
                addWednesdayManually(
                  context,
                  "Add Manually",
                  CustomElevatedButtonWidget(
                    horizontalPadding: 100,
                    verticalPadding: 22,
                    borderRadius: 45,
                    fontSize: 24,
                    textColor: blackColor,
                    text: ("Add"),
                    onPressed: () {
                      if (controller.adddailySpecialManuallyController.text
                          .trim() !=
                          "") {
                        controller
                            .addManuallywednesdayAddTodailySpecialItemList();
                        Navigator.pop(context);
                        controller.adddailySpecialManuallyController.clear();
                      } else {
                        Get.find<GlobalGeneralController>().infoSnackbar(
                            title: 'Empty',
                            description: 'Empty value is not allowed');
                      }
                    },
                  ),
                  controller.adddailySpecialManuallyController,
                );
              },
              GetBuilder<DuplicateController>(
                builder: (_) {
                  return Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45),
                        ),
                        elevation: 5,
                        child: SizedBox(
                          height: H * 0.07,
                          width: W * 0.8,
                          child: DropdownButtonFormField<String>(
                            elevation: 15,
                            decoration: const InputDecoration(
                              enabled: false,
                              contentPadding:
                              EdgeInsets.fromLTRB(16.0, 30.0, 18.0, 12.0),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(45)),
                              ),
                            ),
                            isExpanded: true,
                            hint: const Text(
                              "Select Type",
                              style:
                              TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: controller.dailyDropDown
                                .map((foodOrDrink) => DropdownMenuItem(
                              value: foodOrDrink,
                              child: Text(
                                foodOrDrink,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ))
                                .toList(),
                            onChanged: (daily) {
                              controller.wednesdaydailySpecialType = daily!;
                              controller.update();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45),
                        ),
                        elevation: 5,
                        child: SizedBox(
                          height: H * 0.07,
                          width: W * 0.8,
                          child: DropdownButtonFormField<String>(
                            elevation: 15,
                            decoration: const InputDecoration(
                              enabled: false,
                              contentPadding:
                              EdgeInsets.fromLTRB(16.0, 30.0, 18.0, 12.0),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(45)),
                              ),
                            ),
                            isExpanded: true,
                            hint: const Text(
                              "Select Item",
                              style:
                              TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items:
                            controller.wednesdaydailySpecialType == "Drinks"
                                ? controller.dri
                                .map((name) => DropdownMenuItem(
                              value: name,
                              child: Text(
                                name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ))
                                .toList()
                                : controller.foo
                                .map((name) => DropdownMenuItem(
                              value: name,
                              child: Text(
                                name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ))
                                .toList(),
                            onChanged:
                            controller.wednesdaydailySpecialType != null
                                ? (time) {
                              controller.dailSpecialName = time!;
                              controller.dailySpecialfromtime =
                                  controller.timesList.last;
                              controller.dailySpecialtotime =
                                  controller.timesList.last;
                            }
                                : null,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomElevatedButtonWidget(
                        onPressed: () {
                          //* add first drop down button

                          controller.wednesdayAddTodailySpecialItemList();

                          Get.back();
                        },
                        text: "Add",
                        textColor: blackColor,
                        fontSize: 24,
                        verticalPadding: 20,
                        horizontalPadding: 100,
                        borderRadius: 45,
                      ),
                    ],
                  );
                },
              ),
              Container(),
            );
          },
          text: "Add new item",
          textColor: blackColor,
          fontSize: 16,
          verticalPadding: 0,
          borderRadius: 45,
        ),
      ),
    );
  }

  Center thursdayaddButtonPopUP(BuildContext context, int index) {
    return Center(
      child: SizedBox(
        height: H * 0.06,
        width: W * 0.5,
        child: CustomElevatedButtonWidget(
          onPressed: () {
            //*It Will Show PopUP
            controller.thursdaydailySpecialType = null;
            addNewItemDialog(
              context,
              "Add new item",
                  () {
                navigator?.pop(context);
                addThursdayManually(
                  context,
                  "Add Manually",
                  CustomElevatedButtonWidget(
                    horizontalPadding: 100,
                    verticalPadding: 22,
                    borderRadius: 45,
                    fontSize: 24,
                    textColor: blackColor,
                    text: ("Add"),
                    onPressed: () {
                      if (controller.adddailySpecialManuallyController.text
                          .trim() !=
                          "") {
                        controller
                            .addManuallythursdayAddTodailySpecialItemList();
                        Navigator.pop(context);
                        controller.adddailySpecialManuallyController.clear();
                      } else {
                        Get.find<GlobalGeneralController>().infoSnackbar(
                            title: 'Empty',
                            description: 'Empty value is not allowed');
                      }
                    },
                  ),
                  controller.adddailySpecialManuallyController,
                );
              },
              GetBuilder<DuplicateController>(
                builder: (_) {
                  return Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45),
                        ),
                        elevation: 5,
                        child: SizedBox(
                          height: H * 0.07,
                          width: W * 0.8,
                          child: DropdownButtonFormField<String>(
                            elevation: 15,
                            decoration: const InputDecoration(
                              enabled: false,
                              contentPadding:
                              EdgeInsets.fromLTRB(16.0, 30.0, 18.0, 12.0),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(45)),
                              ),
                            ),
                            isExpanded: true,
                            hint: const Text(
                              "Select Type",
                              style:
                              TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: controller.dailyDropDown
                                .map((foodOrDrink) => DropdownMenuItem(
                              value: foodOrDrink,
                              child: Text(
                                foodOrDrink,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ))
                                .toList(),
                            onChanged: (daily) {
                              controller.thursdaydailySpecialType = daily!;
                              controller.update();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45),
                        ),
                        elevation: 5,
                        child: SizedBox(
                          height: H * 0.07,
                          width: W * 0.8,
                          child: DropdownButtonFormField<String>(
                            elevation: 15,
                            decoration: const InputDecoration(
                              enabled: false,
                              contentPadding:
                              EdgeInsets.fromLTRB(16.0, 30.0, 18.0, 12.0),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(45)),
                              ),
                            ),
                            isExpanded: true,
                            hint: const Text(
                              "Select Item",
                              style:
                              TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items:
                            controller.thursdaydailySpecialType == "Drinks"
                                ? controller.dri
                                .map((name) => DropdownMenuItem(
                              value: name,
                              child: Text(
                                name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ))
                                .toList()
                                : controller.foo
                                .map((name) => DropdownMenuItem(
                              value: name,
                              child: Text(
                                name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ))
                                .toList(),
                            onChanged:
                            controller.thursdaydailySpecialType != null
                                ? (time) {
                              controller.dailSpecialName = time!;
                              controller.dailySpecialfromtime =
                                  controller.timesList.last;
                              controller.dailySpecialtotime =
                                  controller.timesList.last;
                            }
                                : null,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomElevatedButtonWidget(
                        onPressed: () {
                          //* add first drop down button

                          controller.thursdayAddTodailySpecialItemList();

                          Get.back();
                        },
                        text: "Add",
                        textColor: blackColor,
                        fontSize: 24,
                        verticalPadding: 20,
                        horizontalPadding: 100,
                        borderRadius: 45,
                      ),
                    ],
                  );
                },
              ),
              Container(),
            );
          },
          text: "Add new item",
          textColor: blackColor,
          fontSize: 16,
          verticalPadding: 0,
          borderRadius: 45,
        ),
      ),
    );
  }

  Center fridayaddButtonPopUP(BuildContext context, int index) {
    return Center(
      child: SizedBox(
        height: H * 0.06,
        width: W * 0.5,
        child: CustomElevatedButtonWidget(
          onPressed: () {
            //*It Will Show PopUP
            controller.fridaydailySpecialType = null;
            addNewItemDialog(
              context,
              "Add new item",
                  () {
                navigator?.pop(context);
                addFridayManually(
                  context,
                  "Add Manually",
                  CustomElevatedButtonWidget(
                    horizontalPadding: 100,
                    verticalPadding: 22,
                    borderRadius: 45,
                    fontSize: 24,
                    textColor: blackColor,
                    text: ("Add"),
                    onPressed: () {
                      if (controller.adddailySpecialManuallyController.text
                          .trim() !=
                          "") {
                        controller.addManuallyfridayAddTodailySpecialItemList();
                        Navigator.pop(context);
                        controller.adddailySpecialManuallyController.clear();
                      } else {
                        Get.find<GlobalGeneralController>().infoSnackbar(
                            title: 'Empty',
                            description: 'Empty value is not allowed');
                      }
                    },
                  ),
                  controller.adddailySpecialManuallyController,
                );
              },
              GetBuilder<DuplicateController>(
                builder: (_) {
                  return Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45),
                        ),
                        elevation: 5,
                        child: SizedBox(
                          height: H * 0.07,
                          width: W * 0.8,
                          child: DropdownButtonFormField<String>(
                            elevation: 15,
                            decoration: const InputDecoration(
                              enabled: false,
                              contentPadding:
                              EdgeInsets.fromLTRB(16.0, 30.0, 18.0, 12.0),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(45)),
                              ),
                            ),
                            isExpanded: true,
                            hint: const Text(
                              "Select Type",
                              style:
                              TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: controller.dailyDropDown
                                .map((foodOrDrink) => DropdownMenuItem(
                              value: foodOrDrink,
                              child: Text(
                                foodOrDrink,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ))
                                .toList(),
                            onChanged: (daily) {
                              controller.fridaydailySpecialType = daily!;
                              controller.update();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45),
                        ),
                        elevation: 5,
                        child: SizedBox(
                          height: H * 0.07,
                          width: W * 0.8,
                          child: DropdownButtonFormField<String>(
                            elevation: 15,
                            decoration: const InputDecoration(
                              enabled: false,
                              contentPadding:
                              EdgeInsets.fromLTRB(16.0, 30.0, 18.0, 12.0),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(45)),
                              ),
                            ),
                            isExpanded: true,
                            hint: const Text(
                              "Select Item",
                              style:
                              TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: controller.fridaydailySpecialType == "Drinks"
                                ? controller.dri
                                .map((name) => DropdownMenuItem(
                              value: name,
                              child: Text(
                                name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ))
                                .toList()
                                : controller.foo
                                .map((name) => DropdownMenuItem(
                              value: name,
                              child: Text(
                                name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ))
                                .toList(),
                            onChanged: controller.fridaydailySpecialType != null
                                ? (time) {
                              controller.dailSpecialName = time!;
                              controller.dailySpecialfromtime =
                                  controller.timesList.last;
                              controller.dailySpecialtotime =
                                  controller.timesList.last;
                            }
                                : null,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomElevatedButtonWidget(
                        onPressed: () {
                          //* add first drop down button

                          controller.fridayAddTodailySpecialItemList();

                          Get.back();
                        },
                        text: "Add",
                        textColor: blackColor,
                        fontSize: 24,
                        verticalPadding: 20,
                        horizontalPadding: 100,
                        borderRadius: 45,
                      ),
                    ],
                  );
                },
              ),
              Container(),
            );
          },
          text: "Add new item",
          textColor: blackColor,
          fontSize: 16,
          verticalPadding: 0,
          borderRadius: 45,
        ),
      ),
    );
  }

  Center saturdayaddButtonPopUP(BuildContext context, int index) {
    return Center(
      child: SizedBox(
        height: H * 0.06,
        width: W * 0.5,
        child: CustomElevatedButtonWidget(
          onPressed: () {
            //*It Will Show PopUP
            controller.saturdaydailySpecialType = null;
            addNewItemDialog(
              context,
              "Add new item",
                  () {
                navigator?.pop(context);
                addSaturdayManually(
                  context,
                  "Add Manually",
                  CustomElevatedButtonWidget(
                    horizontalPadding: 100,
                    verticalPadding: 22,
                    borderRadius: 45,
                    fontSize: 24,
                    textColor: blackColor,
                    text: ("Add"),
                    onPressed: () {
                      if (controller.adddailySpecialManuallyController.text
                          .trim() !=
                          "") {
                        controller
                            .addManuallysaturdayAddTodailySpecialItemList();
                        Navigator.pop(context);
                        controller.adddailySpecialManuallyController.clear();
                      } else {
                        Get.find<GlobalGeneralController>().infoSnackbar(
                            title: 'Empty',
                            description: 'Empty value is not allowed');
                      }
                    },
                  ),
                  controller.adddailySpecialManuallyController,
                );
              },
              GetBuilder<DuplicateController>(
                builder: (_) {
                  return Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45),
                        ),
                        elevation: 5,
                        child: SizedBox(
                          height: H * 0.07,
                          width: W * 0.8,
                          child: DropdownButtonFormField<String>(
                            elevation: 15,
                            decoration: const InputDecoration(
                              enabled: false,
                              contentPadding:
                              EdgeInsets.fromLTRB(16.0, 30.0, 18.0, 12.0),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(45)),
                              ),
                            ),
                            isExpanded: true,
                            hint: const Text(
                              "Select Type",
                              style:
                              TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: controller.dailyDropDown
                                .map((foodOrDrink) => DropdownMenuItem(
                              value: foodOrDrink,
                              child: Text(
                                foodOrDrink,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ))
                                .toList(),
                            onChanged: (daily) {
                              controller.saturdaydailySpecialType = daily!;
                              controller.update();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45),
                        ),
                        elevation: 5,
                        child: SizedBox(
                          height: H * 0.07,
                          width: W * 0.8,
                          child: DropdownButtonFormField<String>(
                            elevation: 15,
                            decoration: const InputDecoration(
                              enabled: false,
                              contentPadding:
                              EdgeInsets.fromLTRB(16.0, 30.0, 18.0, 12.0),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(45)),
                              ),
                            ),
                            isExpanded: true,
                            hint: const Text(
                              "Select Item",
                              style:
                              TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items:
                            controller.saturdaydailySpecialType == "Drinks"
                                ? controller.dri
                                .map((name) => DropdownMenuItem(
                              value: name,
                              child: Text(
                                name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ))
                                .toList()
                                : controller.foo
                                .map((name) => DropdownMenuItem(
                              value: name,
                              child: Text(
                                name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                            ))
                                .toList(),
                            onChanged:
                            controller.saturdaydailySpecialType != null
                                ? (time) {
                              controller.dailSpecialName = time!;
                              controller.dailySpecialfromtime =
                                  controller.timesList.last;
                              controller.dailySpecialtotime =
                                  controller.timesList.last;
                            }
                                : null,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomElevatedButtonWidget(
                        onPressed: () {
                          //* add first drop down button

                          controller.saturdayAddTodailySpecialItemList();
                          // controller.daysList[index].isSelect.value = true;

                          Get.back();
                        },
                        text: "Add",
                        textColor: blackColor,
                        fontSize: 24,
                        verticalPadding: 20,
                        horizontalPadding: 100,
                        borderRadius: 45,
                      ),
                    ],
                  );
                },
              ),
              Container(),
            );
          },
          text: "Add new item",
          textColor: blackColor,
          fontSize: 16,
          verticalPadding: 0,
          borderRadius: 45,
        ),
      ),
    );
  }

  //*ListView
  ListView sundaydailspecialItemNameBuilder(int index) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.sundaydailySpecialItemList.length,
      itemBuilder: (context, x) {
        controller.sundaydailySpecialItemList[x]["sizeController"] != null
            ? controller.sundaydailySpecialItemList[x]["sizeController"].text =
            controller.sundaydailySpecialItemList[x]["quantity"].toString()
            : controller.sundaydailySpecialItemList[x]["sizeController"] =
            TextEditingController(
                text: controller.sundaydailySpecialItemList[x]["quantity"]
                    .toString());
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 1, right: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: W * 0.26,
                          child: const Text(
                            "Item Name",
                            style: TextStyle(
                              fontSize: 16,
                              color: blackColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        controller.sundaydailySpecialItemList[x]['index'] ==
                            "Drinks"
                            ? SizedBox(
                          width: W * 0.3,
                          child: const Text(
                            "Size",
                            style: TextStyle(
                              fontSize: 16,
                              color: blackColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                            : SizedBox(
                          width: W * 0.26,
                          child: const Text(
                            "Quantity",
                            style: TextStyle(
                              fontSize: 16,
                              color: blackColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: W * 0.2,
                          child: const Text(
                            "Price",
                            style: TextStyle(
                              fontSize: 16,
                              color: blackColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: W * 0.2,
                          child: const Text(
                            "Discount",
                            style: TextStyle(
                              fontSize: 16,
                              color: blackColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //*Food Names show Here
                  SizedBox(
                    width: W * 0.22,
                    child: Text(
                      controller.sundaydailySpecialItemList[x]["name"]
                          .toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  //* increment decrement here
                  Flexible(
                    child: SizedBox(
                      width: W * 0.27,
                      child: Row(
                        children: [
                          controller.sundaydailySpecialItemList[x]['index'] ==
                              "Foods"
                              ? Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  //*decrement Button
                                  controller
                                      .sundaydailySpecialdecrement(x);
                                },
                                icon: const Image(
                                  image: AssetImage(
                                      "assets/icons/Group 8197.png"),
                                ),
                              ),
                              Text(
                                controller.sundaydailySpecialItemList[x]
                                ["quantity"]
                                    .toString(),
                                style: const TextStyle(
                                    overflow: TextOverflow.clip,
                                    fontSize: 16),
                              ),
                              IconButton(
                                onPressed: () {
                                  //*increment Button
                                  controller
                                      .sundaydailySpecialincrement(x);
                                },
                                icon: const Image(
                                  image: AssetImage(
                                      "assets/icons/Group 8192@2x.png"),
                                ),
                              ),
                            ],
                          )
                              : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: SizedBox(
                                  width:
                                  MediaQuery.of(context).size.width /
                                      5,
                                  height:
                                  MediaQuery.of(context).size.height /
                                      28,
                                  child: Material(
                                    elevation: 3,
                                    borderRadius:
                                    BorderRadius.circular(45),
                                    child: Row(
                                      children: [
                                        Flexible(
                                          child: TextFormField(
                                            controller: controller
                                                .sundaydailySpecialItemList[
                                            x]["sizeController"],
                                            validator: (value) {
                                              if (value == null ||
                                                  value.trim().isEmpty) {
                                                return 'size';
                                              }

                                              // Return null if the entered Business name is valid
                                              return null;
                                            },
                                            onTap: () => controller
                                                .dailySpecialPrice
                                                .clear(),
                                            obscureText: false,
                                            keyboardType:
                                            TextInputType.number,
                                            onChanged: (val) {
                                              controller
                                                  .sundaydailySpecialItemList[
                                              x]["quantity"] = val;
                                            },
                                            decoration: InputDecoration(
                                              hintStyle: const TextStyle(
                                                  color: Colors.grey),
                                              contentPadding:
                                              const EdgeInsets
                                                  .fromLTRB(
                                                  8.0, 2.0, 2.0, 2.0),
                                              filled: false,
                                              fillColor: Colors.white,
                                              border: OutlineInputBorder(
                                                borderSide:
                                                BorderSide.none,
                                                borderRadius:
                                                BorderRadius.circular(
                                                    10),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.all(2.0),
                                            child: DropdownButton(
                                              underline: Container(),
                                              isExpanded: true,
                                              hint: const Text(""),
                                              value: controller
                                                  .sundaydailySpecialItemList[
                                              x]["sizeIcon"]
                                                  .toString(),
                                              items: controller
                                                  .sizeDropdownList
                                                  .map((String items) {
                                                return DropdownMenuItem(
                                                    value: items,
                                                    child: Text(
                                                      items,
                                                      maxLines: 1,
                                                      style:
                                                      const TextStyle(
                                                          fontSize:
                                                          10),
                                                    ));
                                              }).toList(),
                                              onChanged: (String? q) {
                                                controller
                                                    .sundaydailySpecialItemList[
                                                x]["sizeIcon"] = q;
                                                controller.update();
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          // SizedBox(
                          //     width: W * 0.22,
                          //     height: H * 0.034,
                          //     child: Material(
                          //       elevation: 3,
                          //       borderRadius: BorderRadius.circular(45),
                          //       child: TextFormField(
                          //         onTap: () =>
                          //             controller.dailySpecialPrice.clear(),
                          //         obscureText: false,
                          //         keyboardType: TextInputType.number,
                          //         onChanged: (val) {
                          //           controller.sundaydailySpecialItemList[x]
                          //               ["quantity"] = val;
                          //         },
                          //         decoration: InputDecoration(
                          //           // hintText: "Enter Discount",
                          //           hintStyle:
                          //               const TextStyle(color: Colors.grey),
                          //           contentPadding:
                          //               const EdgeInsets.fromLTRB(
                          //                   8.0, 2.0, 2.0, 2.0),
                          //           filled: false,
                          //           fillColor: Colors.white,
                          //           border: OutlineInputBorder(
                          //             borderSide: BorderSide.none,
                          //             borderRadius:
                          //                 BorderRadius.circular(10),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                        ],
                      ),
                    ),
                  ),
                  PriceField(
                    width: MediaQuery.of(context).size.width / 5,
                    height: MediaQuery.of(context).size.height / 28,
                    textEditingController: controller
                        .sundaydailySpecialItemList[x]?['pricecontroller'],
                    onTap: () {
                      controller.sundaydailySpecialItemList[x]['controller']
                          .clear();
                      controller.sundaydailySpecialItemList[x]['discount'] = '';
                    },
                    onChanged: (val) {
                      controller.sundaydailySpecialItemList[x]['price'] = val;
                    },
                    keyboardType: TextInputType.number,
                  ),

                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 5,
                      height: MediaQuery.of(context).size.height / 28,
                      child: Material(
                        elevation: 3,
                        borderRadius: BorderRadius.circular(45),
                        child: Row(
                          children: [
                            Flexible(
                              child: TextFormField(
                                controller:
                                controller.sundaydailySpecialItemList[x]
                                ['controller'],
                                onTap: () => controller
                                    .sundaydailySpecialItemList[x]
                                ['pricecontroller']
                                    .clear(),
                                obscureText: false,
                                keyboardType: TextInputType.number,
                                onChanged: (val) {
                                  controller.sundaydailySpecialItemList[x]
                                  ['price'] = "";
                                  controller.sundaydailySpecialItemList[x]
                                  ['discount'] = val;
                                },
                                decoration: InputDecoration(
                                  // hintText: "Enter Discount",
                                  hintStyle:
                                  const TextStyle(color: Colors.grey),
                                  contentPadding: const EdgeInsets.fromLTRB(
                                      8.0, 2.0, 2.0, 2.0),
                                  filled: false,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton(
                                  underline: Container(),
                                  isExpanded: true,
                                  hint: const Text(""),
                                  value: "%",
                                  items: controller.drinkDiscountDropdown
                                      .map((String items) {
                                    return DropdownMenuItem(
                                        value: items, child: Text(items));
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    controller.sundaydailySpecialItemList[x]
                                    ['discountIcon'] = newValue;
                                    // controller.foodList[index].dropDown[0] =
                                    //     newValue!;
                                    // controller.foodList[index].dropDown[1] =
                                    //     newValue;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: W * 0.28,
                    child: const Text(
                      "From",
                      style: TextStyle(
                        fontSize: 16,
                        color: blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: W * 0.2,
                    child: const Text(
                      "To",
                      style: TextStyle(
                        fontSize: 16,
                        color: blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: W * 0.25,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(45),
                    ),
                    elevation: 5,
                    child: SizedBox(
                      height: H * 0.067,
                      width: W * 0.29,
                      child: DropdownButtonFormField<String>(
                        // validator: (value) {
                        //   // if (value == null || value.trim().isEmpty) {
                        //   //   return 'select';
                        //   // }
                        //   // return null;
                        // },
                        elevation: 15,
                        decoration: const InputDecoration(
                          enabled: false,
                          contentPadding:
                          EdgeInsets.fromLTRB(16.0, 10, 2.0, 12.0),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(45)),
                          ),
                        ),
                        isExpanded: true,
                        value: controller.sundaydailySpecialItemList[x]
                        ?['fromTime'] ??
                            controller.timesList.last,
                        hint: Text(
                          controller.sundaydailySpecialItemList[x]?['fromTime'],
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                        ),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: controller.timesList
                            .map((fromTime) => DropdownMenuItem(
                          value: fromTime,
                          child: Text(
                            fromTime,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ))
                            .toList(),
                        onChanged: (time) {
                          controller.dailySpecialfromtime = time!;
                          controller.sundaydailySpecialItemList[x]
                          ?['fromTime'] = time;

                          controller.update();
                          // print(controller.dailySpecialfromtime);
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
                      height: H * 0.067,
                      width: W * 0.29,
                      child: DropdownButtonFormField<String>(
                        // validator: (value) {
                        //   if (value == null || value.trim().isEmpty) {
                        //     return 'select';
                        //   }

                        //   return null;
                        // },
                        elevation: 15,
                        decoration: const InputDecoration(
                          enabled: false,
                          contentPadding:
                          EdgeInsets.fromLTRB(16.0, 0.0, 2.0, 12.0),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(45)),
                          ),
                        ),
                        isExpanded: true,
                        value: controller.sundaydailySpecialItemList[x]
                        ?['toTime'] ??
                            controller.timesList.last,
                        hint: Text(
                          controller.sundaydailySpecialItemList[x]?['toTime'],
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                        ),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: controller.timesList
                            .map((toTime) => DropdownMenuItem(
                          value: toTime,
                          child: Text(
                            toTime,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ))
                            .toList(),
                        onChanged: (time) {
                          controller.dailySpecialtotime = time!;
                          controller.sundaydailySpecialItemList[x]
                          ?['toTime'] = time;
                          controller.update();
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: W * 0.12,
                  ),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(90),
                    ),
                    child: SizedBox(
                      width: W * 0.09,
                      height: 35,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          controller.removesunday(x);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  ListView mondaydailspecialItemNameBuilder(int index) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.mondaydailySpecialItemList.length,
      itemBuilder: (context, x) {
        controller.mondaydailySpecialItemList[x]["sizeController"] != null
            ? controller.mondaydailySpecialItemList[x]["sizeController"].text =
            controller.mondaydailySpecialItemList[x]["quantity"].toString()
            : controller.mondaydailySpecialItemList[x]["sizeController"] =
            TextEditingController(
                text: controller.mondaydailySpecialItemList[x]["quantity"]
                    .toString());
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: W * 0.26,
                  child: const Text(
                    "Item Name",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                controller.mondaydailySpecialItemList[x]['index'] == "Drinks"
                    ? SizedBox(
                  width: W * 0.3,
                  child: const Text(
                    "Size",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                    : SizedBox(
                  width: W * 0.26,
                  child: const Text(
                    "Quantity",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: W * 0.2,
                  child: const Text(
                    "Price",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: W * 0.2,
                  child: const Text(
                    "Discount",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //*Food Names show Here
                SizedBox(
                  width: W * 0.22,
                  child: Text(
                    controller.mondaydailySpecialItemList[x]["name"].toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                //* increment decrement here
                Flexible(
                  child: SizedBox(
                    width: W * 0.27,
                    child: Row(
                      children: [
                        controller.mondaydailySpecialItemList[x]['index'] ==
                            "Foods"
                            ? Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                //*decrement Button
                                controller.mondaydailySpecialdecrement(x);
                              },
                              icon: const Image(
                                image: AssetImage(
                                    "assets/icons/Group 8197.png"),
                              ),
                            ),
                            Text(
                              controller.mondaydailySpecialItemList[x]
                              ["quantity"]
                                  .toString(),
                              style: const TextStyle(
                                  overflow: TextOverflow.clip,
                                  fontSize: 16),
                            ),
                            IconButton(
                              onPressed: () {
                                //*increment Button
                                controller.mondaydailySpecialincrement(x);
                              },
                              icon: const Image(
                                image: AssetImage(
                                    "assets/icons/Group 8192@2x.png"),
                              ),
                            ),
                          ],
                        )
                            : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: SizedBox(
                                width:
                                MediaQuery.of(context).size.width / 5,
                                height:
                                MediaQuery.of(context).size.height /
                                    28,
                                child: Material(
                                  elevation: 3,
                                  borderRadius: BorderRadius.circular(45),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: TextFormField(
                                          controller: controller
                                              .mondaydailySpecialItemList[
                                          x]["sizeController"]
                                          as TextEditingController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return 'size';
                                            }
                                            return null;
                                          },
                                          onTap: () => controller
                                              .dailySpecialPrice
                                              .clear(),
                                          obscureText: false,
                                          keyboardType:
                                          TextInputType.number,
                                          onChanged: (val) {
                                            controller
                                                .mondaydailySpecialItemList[
                                            x]["quantity"] = val;
                                          },
                                          decoration: InputDecoration(
                                            hintStyle: const TextStyle(
                                                color: Colors.grey),
                                            contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                8.0, 2.0, 2.0, 2.0),
                                            filled: false,
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.all(2.0),
                                          child: DropdownButton(
                                            underline: Container(),
                                            isExpanded: true,
                                            hint: const Text(""),
                                            value: controller
                                                .mondaydailySpecialItemList[
                                            x]["sizeIcon"]
                                                .toString(),
                                            items: controller
                                                .sizeDropdownList
                                                .map((String items) {
                                              return DropdownMenuItem(
                                                  value: items,
                                                  child: Text(
                                                    items,
                                                    maxLines: 1,
                                                    style:
                                                    const TextStyle(
                                                        fontSize: 10),
                                                  ));
                                            }).toList(),
                                            onChanged: (String? q) {
                                              controller
                                                  .mondaydailySpecialItemList[
                                              x]["sizeIcon"] = q;
                                              controller.update();
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),

                        // SizedBox(
                        //     width: W * 0.22,
                        //     height: H * 0.034,
                        //     child: Material(
                        //       elevation: 3,
                        //       borderRadius: BorderRadius.circular(45),
                        //       child: TextFormField(
                        //         onTap: () =>
                        //             controller.dailySpecialPrice.clear(),
                        //         obscureText: false,
                        //         keyboardType: TextInputType.number,
                        //         onChanged: (val) {
                        //           controller.sundaydailySpecialItemList[x]
                        //               ["quantity"] = val;
                        //         },
                        //         decoration: InputDecoration(
                        //           // hintText: "Enter Discount",
                        //           hintStyle:
                        //               const TextStyle(color: Colors.grey),
                        //           contentPadding: const EdgeInsets.fromLTRB(
                        //               8.0, 2.0, 2.0, 2.0),
                        //           filled: false,
                        //           fillColor: Colors.white,
                        //           border: OutlineInputBorder(
                        //             borderSide: BorderSide.none,
                        //             borderRadius: BorderRadius.circular(10),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                      ],
                    ),
                  ),
                ),

                PriceField(
                  width: MediaQuery.of(context).size.width / 5,
                  height: MediaQuery.of(context).size.height / 28,
                  textEditingController: controller
                      .mondaydailySpecialItemList[x]['pricecontroller'],
                  onTap: () {
                    controller.mondaydailySpecialItemList[x]['controller']
                        .clear();
                    controller.mondaydailySpecialItemList[x]['discount'] = '';
                  },
                  onChanged: (val) {
                    controller.mondaydailySpecialItemList[x]['price'] = val;
                  },
                  keyboardType: TextInputType.number,
                ),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width / 5,
                //   height: MediaQuery.of(context).size.height / 24,
                //   child: CustomTextFieldWidget(
                //     // textEditingController: controller.dailySpecialPrice,
                //     onChanged: (val) {
                //       controller.mondaydailySpecialItemList[x]['price'] = val;
                //     },
                //     keyboardType: TextInputType.number,
                //   ),
                // ),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 5,
                    height: MediaQuery.of(context).size.height / 28,
                    child: Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(45),
                      child: Row(
                        children: [
                          Flexible(
                            child: TextFormField(
                              controller: controller
                                  .mondaydailySpecialItemList[x]['controller'],
                              onTap: () => controller
                                  .mondaydailySpecialItemList[x]
                              ['pricecontroller']
                                  .clear(),
                              obscureText: false,
                              keyboardType: TextInputType.number,
                              onChanged: (val) {
                                controller.mondaydailySpecialItemList[x]
                                ['price'] = "";
                                controller.mondaydailySpecialItemList[x]
                                ['discount'] = val;
                              },
                              decoration: InputDecoration(
                                // hintText: "Enter Discount",
                                hintStyle: const TextStyle(color: Colors.grey),
                                contentPadding: const EdgeInsets.fromLTRB(
                                    8.0, 2.0, 2.0, 2.0),
                                filled: false,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton(
                                underline: Container(),
                                isExpanded: true,
                                hint: const Text(""),
                                value: "%",
                                items: controller.drinkDiscountDropdown
                                    .map((String items) {
                                  return DropdownMenuItem(
                                      value: items, child: Text(items));
                                }).toList(),
                                onChanged: (String? newValue) {
                                  // controller.foodList[index].dropDown[0] =
                                  //     newValue!;
                                  // controller.foodList[index].dropDown[1] =
                                  //     newValue;
                                  controller.mondaydailySpecialItemList[x]
                                  ['discountIcon'] = newValue;
                                  controller.update();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: W * 0.25,
                  child: const Text(
                    "From",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: W * 0.2,
                  child: const Text(
                    "To",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: W * 0.25),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // IconButton(
                //   onPressed: () {
                //     controller.removemonday(x);
                //   },
                //   icon: const Icon(
                //     Icons.delete,
                //     color: Colors.red,
                //     size: 30,
                //   ),
                // ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45),
                  ),
                  elevation: 5,
                  child: SizedBox(
                    height: H * 0.067,
                    width: W * 0.29,
                    child: DropdownButtonFormField<String>(
                      // validator: (value) {
                      //   if (value == null || value.trim().isEmpty) {
                      //     return 'select';
                      //   }
                      //   return null;
                      // },
                      elevation: 15,
                      decoration: const InputDecoration(
                        enabled: false,
                        contentPadding:
                        EdgeInsets.fromLTRB(16.0, 10, 2.0, 12.0),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(45)),
                        ),
                      ),
                      isExpanded: true,
                      value: controller.mondaydailySpecialItemList[x]
                      ?['fromTime'] ??
                          controller.timesList.last,
                      hint: Text(
                        controller.mondaydailySpecialItemList[x]?['fromTime'],
                        style:
                        const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: controller.timesList
                          .map((fromTime) => DropdownMenuItem(
                        value: fromTime,
                        child: Text(
                          fromTime,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ))
                          .toList(),
                      onChanged: (time) {
                        controller.dailySpecialfromtime = time!;
                        controller.mondaydailySpecialItemList[x]?['fromTime'] =
                            time;
                        controller.update();
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
                    height: H * 0.067,
                    width: W * 0.29,
                    child: DropdownButtonFormField<String>(
                      // validator: (value) {
                      //   if (value == null || value.trim().isEmpty) {
                      //     return 'select';
                      //   }
                      //   return null;
                      // },
                      elevation: 15,
                      decoration: const InputDecoration(
                        enabled: false,
                        contentPadding:
                        EdgeInsets.fromLTRB(16.0, 10.0, 2.0, 12.0),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(45)),
                        ),
                      ),
                      isExpanded: true,
                      value: controller.mondaydailySpecialItemList[x]
                      ?['toTime'] ??
                          controller.timesList.last,
                      hint: Text(
                        controller.mondaydailySpecialItemList[x]?['toTime'],
                        style:
                        const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: controller.timesList
                          .map((toTime) => DropdownMenuItem(
                        value: toTime,
                        child: Text(
                          toTime,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ))
                          .toList(),
                      onChanged: (time) {
                        controller.dailySpecialtotime = time!;
                        controller.mondaydailySpecialItemList[x]?['toTime'] =
                            time;
                        controller.update();
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: W * 0.12,
                ),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(90),
                  ),
                  child: SizedBox(
                    width: W * 0.09,
                    height: 35,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        controller.removemonday(x);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  ListView tuesdaydailspecialItemNameBuilder(int index) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.tuesdaydailySpecialItemList.length,
      itemBuilder: (context, x) {
        controller.tuesdaydailySpecialItemList[x]["sizeController"] != null
            ? controller.tuesdaydailySpecialItemList[x]["sizeController"].text =
            controller.tuesdaydailySpecialItemList[x]["quantity"].toString()
            : controller.tuesdaydailySpecialItemList[x]["sizeController"] =
            TextEditingController(
                text: controller.tuesdaydailySpecialItemList[x]["quantity"]
                    .toString());
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: W * 0.26,
                  child: const Text(
                    "Item Name",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                controller.tuesdaydailySpecialItemList[x]['index'] == "Drinks"
                    ? SizedBox(
                  width: W * 0.3,
                  child: const Text(
                    "Size",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                    : SizedBox(
                  width: W * 0.26,
                  child: const Text(
                    "Quantity",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: W * 0.2,
                  child: const Text(
                    "Price",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: W * 0.2,
                  child: const Text(
                    "Discount",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //*Food Names show Here
                SizedBox(
                  width: W * 0.22,
                  child: Text(
                    controller.tuesdaydailySpecialItemList[x]["name"]
                        .toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                //* increment decrement here
                Flexible(
                  child: SizedBox(
                    width: W * 0.27,
                    child: Row(
                      children: [
                        // controller.tuesdaydailySpecialItemList
                        //         .contains(controller.dailySpecialType)
                        controller.tuesdaydailySpecialItemList[x]['index'] ==
                            "Foods"
                            ? Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                //*decrement Button
                                controller
                                    .tuesdaydailySpecialdecrement(x);
                              },
                              icon: const Image(
                                image: AssetImage(
                                    "assets/icons/Group 8197.png"),
                              ),
                            ),
                            Text(
                              controller.tuesdaydailySpecialItemList[x]
                              ["quantity"]
                                  .toString(),
                              style: const TextStyle(
                                  overflow: TextOverflow.clip,
                                  fontSize: 16),
                            ),
                            IconButton(
                              onPressed: () {
                                //*increment Button
                                controller
                                    .tuesdaydailySpecialincrement(x);
                              },
                              icon: const Image(
                                image: AssetImage(
                                    "assets/icons/Group 8192@2x.png"),
                              ),
                            ),
                          ],
                        )
                            : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: SizedBox(
                                width:
                                MediaQuery.of(context).size.width / 5,
                                height:
                                MediaQuery.of(context).size.height /
                                    28,
                                child: Material(
                                  elevation: 3,
                                  borderRadius: BorderRadius.circular(45),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: TextFormField(
                                          controller: controller
                                              .tuesdaydailySpecialItemList[
                                          x]["sizeController"],
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return 'size';
                                            }
                                            return null;
                                          },
                                          onTap: () => controller
                                              .dailySpecialPrice
                                              .clear(),
                                          obscureText: false,
                                          keyboardType:
                                          TextInputType.number,
                                          onChanged: (val) {
                                            controller
                                                .tuesdaydailySpecialItemList[
                                            x]["quantity"] = val;
                                          },
                                          decoration: InputDecoration(
                                            hintStyle: const TextStyle(
                                                color: Colors.grey),
                                            contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                8.0, 2.0, 2.0, 2.0),
                                            filled: false,
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.all(2.0),
                                          child: DropdownButton(
                                            underline: Container(),
                                            isExpanded: true,
                                            hint: const Text(""),
                                            value: controller
                                                .tuesdaydailySpecialItemList[
                                            x]["sizeIcon"]
                                                .toString(),
                                            items: controller
                                                .sizeDropdownList
                                                .map((String items) {
                                              return DropdownMenuItem(
                                                  value: items,
                                                  child: Text(
                                                    items,
                                                    maxLines: 1,
                                                    style:
                                                    const TextStyle(
                                                        fontSize: 10),
                                                  ));
                                            }).toList(),
                                            onChanged:
                                                (String? newValue) {
                                              controller
                                                  .tuesdaydailySpecialItemList[x]
                                              ["sizeIcon"] = newValue;
                                              controller.update();
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),

                        //  SizedBox(
                        //     width: W * 0.22,
                        //     height: H * 0.034,
                        //     child: Material(
                        //       elevation: 3,
                        //       borderRadius: BorderRadius.circular(45),
                        //       child: TextFormField(
                        //         onTap: () =>
                        //             controller.dailySpecialPrice.clear(),
                        //         obscureText: false,
                        //         keyboardType: TextInputType.number,
                        //         onChanged: (val) {
                        //           controller.sundaydailySpecialItemList[x]
                        //               ["quantity"] = val;
                        //         },
                        //         decoration: InputDecoration(
                        //           // hintText: "Enter Discount",
                        //           hintStyle:
                        //               const TextStyle(color: Colors.grey),
                        //           contentPadding: const EdgeInsets.fromLTRB(
                        //               8.0, 2.0, 2.0, 2.0),
                        //           filled: false,
                        //           fillColor: Colors.white,
                        //           border: OutlineInputBorder(
                        //             borderSide: BorderSide.none,
                        //             borderRadius: BorderRadius.circular(10),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                      ],
                    ),
                  ),
                ),
                PriceField(
                  width: MediaQuery.of(context).size.width / 5,
                  height: MediaQuery.of(context).size.height / 28,
                  textEditingController: controller
                      .tuesdaydailySpecialItemList[x]['pricecontroller'],
                  onTap: () {
                    controller.tuesdaydailySpecialItemList[x]['controller']
                        .clear();
                  },
                  onChanged: (val) {
                    controller.tuesdaydailySpecialItemList[x]['discount'] = '';
                    controller.tuesdaydailySpecialItemList[x]['price'] = val;
                  },
                  keyboardType: TextInputType.number,
                ),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width / 5,
                //   height: MediaQuery.of(context).size.height / 24,
                //   child: CustomTextFieldWidget(
                //     textEditingController: controller.dailySpecialPrice,
                //     onChanged: (val) {
                //       controller.tuesdaydailySpecialItemList[x]['price'] = val;
                //     },
                //     keyboardType: TextInputType.number,
                //   ),
                // ),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 5,
                    height: MediaQuery.of(context).size.height / 28,
                    child: Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(45),
                      child: Row(
                        children: [
                          Flexible(
                            child: TextFormField(
                              controller: controller
                                  .tuesdaydailySpecialItemList[x]['controller'],
                              onTap: () => controller
                                  .tuesdaydailySpecialItemList[x]
                              ['pricecontroller']
                                  .clear(),
                              obscureText: false,
                              keyboardType: TextInputType.number,
                              onChanged: (val) {
                                controller.tuesdaydailySpecialItemList[x]
                                ['price'] = "";
                                controller.tuesdaydailySpecialItemList[x]
                                ['discount'] = val;
                              },
                              decoration: InputDecoration(
                                // hintText: "Enter Discount",
                                hintStyle: const TextStyle(color: Colors.grey),
                                contentPadding: const EdgeInsets.fromLTRB(
                                    8.0, 2.0, 2.0, 2.0),
                                filled: false,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: DropdownButton(
                                underline: Container(),
                                isExpanded: true,
                                hint: const Text(""),
                                value: "%",
                                items: controller.drinkDiscountDropdown
                                    .map((String items) {
                                  return DropdownMenuItem(
                                      value: items, child: Text(items));
                                }).toList(),
                                onChanged: (String? newValue) {
                                  controller.tuesdaydailySpecialItemList[x]
                                  ['discountIcon'] = newValue;
                                  controller.foodList[index].dropDown[0] =
                                  newValue!;
                                  controller.foodList[index].dropDown[1] =
                                      newValue;

                                  controller.update();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: W * 0.25,
                  child: const Text(
                    "From",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: W * 0.2,
                  child: const Text(
                    "To",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: W * 0.25),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(
                //   width: W * 0.23,
                // ),
                // IconButton(
                //   onPressed: () {
                //     controller.removetuesday(x);
                //   },
                //   icon: const Icon(
                //     Icons.delete,
                //     color: Colors.red,
                //     size: 30,
                //   ),
                // ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45),
                  ),
                  elevation: 5,
                  child: SizedBox(
                    height: H * 0.067,
                    width: W * 0.29,
                    child: DropdownButtonFormField<String>(
                      // validator: (value) {
                      //   if (value == null || value.trim().isEmpty) {
                      //     return 'select';
                      //   }
                      //   return null;
                      // },
                      elevation: 15,
                      decoration: const InputDecoration(
                        enabled: false,
                        contentPadding: EdgeInsets.fromLTRB(16.0, 0, 2.0, 0.0),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(45)),
                        ),
                      ),
                      value: controller.tuesdaydailySpecialItemList[x]
                      ?['fromTime'] ??
                          controller.timesList.last,
                      isExpanded: true,
                      // hint: Text(
                      //   controller.tuesdaydailySpecialItemList[x]?['fromTime'],
                      //   style:
                      //       const TextStyle(fontSize: 14, color: Colors.black),
                      // ),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: controller.timesList
                          .map((fromTime) => DropdownMenuItem(
                        value: fromTime,
                        child: Text(
                          fromTime,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ))
                          .toList(),
                      onChanged: (time) {
                        controller.dailySpecialfromtime = time!;
                        controller.tuesdaydailySpecialItemList[x]
                        ?['fromTime'] = time;
                        controller.update();
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
                    height: H * 0.067,
                    width: W * 0.29,
                    child: DropdownButtonFormField<String>(
                      // validator: (value) {
                      //   if (value == null || value.trim().isEmpty) {
                      //     return 'select';
                      //   }
                      //   return null;
                      // },
                      elevation: 15,
                      decoration: const InputDecoration(
                        enabled: false,
                        contentPadding:
                        EdgeInsets.fromLTRB(16.0, 0.0, 2.0, 0.0),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(45)),
                        ),
                      ),
                      isExpanded: true,
                      value: controller.tuesdaydailySpecialItemList[x]
                      ?['toTime'] ??
                          controller.timesList.last,
                      hint: Text(
                        controller.tuesdaydailySpecialItemList[x]?['toTime'],
                        style:
                        const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: controller.timesList
                          .map((toTime) => DropdownMenuItem(
                        value: toTime,
                        child: Text(
                          toTime,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ))
                          .toList(),
                      onChanged: (time) {
                        controller.dailySpecialtotime = time!;
                        controller.tuesdaydailySpecialItemList[x]
                        ?['toTime'] = time;
                        controller.update();
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: W * 0.12,
                ),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(90),
                  ),
                  child: SizedBox(
                    width: W * 0.09,
                    height: 35,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        controller.removetuesday(x);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  ListView wednesdaydailspecialItemNameBuilder(int index) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.wednesdaydailySpecialItemList.length,
      itemBuilder: (context, x) {
        controller.wednesdaydailySpecialItemList[x]["sizeController"] != null
            ? controller
            .wednesdaydailySpecialItemList[x]["sizeController"].text =
            controller.wednesdaydailySpecialItemList[x]["quantity"]
                .toString()
            : controller.wednesdaydailySpecialItemList[x]["sizeController"] =
            TextEditingController(
                text: controller.wednesdaydailySpecialItemList[x]
                ["quantity"]
                    .toString());
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: W * 0.26,
                  child: const Text(
                    "Item Name",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                controller.wednesdaydailySpecialItemList[x]['index'] == "Drinks"
                    ? SizedBox(
                  width: W * 0.3,
                  child: const Text(
                    "Size",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                    : SizedBox(
                  width: W * 0.26,
                  child: const Text(
                    "Quantity",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: W * 0.2,
                  child: const Text(
                    "Price",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: W * 0.2,
                  child: const Text(
                    "Discount",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //*Food Names show Here
                SizedBox(
                  width: W * 0.22,
                  child: Text(
                    controller.wednesdaydailySpecialItemList[x]["name"]
                        .toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                //* increment decrement here
                Flexible(
                  child: SizedBox(
                    width: W * 0.27,
                    child: Row(
                      children: [
                        controller.wednesdaydailySpecialItemList[x]['index'] ==
                            "Foods"
                            ? Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                //*decrement Button
                                controller
                                    .wednesdaydailySpecialdecrement(x);
                              },
                              icon: const Image(
                                image: AssetImage(
                                    "assets/icons/Group 8197.png"),
                              ),
                            ),
                            Text(
                              controller.wednesdaydailySpecialItemList[x]
                              ["quantity"]
                                  .toString(),
                              style: const TextStyle(
                                  overflow: TextOverflow.clip,
                                  fontSize: 16),
                            ),
                            IconButton(
                              onPressed: () {
                                //*increment Button
                                controller
                                    .wednesdaydailySpecialincrement(x);
                              },
                              icon: const Image(
                                image: AssetImage(
                                    "assets/icons/Group 8192@2x.png"),
                              ),
                            ),
                          ],
                        )
                            : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: SizedBox(
                                width:
                                MediaQuery.of(context).size.width / 5,
                                height:
                                MediaQuery.of(context).size.height /
                                    28,
                                child: Material(
                                  elevation: 3,
                                  borderRadius: BorderRadius.circular(45),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: TextFormField(
                                          controller: controller
                                              .wednesdaydailySpecialItemList[
                                          x]["sizeController"],
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return 'size';
                                            }
                                            return null;
                                          },
                                          onTap: () => controller
                                              .dailySpecialPrice
                                              .clear(),
                                          obscureText: false,
                                          keyboardType:
                                          TextInputType.number,
                                          onChanged: (val) {
                                            controller
                                                .wednesdaydailySpecialItemList[
                                            x]["quantity"] = val;
                                          },
                                          decoration: InputDecoration(
                                            hintStyle: const TextStyle(
                                                color: Colors.grey),
                                            contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                8.0, 2.0, 2.0, 2.0),
                                            filled: false,
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.all(2.0),
                                          child: DropdownButton(
                                            underline: Container(),
                                            isExpanded: true,
                                            hint: const Text(""),
                                            value: controller
                                                .wednesdaydailySpecialItemList[
                                            x]["sizeIcon"]
                                                .toString(),
                                            items: controller
                                                .sizeDropdownList
                                                .map((String items) {
                                              return DropdownMenuItem(
                                                  value: items,
                                                  child: Text(
                                                    items,
                                                    maxLines: 1,
                                                    style:
                                                    const TextStyle(
                                                        fontSize: 10),
                                                  ));
                                            }).toList(),
                                            onChanged:
                                                (String? newValue) {
                                              controller
                                                  .wednesdaydailySpecialItemList[x]
                                              ["sizeIcon"] = newValue;
                                              controller.update();
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        // SizedBox(
                        //   width: W * 0.22,
                        //   height: H * 0.034,
                        //   child: Material(
                        //     elevation: 3,
                        //     borderRadius: BorderRadius.circular(45),
                        //     child: TextFormField(
                        //       onTap: () => controller.dailySpecialPrice.clear(),
                        //       obscureText: false,
                        //       keyboardType: TextInputType.number,
                        //       onChanged: (val) {
                        //         controller.sundaydailySpecialItemList[x]
                        //             ["quantity"] = val;
                        //       },
                        //       decoration: InputDecoration(
                        //         // hintText: "Enter Discount",
                        //         hintStyle: const TextStyle(color: Colors.grey),
                        //         contentPadding: const EdgeInsets.fromLTRB(
                        //             8.0, 2.0, 2.0, 2.0),
                        //         filled: false,
                        //         fillColor: Colors.white,
                        //         border: OutlineInputBorder(
                        //           borderSide: BorderSide.none,
                        //           borderRadius: BorderRadius.circular(10),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),

                PriceField(
                  width: MediaQuery.of(context).size.width / 5,
                  height: MediaQuery.of(context).size.height / 28,
                  textEditingController: controller
                      .wednesdaydailySpecialItemList[x]['pricecontroller'],
                  onTap: () {
                    controller.wednesdaydailySpecialItemList[x]['controller']
                        .clear();
                  },
                  onChanged: (val) {
                    controller.wednesdaydailySpecialItemList[x]['price'] = val;
                    controller.wednesdaydailySpecialItemList[x]['discount'] =
                    "";
                  },
                  keyboardType: TextInputType.number,
                ),

                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 5,
                    height: MediaQuery.of(context).size.height / 28,
                    child: Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(45),
                      child: Row(
                        children: [
                          Flexible(
                            child: TextFormField(
                              controller:
                              controller.wednesdaydailySpecialItemList[x]
                              ['controller'],
                              onTap: () => controller
                                  .wednesdaydailySpecialItemList[x]
                              ['pricecontroller']
                                  .clear(),
                              obscureText: false,
                              keyboardType: TextInputType.number,
                              onChanged: (val) {
                                controller.wednesdaydailySpecialItemList[x]
                                ['price'] = "";
                                controller.wednesdaydailySpecialItemList[x]
                                ['discount'] = val;
                              },
                              decoration: InputDecoration(
                                // hintText: "Enter Discount",
                                hintStyle: const TextStyle(color: Colors.grey),
                                contentPadding: const EdgeInsets.fromLTRB(
                                    8.0, 2.0, 2.0, 2.0),
                                filled: false,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: DropdownButton(
                                underline: Container(),
                                isExpanded: true,
                                hint: const Text(""),
                                value: "%",
                                items: controller.drinkDiscountDropdown
                                    .map((String items) {
                                  return DropdownMenuItem(
                                      value: items, child: Text(items));
                                }).toList(),
                                onChanged: (String? newValue) {
                                  controller.wednesdaydailySpecialItemList[x]
                                  ['discountIcon'] = newValue;
                                  // controller.foodList[index].dropDown[0] =
                                  //     newValue!;
                                  // controller.foodList[index].dropDown[1] =
                                  //     newValue;
                                  controller.update();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: W * 0.25,
                  child: const Text(
                    "From",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: W * 0.2,
                  child: const Text(
                    "To",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: W * 0.25,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // IconButton(
                //   onPressed: () {
                //     controller.removewednesday(x);
                //   },
                //   icon: const Icon(
                //     Icons.delete,
                //     color: Colors.red,
                //     size: 30,
                //   ),
                // ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45),
                  ),
                  elevation: 5,
                  child: SizedBox(
                    height: H * 0.067,
                    width: W * 0.29,
                    child: DropdownButtonFormField<String>(
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'select';
                        }
                        return null;
                      },
                      elevation: 15,
                      decoration: const InputDecoration(
                        enabled: false,
                        contentPadding:
                        EdgeInsets.fromLTRB(16.0, 0.0, 2.0, 0.0),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(45)),
                        ),
                      ),
                      value: controller.wednesdaydailySpecialItemList[x]
                      ?['fromTime'] ??
                          controller.timesList.last,
                      isExpanded: true,
                      // hint: Text(
                      //   controller.wednesdaydailySpecialItemList[x]
                      //       ?['fromTime'],
                      //   style:
                      //       const TextStyle(fontSize: 14, color: Colors.black),
                      // ),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: controller.timesList
                          .map((fromTime) => DropdownMenuItem(
                        value: fromTime,
                        child: Text(
                          fromTime,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ))
                          .toList(),
                      onChanged: (time) {
                        controller.dailySpecialfromtime = time!;
                        controller.wednesdaydailySpecialItemList[x]
                        ?['fromTime'] = time;
                        controller.update();
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
                    height: H * 0.067,
                    width: W * 0.29,
                    child: DropdownButtonFormField<String>(
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'select';
                        }
                        return null;
                      },
                      elevation: 15,
                      decoration: const InputDecoration(
                        enabled: false,
                        contentPadding:
                        EdgeInsets.fromLTRB(10.0, 0.0, 2.0, 0.0),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(45)),
                        ),
                      ),
                      isExpanded: true,
                      value: controller.wednesdaydailySpecialItemList[x]
                      ?['toTime'] ??
                          controller.timesList.last,
                      hint: Text(
                        controller.wednesdaydailySpecialItemList[x]?['toTime'],
                        style:
                        const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: controller.timesList
                          .map(
                            (toTime) => DropdownMenuItem(
                          value: toTime,
                          child: Text(
                            toTime,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      )
                          .toList(),
                      onChanged: (time) {
                        controller.dailySpecialtotime = time!;
                        controller.wednesdaydailySpecialItemList[x]
                        ?['toTime'] = time;
                        controller.update();
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: W * 0.12,
                ),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(90),
                  ),
                  child: SizedBox(
                    width: W * 0.09,
                    height: 35,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        controller.removewednesday(x);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  ListView thursdaydailspecialItemNameBuilder(int index) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.thursdaydailySpecialItemList.length,
      itemBuilder: (context, x) {
        controller.thursdaydailySpecialItemList[x]["sizeController"] != null
            ? controller
            .thursdaydailySpecialItemList[x]["sizeController"].text =
            controller.thursdaydailySpecialItemList[x]["quantity"]
                .toString()
            : controller.thursdaydailySpecialItemList[x]["sizeController"] =
            TextEditingController(
                text: controller.thursdaydailySpecialItemList[x]["quantity"]
                    .toString());
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: W * 0.26,
                  child: const Text(
                    "Item Name",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                controller.thursdaydailySpecialItemList[x]['index'] == "Drinks"
                    ? SizedBox(
                  width: W * 0.3,
                  child: const Text(
                    "Size",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                    : SizedBox(
                  width: W * 0.26,
                  child: const Text(
                    "Quantity",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: W * 0.2,
                  child: const Text(
                    "Price",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: W * 0.2,
                  child: const Text(
                    "Discount",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //*Food Names show Here
                SizedBox(
                  width: W * 0.22,
                  child: Text(
                    controller.thursdaydailySpecialItemList[x]["name"]
                        .toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                //* increment decrement here
                Flexible(
                  child: SizedBox(
                    width: W * 0.27,
                    child: Row(
                      children: [
                        controller.thursdaydailySpecialItemList[x]['index'] ==
                            "Foods"
                            ? Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                //*decrement Button
                                controller
                                    .thursdaydailySpecialdecrement(x);
                              },
                              icon: const Image(
                                image: AssetImage(
                                    "assets/icons/Group 8197.png"),
                              ),
                            ),
                            Text(
                              controller.thursdaydailySpecialItemList[x]
                              ["quantity"]
                                  .toString(),
                              style: const TextStyle(
                                  overflow: TextOverflow.clip,
                                  fontSize: 16),
                            ),
                            IconButton(
                              onPressed: () {
                                //*increment Button
                                controller
                                    .thursdaydailySpecialincrement(x);
                              },
                              icon: const Image(
                                image: AssetImage(
                                    "assets/icons/Group 8192@2x.png"),
                              ),
                            ),
                          ],
                        )
                            : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: SizedBox(
                                width:
                                MediaQuery.of(context).size.width / 5,
                                height:
                                MediaQuery.of(context).size.height /
                                    28,
                                child: Material(
                                  elevation: 3,
                                  borderRadius: BorderRadius.circular(45),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: TextFormField(
                                          controller: controller
                                              .thursdaydailySpecialItemList[
                                          x]["sizeController"],
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return 'size';
                                            }
                                            return null;
                                          },
                                          onTap: () => controller
                                              .dailySpecialPrice
                                              .clear(),
                                          obscureText: false,
                                          keyboardType:
                                          TextInputType.number,
                                          onChanged: (val) {
                                            controller
                                                .thursdaydailySpecialItemList[
                                            x]["quantity"] = val;
                                          },
                                          decoration: InputDecoration(
                                            hintStyle: const TextStyle(
                                                color: Colors.grey),
                                            contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                8.0, 2.0, 2.0, 2.0),
                                            filled: false,
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.all(2.0),
                                          child: DropdownButton(
                                            underline: Container(),
                                            isExpanded: true,
                                            hint: const Text(""),
                                            value: controller
                                                .thursdaydailySpecialItemList[
                                            x]["sizeIcon"]
                                                .toString(),
                                            items: controller
                                                .sizeDropdownList
                                                .map((String items) {
                                              return DropdownMenuItem(
                                                  value: items,
                                                  child: Text(
                                                    items,
                                                    maxLines: 1,
                                                    style:
                                                    const TextStyle(
                                                        fontSize: 10),
                                                  ));
                                            }).toList(),
                                            onChanged:
                                                (String? newValue) {
                                              controller
                                                  .thursdaydailySpecialItemList[x]
                                              ["sizeIcon"] = newValue;
                                              controller.update();
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),

                        // SizedBox(
                        //     width: W * 0.22,
                        //     height: H * 0.034,
                        //     child: Material(
                        //       elevation: 3,
                        //       borderRadius: BorderRadius.circular(45),
                        //       child: TextFormField(
                        //         onTap: () =>
                        //             controller.dailySpecialPrice.clear(),
                        //         obscureText: false,
                        //         keyboardType: TextInputType.number,
                        //         onChanged: (val) {
                        //           controller.sundaydailySpecialItemList[x]
                        //               ["quantity"] = val;
                        //         },
                        //         decoration: InputDecoration(
                        //           // hintText: "Enter Discount",
                        //           hintStyle:
                        //               const TextStyle(color: Colors.grey),
                        //           contentPadding: const EdgeInsets.fromLTRB(
                        //               8.0, 2.0, 2.0, 2.0),
                        //           filled: false,
                        //           fillColor: Colors.white,
                        //           border: OutlineInputBorder(
                        //             borderSide: BorderSide.none,
                        //             borderRadius: BorderRadius.circular(10),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                      ],
                    ),
                  ),
                ),

                PriceField(
                  width: MediaQuery.of(context).size.width / 5,
                  height: MediaQuery.of(context).size.height / 28,
                  textEditingController: controller
                      .thursdaydailySpecialItemList[x]['pricecontroller'],
                  onTap: () {
                    controller.thursdaydailySpecialItemList[x]['controller']
                        .clear();
                  },
                  onChanged: (val) {
                    controller.thursdaydailySpecialItemList[x]['discount'] = "";
                    controller.thursdaydailySpecialItemList[x]['price'] = val;
                  },
                  keyboardType: TextInputType.number,
                ),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width / 5,
                //   height: MediaQuery.of(context).size.height / 24,
                //   child: CustomTextFieldWidget(
                //     textEditingController: controller.dailySpecialPrice,
                //     onChanged: (val) {
                //       controller.thursdaydailySpecialItemList[x]['price'] = val;
                //     },
                //     keyboardType: TextInputType.number,
                //   ),
                // ),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 5,
                    height: MediaQuery.of(context).size.height / 28,
                    child: Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(45),
                      child: Row(
                        children: [
                          Flexible(
                            child: TextFormField(
                              controller:
                              controller.thursdaydailySpecialItemList[x]
                              ['controller'],
                              onTap: () => controller
                                  .thursdaydailySpecialItemList[x]
                              ['pricecontroller']
                                  .clear(),
                              obscureText: false,
                              keyboardType: TextInputType.number,
                              onChanged: (val) {
                                controller.thursdaydailySpecialItemList[x]
                                ['price'] = "";
                                controller.thursdaydailySpecialItemList[x]
                                ['discount'] = val;
                              },
                              decoration: InputDecoration(
                                // hintText: "Enter Discount",
                                hintStyle: const TextStyle(color: Colors.grey),
                                contentPadding: const EdgeInsets.fromLTRB(
                                    8.0, 2.0, 2.0, 2.0),
                                filled: false,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton(
                                underline: Container(),
                                isExpanded: true,
                                hint: const Text(""),
                                value: "%",
                                items: controller.drinkDiscountDropdown
                                    .map((String items) {
                                  return DropdownMenuItem(
                                      value: items, child: Text(items));
                                }).toList(),
                                onChanged: (String? newValue) {
                                  controller.thursdaydailySpecialItemList[x]
                                  ['discountIcon'] = newValue;
                                  // controller.foodList[index].dropDown[0] =
                                  //     newValue!;
                                  // controller.foodList[index].dropDown[1] =
                                  //     newValue;
                                  controller.update();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: W * 0.25,
                  child: const Text(
                    "From",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: W * 0.2,
                  child: const Text(
                    "To",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: W * 0.25,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // IconButton(
                //   onPressed: () {
                //     controller.removethursday(x);
                //   },
                //   icon: const Icon(
                //     Icons.delete,
                //     color: Colors.red,
                //     size: 30,
                //   ),
                // ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45),
                  ),
                  elevation: 5,
                  child: SizedBox(
                    height: H * 0.067,
                    width: W * 0.29,
                    child: DropdownButtonFormField<String>(
                      // validator: (value) {
                      //   if (value == null || value.trim().isEmpty) {
                      //     return 'select';
                      //   }
                      //   return null;
                      // },
                      elevation: 15,
                      decoration: const InputDecoration(
                        enabled: false,
                        contentPadding:
                        EdgeInsets.fromLTRB(16.0, 10, 2.0, 12.0),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(45)),
                        ),
                      ),
                      isExpanded: true,
                      value: controller.thursdaydailySpecialItemList[x]
                      ?['fromTime'] ??
                          controller.timesList.last,
                      hint: Text(
                        controller.thursdaydailySpecialItemList[x]?['fromTime'],
                        style:
                        const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: controller.timesList
                          .map((fromTime) => DropdownMenuItem(
                        value: fromTime,
                        child: Text(
                          fromTime,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ))
                          .toList(),
                      onChanged: (time) {
                        controller.dailySpecialfromtime = time!;
                        controller.thursdaydailySpecialItemList[x]
                        ?['fromTime'] = time;
                        controller.update();
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
                    height: H * 0.067,
                    width: W * 0.29,
                    child: DropdownButtonFormField<String>(
                      // validator: (value) {
                      //   if (value == null || value.trim().isEmpty) {
                      //     return 'select';
                      //   }
                      //   return null;
                      // },
                      elevation: 15,
                      decoration: const InputDecoration(
                        enabled: false,
                        contentPadding:
                        EdgeInsets.fromLTRB(16.0, 10.0, 2.0, 12.0),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(45)),
                        ),
                      ),
                      isExpanded: true,
                      value: controller.thursdaydailySpecialItemList[x]
                      ?['toTime'] ??
                          controller.timesList.last,
                      hint: Text(
                        controller.thursdaydailySpecialItemList[x]?['toTime'],
                        style:
                        const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: controller.timesList
                          .map((toTime) => DropdownMenuItem(
                        value: toTime,
                        child: Text(
                          toTime,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ))
                          .toList(),
                      onChanged: (time) {
                        controller.dailySpecialtotime = time!;
                        controller.thursdaydailySpecialItemList[x]
                        ?['toTime'] = time;
                        controller.update();
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: W * 0.12,
                ),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(90),
                  ),
                  child: SizedBox(
                    width: W * 0.09,
                    height: 35,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        controller.removethursday(x);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  ListView fridaydailspecialItemNameBuilder(int index) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.fridaydailySpecialItemList.length,
      itemBuilder: (context, x) {
        controller.fridaydailySpecialItemList[x]["sizeController"] != null
            ? controller.fridaydailySpecialItemList[x]["sizeController"].text =
            controller.fridaydailySpecialItemList[x]["quantity"].toString()
            : controller.fridaydailySpecialItemList[x]["sizeController"] =
            TextEditingController(
                text: controller.fridaydailySpecialItemList[x]["quantity"]
                    .toString());
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: W * 0.26,
                  child: const Text(
                    "Item Name",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                controller.fridaydailySpecialItemList[x]['index'] == "Drinks"
                    ? SizedBox(
                  width: W * 0.3,
                  child: const Text(
                    "Size",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                    : SizedBox(
                  width: W * 0.26,
                  child: const Text(
                    "Quantity",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: W * 0.2,
                  child: const Text(
                    "Price",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: W * 0.2,
                  child: const Text(
                    "Discount",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //*Food Names show Here
                SizedBox(
                  width: W * 0.22,
                  child: Text(
                    controller.fridaydailySpecialItemList[x]["name"].toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                //* increment decrement here
                Flexible(
                  child: SizedBox(
                    width: W * 0.27,
                    child: Row(
                      children: [
                        controller.fridaydailySpecialItemList[x]['index'] ==
                            "Foods"
                            ? Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                //*decrement Button
                                controller.fridaydailySpecialdecrement(x);
                              },
                              icon: const Image(
                                image: AssetImage(
                                    "assets/icons/Group 8197.png"),
                              ),
                            ),
                            Text(
                              controller.fridaydailySpecialItemList[x]
                              ["quantity"]
                                  .toString(),
                              style: const TextStyle(
                                  overflow: TextOverflow.clip,
                                  fontSize: 16),
                            ),
                            IconButton(
                              onPressed: () {
                                //*increment Button
                                controller.fridaydailySpecialincrement(x);
                              },
                              icon: const Image(
                                image: AssetImage(
                                    "assets/icons/Group 8192@2x.png"),
                              ),
                            ),
                          ],
                        )
                            : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: SizedBox(
                                width:
                                MediaQuery.of(context).size.width / 5,
                                height:
                                MediaQuery.of(context).size.height /
                                    28,
                                child: Material(
                                  elevation: 3,
                                  borderRadius: BorderRadius.circular(45),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: TextFormField(
                                          controller: controller
                                              .fridaydailySpecialItemList[x]
                                          [
                                          "sizeController"] !=
                                              null
                                              ? controller.fridaydailySpecialItemList[
                                          x]["sizeController"]
                                          as TextEditingController
                                              : TextEditingController(
                                              text: controller
                                                  .fridaydailySpecialItemList[
                                              x]["quantity"]),
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return 'size';
                                            }
                                            return null;
                                          },
                                          onTap: () => controller
                                              .dailySpecialPrice
                                              .clear(),
                                          obscureText: false,
                                          keyboardType:
                                          TextInputType.number,
                                          onChanged: (val) {
                                            controller
                                                .fridaydailySpecialItemList[
                                            x]["quantity"] = val;
                                          },
                                          decoration: InputDecoration(
                                            hintStyle: const TextStyle(
                                                color: Colors.grey),
                                            contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                8.0, 2.0, 2.0, 2.0),
                                            filled: false,
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.all(2.0),
                                          child: DropdownButton(
                                            underline: Container(),
                                            isExpanded: true,
                                            hint: const Text(""),
                                            value: controller
                                                .fridaydailySpecialItemList[
                                            x]["sizeIcon"]
                                                .toString(),
                                            items: controller
                                                .sizeDropdownList
                                                .map((String items) {
                                              return DropdownMenuItem(
                                                  value: items,
                                                  child: Text(
                                                    items,
                                                    maxLines: 1,
                                                    style:
                                                    const TextStyle(
                                                        fontSize: 10),
                                                  ));
                                            }).toList(),
                                            onChanged:
                                                (String? newValue) {
                                              controller
                                                  .fridaydailySpecialItemList[x]
                                              ["sizeIcon"] = newValue;
                                              controller.update();
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        //SizedBox(
                        //   width: W * 0.22,
                        //   height: H * 0.034,
                        //   child: Material(
                        //     elevation: 3,
                        //     borderRadius: BorderRadius.circular(45),
                        //     child: TextFormField(
                        //       onTap: () =>
                        //           controller.dailySpecialPrice.clear(),
                        //       obscureText: false,
                        //       keyboardType: TextInputType.number,
                        //       onChanged: (val) {
                        //         controller.sundaydailySpecialItemList[x]
                        //             ["quantity"] = val;
                        //       },
                        //       decoration: InputDecoration(
                        //         // hintText: "Enter Discount",
                        //         hintStyle:
                        //             const TextStyle(color: Colors.grey),
                        //         contentPadding: const EdgeInsets.fromLTRB(
                        //             8.0, 2.0, 2.0, 2.0),
                        //         filled: false,
                        //         fillColor: Colors.white,
                        //         border: OutlineInputBorder(
                        //           borderSide: BorderSide.none,
                        //           borderRadius: BorderRadius.circular(10),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),

                PriceField(
                  width: MediaQuery.of(context).size.width / 5,
                  height: MediaQuery.of(context).size.height / 28,
                  textEditingController: controller
                      .fridaydailySpecialItemList[x]['pricecontroller'],
                  onTap: () {
                    controller.fridaydailySpecialItemList[x]['controller']
                        .clear();
                  },
                  onChanged: (val) {
                    controller.fridaydailySpecialItemList[x]['price'] = val;
                    controller.fridaydailySpecialItemList[x]['discount'] = "";
                  },
                  keyboardType: TextInputType.number,
                ),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width / 5,
                //   height: MediaQuery.of(context).size.height / 24,
                //   child: CustomTextFieldWidget(
                //     textEditingController: controller.dailySpecialPrice,
                //     onChanged: (val) {
                //       controller.fridaydailySpecialItemList[x]['price'] = val;
                //     },
                //     keyboardType: TextInputType.number,
                //   ),
                // ),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 5,
                    height: MediaQuery.of(context).size.height / 28,
                    child: Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(45),
                      child: Row(
                        children: [
                          Flexible(
                            child: TextFormField(
                              controller: controller
                                  .fridaydailySpecialItemList[x]['controller'],
                              onTap: () => controller
                                  .fridaydailySpecialItemList[x]
                              ['pricecontroller']
                                  .clear(),
                              obscureText: false,
                              keyboardType: TextInputType.number,
                              onChanged: (val) {
                                controller.fridaydailySpecialItemList[x]
                                ['price'] = "";
                                controller.fridaydailySpecialItemList[x]
                                ['discount'] = val;
                              },
                              decoration: InputDecoration(
                                // hintText: "Enter Discount",
                                hintStyle: const TextStyle(color: Colors.grey),
                                contentPadding: const EdgeInsets.fromLTRB(
                                    8.0, 2.0, 2.0, 2.0),
                                filled: false,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton(
                                underline: Container(),
                                isExpanded: true,
                                hint: const Text(""),
                                value: "%",
                                items: controller.drinkDiscountDropdown
                                    .map((String items) {
                                  return DropdownMenuItem(
                                      value: items, child: Text(items));
                                }).toList(),
                                onChanged: (String? newValue) {
                                  controller.fridaydailySpecialItemList[x]
                                  ['discountIcon'] = newValue;
                                  controller.update();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: W * 0.25,
                  child: const Text(
                    "From",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: W * 0.2,
                  child: const Text(
                    "To",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: W * 0.25,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // IconButton(
                //   onPressed: () {
                //     controller.removefriday(x);
                //   },
                //   icon: const Icon(
                //     Icons.delete,
                //     color: Colors.red,
                //     size: 30,
                //   ),
                // ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45),
                  ),
                  elevation: 5,
                  child: SizedBox(
                    height: H * 0.067,
                    width: W * 0.29,
                    child: DropdownButtonFormField<String>(
                      // validator: (value) {
                      //   if (value == null || value.trim().isEmpty) {
                      //     return 'select';
                      //   }
                      //   return null;
                      // },
                      elevation: 15,
                      decoration: const InputDecoration(
                        enabled: false,
                        contentPadding:
                        EdgeInsets.fromLTRB(16.0, 10, 2.0, 12.0),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(45)),
                        ),
                      ),
                      isExpanded: true,
                      value: controller.fridaydailySpecialItemList[x]
                      ?['fromTime'] ??
                          controller.timesList.last,
                      hint: Text(
                        controller.fridaydailySpecialItemList[x]?['fromTime'],
                        style:
                        const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: controller.timesList
                          .map((fromTime) => DropdownMenuItem(
                        value: fromTime,
                        child: Text(
                          fromTime,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ))
                          .toList(),
                      onChanged: (time) {
                        controller.dailySpecialfromtime = time!;
                        controller.fridaydailySpecialItemList[x]
                        ?['fromTime'] = time;
                        controller.update();
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
                    height: H * 0.067,
                    width: W * 0.29,
                    child: DropdownButtonFormField<String>(
                      // validator: (value) {
                      //   if (value == null || value.trim().isEmpty) {
                      //     return 'select';
                      //   }
                      //   return null;
                      // },
                      elevation: 15,
                      decoration: const InputDecoration(
                        enabled: false,
                        contentPadding:
                        EdgeInsets.fromLTRB(16.0, 10.0, 2.0, 12.0),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(45)),
                        ),
                      ),
                      isExpanded: true,
                      value: controller.fridaydailySpecialItemList[x]
                      ?['toTime'] ??
                          controller.timesList.last,
                      hint: Text(
                        controller.fridaydailySpecialItemList[x]?['toTime'],
                        style:
                        const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: controller.timesList
                          .map((toTime) => DropdownMenuItem(
                        value: toTime,
                        child: Text(
                          toTime,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ))
                          .toList(),
                      onChanged: (time) {
                        controller.dailySpecialtotime = time!;
                        controller.fridaydailySpecialItemList[x]
                        ?['toTime'] = time;
                        controller.update();
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: W * 0.12,
                ),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(90),
                  ),
                  child: SizedBox(
                    width: W * 0.09,
                    height: 35,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        controller.removefriday(x);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  ListView saturdaydailspecialItemNameBuilder(int index) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.saturdaydailySpecialItemList.length,
      itemBuilder: (context, x) {
        controller.saturdaydailySpecialItemList[x]["sizeController"] != null
            ? controller
            .saturdaydailySpecialItemList[x]["sizeController"].text =
            controller.saturdaydailySpecialItemList[x]["quantity"]
                .toString()
            : controller.saturdaydailySpecialItemList[x]["sizeController"] =
            TextEditingController(
                text: controller.saturdaydailySpecialItemList[x]["quantity"]
                    .toString());
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: W * 0.26,
                  child: const Text(
                    "Item Name",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                controller.saturdaydailySpecialItemList[x]['index'] == "Drinks"
                    ? SizedBox(
                  width: W * 0.3,
                  child: const Text(
                    "Size",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                    : SizedBox(
                  width: W * 0.26,
                  child: const Text(
                    "Quantity",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: W * 0.2,
                  child: const Text(
                    "Price",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: W * 0.2,
                  child: const Text(
                    "Discount",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //*Food Names show Here
                SizedBox(
                  width: W * 0.22,
                  child: Text(
                    controller.saturdaydailySpecialItemList[x]["name"]
                        .toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                //* increment decrement here
                Flexible(
                  child: SizedBox(
                    width: W * 0.27,
                    child: Row(
                      children: [
                        controller.saturdaydailySpecialItemList[x]['index'] ==
                            "Foods"
                            ? Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                //*decrement Button
                                controller
                                    .saturdaydailySpecialdecrement(x);
                              },
                              icon: const Image(
                                image: AssetImage(
                                    "assets/icons/Group 8197.png"),
                              ),
                            ),
                            Text(
                              controller.saturdaydailySpecialItemList[x]
                              ["quantity"]
                                  .toString(),
                              style: const TextStyle(
                                  overflow: TextOverflow.clip,
                                  fontSize: 16),
                            ),
                            IconButton(
                              onPressed: () {
                                //*increment Button
                                controller
                                    .saturdaydailySpecialincrement(x);
                              },
                              icon: const Image(
                                image: AssetImage(
                                    "assets/icons/Group 8192@2x.png"),
                              ),
                            ),
                          ],
                        )
                            : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: SizedBox(
                                width:
                                MediaQuery.of(context).size.width / 5,
                                height:
                                MediaQuery.of(context).size.height /
                                    28,
                                child: Material(
                                  elevation: 3,
                                  borderRadius: BorderRadius.circular(45),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: TextFormField(
                                          controller: controller
                                              .saturdaydailySpecialItemList[
                                          x]["sizeController"],
                                          validator: (value) {
                                            if (value == null ||
                                                value.trim().isEmpty) {
                                              return 'size';
                                            }
                                            return null;
                                          },
                                          onTap: () => controller
                                              .dailySpecialPrice
                                              .clear(),
                                          obscureText: false,
                                          keyboardType:
                                          TextInputType.number,
                                          onChanged: (val) {
                                            controller
                                                .saturdaydailySpecialItemList[
                                            x]["quantity"] = val;
                                          },
                                          decoration: InputDecoration(
                                            hintStyle: const TextStyle(
                                                color: Colors.grey),
                                            contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                8.0, 2.0, 2.0, 2.0),
                                            filled: false,
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                              BorderRadius.circular(
                                                  10),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.all(2.0),
                                          child: DropdownButton(
                                            underline: Container(),
                                            isExpanded: true,
                                            hint: const Text(""),
                                            value: controller
                                                .saturdaydailySpecialItemList[
                                            x]["sizeIcon"]
                                                .toString(),
                                            items: controller
                                                .sizeDropdownList
                                                .map((String items) {
                                              return DropdownMenuItem(
                                                  value: items,
                                                  child: Text(
                                                    items,
                                                    maxLines: 1,
                                                    style:
                                                    const TextStyle(
                                                        fontSize: 10),
                                                  ));
                                            }).toList(),
                                            onChanged:
                                                (String? newValue) {
                                              controller
                                                  .saturdaydailySpecialItemList[x]
                                              ["sizeIcon"] = newValue;
                                              controller.update();
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),

                        //  SizedBox(
                        //     width: W * 0.22,
                        //     height: H * 0.034,
                        //     child: Material(
                        //       elevation: 3,
                        //       borderRadius: BorderRadius.circular(45),
                        //       child: TextFormField(
                        //         onTap: () =>
                        //             controller.dailySpecialPrice.clear(),
                        //         obscureText: false,
                        //         keyboardType: TextInputType.number,
                        //         onChanged: (val) {
                        //           controller.sundaydailySpecialItemList[x]
                        //               ["quantity"] = val;
                        //         },
                        //         decoration: InputDecoration(
                        //           // hintText: "Enter Discount",
                        //           hintStyle:
                        //               const TextStyle(color: Colors.grey),
                        //           contentPadding: const EdgeInsets.fromLTRB(
                        //               8.0, 2.0, 2.0, 2.0),
                        //           filled: false,
                        //           fillColor: Colors.white,
                        //           border: OutlineInputBorder(
                        //             borderSide: BorderSide.none,
                        //             borderRadius: BorderRadius.circular(10),
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                      ],
                    ),
                  ),
                ),
                PriceField(
                  width: MediaQuery.of(context).size.width / 5,
                  height: MediaQuery.of(context).size.height / 28,
                  textEditingController: controller
                      .saturdaydailySpecialItemList[x]['pricecontroller'],
                  onTap: () {
                    controller.saturdaydailySpecialItemList[x]['controller']
                        .clear();
                  },
                  onChanged: (val) {
                    controller.saturdaydailySpecialItemList[x]['price'] = val;
                    controller.saturdaydailySpecialItemList[x]['discount'] = '';
                  },
                  keyboardType: TextInputType.number,
                ),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width / 5,
                //   height: MediaQuery.of(context).size.height / 24,
                //   child: CustomTextFieldWidget(
                //     textEditingController: controller.dailySpecialPrice,
                //     onChanged: (val) {
                //       controller.saturdaydailySpecialItemList[x]['price'] = val;
                //     },
                //     keyboardType: TextInputType.number,
                //   ),
                // ),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 5,
                    height: MediaQuery.of(context).size.height / 28,
                    child: Material(
                      elevation: 3,
                      borderRadius: BorderRadius.circular(45),
                      child: Row(
                        children: [
                          Flexible(
                            child: TextFormField(
                              controller:
                              controller.saturdaydailySpecialItemList[x]
                              ['controller'],
                              onTap: () => controller
                                  .saturdaydailySpecialItemList[x]
                              ['pricecontroller']
                                  .clear(),
                              obscureText: false,
                              keyboardType: TextInputType.number,
                              onChanged: (val) {
                                controller.saturdaydailySpecialItemList[x]
                                ['price'] = '';
                                controller.saturdaydailySpecialItemList[x]
                                ['discount'] = val;
                              },
                              decoration: InputDecoration(
                                // hintText: "Enter Discount",
                                hintStyle: const TextStyle(color: Colors.grey),
                                contentPadding: const EdgeInsets.fromLTRB(
                                    8.0, 2.0, 2.0, 2.0),
                                filled: false,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton(
                                underline: Container(),
                                isExpanded: true,
                                hint: const Text(""),
                                value: "%",
                                items: controller.drinkDiscountDropdown
                                    .map((String items) {
                                  return DropdownMenuItem(
                                      value: items, child: Text(items));
                                }).toList(),
                                onChanged: (String? newValue) {
                                  controller.saturdaydailySpecialItemList[x]
                                  ['discountIcon'] = newValue;
                                  // controller.foodList[index].dropDown[0] =
                                  //     newValue!;
                                  // controller.foodList[index].dropDown[1] =
                                  //     newValue;
                                  controller.update();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: W * 0.25,
                  child: const Text(
                    "From",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: W * 0.2,
                  child: const Text(
                    "To",
                    style: TextStyle(
                      fontSize: 16,
                      color: blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: W * 0.25,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(45),
                  ),
                  elevation: 5,
                  child: SizedBox(
                    height: H * 0.067,
                    width: W * 0.29,
                    child: DropdownButtonFormField<String>(
                      // validator: (value) {
                      //   if (value == null || value.trim().isEmpty) {
                      //     return 'select';
                      //   }
                      //   return null;
                      // },
                      elevation: 15,
                      decoration: const InputDecoration(
                        enabled: false,
                        contentPadding:
                        EdgeInsets.fromLTRB(16.0, 10, 2.0, 12.0),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(45)),
                        ),
                      ),
                      isExpanded: true,
                      value: controller.saturdaydailySpecialItemList[x]
                      ?['fromTime'] ??
                          controller.timesList.last,
                      hint: Text(
                        controller.saturdaydailySpecialItemList[x]?['fromTime'],
                        style:
                        const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: controller.timesList
                          .map((fromTime) => DropdownMenuItem(
                        value: fromTime,
                        child: Text(
                          fromTime,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ))
                          .toList(),
                      onChanged: (time) {
                        controller.dailySpecialfromtime = time!;
                        controller.saturdaydailySpecialItemList[x]
                        ?['fromTime'] = time;
                        controller.update();
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
                    height: H * 0.067,
                    width: W * 0.29,
                    child: DropdownButtonFormField<String>(
                      // validator: (value) {
                      //   if (value == null || value.trim().isEmpty) {
                      //     return 'select';
                      //   }
                      //   return null;
                      // },
                      elevation: 15,
                      decoration: const InputDecoration(
                        enabled: false,
                        contentPadding:
                        EdgeInsets.fromLTRB(16.0, 10.0, 2.0, 12.0),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(45)),
                        ),
                      ),
                      isExpanded: true,
                      value: controller.saturdaydailySpecialItemList[x]
                      ?['toTime'] ??
                          controller.timesList.last,
                      hint: Text(
                        controller.saturdaydailySpecialItemList[x]?['toTime'],
                        style:
                        const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: controller.timesList
                          .map((toTime) => DropdownMenuItem(
                        value: toTime,
                        child: Text(
                          toTime,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ))
                          .toList(),
                      onChanged: (time) {
                        controller.dailySpecialtotime = time!;
                        controller.saturdaydailySpecialItemList[x]
                        ?['toTime'] = time;
                        controller.update();
                      },
                    ),
                  ),
                ),
                // IconButton(
                //   onPressed: () {
                //     controller.removesaturday(x);
                //   },
                //   icon: const Icon(
                //     Icons.delete,
                //     color: Colors.red,
                //     size: 30,
                //   ),
                // ),
                SizedBox(
                  width: W * 0.12,
                ),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(90),
                  ),
                  child: SizedBox(
                    width: W * 0.09,
                    height: 35,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        controller.removesaturday(x);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> addNewItemDialog(
      BuildContext context,
      String title,
      VoidCallback onConfrim,
      Widget widget,
      Widget addButton,
      ) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SizedBox(
            height: H * 0.62,
            width: W * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0, right: 16.0),
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/icons/Group 2062.png"),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  height: H * 0.01,
                ),
                Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  height: H * 0.04,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Center(child: widget),
                ),
                SizedBox(
                  height: H * 0.02,
                ),
                Center(
                  child: addButton,
                ),
                SizedBox(
                  height: H * 0.01,
                ),
                Center(
                  child: TextButton(
                      onPressed: onConfrim,
                      child: const Text(
                        "+ Add Manually",
                        style: TextStyle(color: primary),
                      )),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  addSundayManually(
      BuildContext context,
      String title,
      Widget onConfrim,
      TextEditingController textController,
      ) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SizedBox(
            height: H * 0.56,
            width: W * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0, right: 16.0),
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/icons/Group 2062.png"),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
                SizedBox(
                  height: H * 0.01,
                ),
                Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  height: H * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(45),
                    ),
                    elevation: 5,
                    child: SizedBox(
                      height: H * 0.07,
                      width: W * 0.8,
                      child: DropdownButtonFormField<String>(
                        elevation: 15,
                        decoration: const InputDecoration(
                          enabled: false,
                          contentPadding:
                          EdgeInsets.fromLTRB(16.0, 30.0, 18.0, 12.0),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(45)),
                          ),
                        ),
                        isExpanded: true,
                        hint: const Text(
                          "Select Type",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: controller.dailyDropDown
                            .map((foodOrDrink) => DropdownMenuItem(
                          value: foodOrDrink,
                          child: Text(
                            foodOrDrink,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ))
                            .toList(),
                        onChanged: (daily) {
                          controller.sundaydailySpecialType = daily!;
                          controller.update();
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: H * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: CustomTextFieldWidget(
                    hintText: "Type Name",
                    textEditingController: textController,
                  ),
                ),
                SizedBox(
                  height: H * 0.02,
                ),
                Center(child: onConfrim)
              ],
            ),
          ),
        );
      },
    );
  }

  addMondayManually(
      BuildContext context,
      String title,
      Widget onConfrim,
      TextEditingController textController,
      ) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SizedBox(
            height: H * 0.56,
            width: W * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0, right: 16.0),
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/icons/Group 2062.png"),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
                SizedBox(
                  height: H * 0.01,
                ),
                Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  height: H * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(45),
                    ),
                    elevation: 5,
                    child: SizedBox(
                      height: H * 0.07,
                      width: W * 0.8,
                      child: DropdownButtonFormField<String>(
                        elevation: 15,
                        decoration: const InputDecoration(
                          enabled: false,
                          contentPadding:
                          EdgeInsets.fromLTRB(16.0, 30.0, 18.0, 12.0),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(45)),
                          ),
                        ),
                        isExpanded: true,
                        hint: const Text(
                          "Select Type",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: controller.dailyDropDown
                            .map((foodOrDrink) => DropdownMenuItem(
                          value: foodOrDrink,
                          child: Text(
                            foodOrDrink,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ))
                            .toList(),
                        onChanged: (daily) {
                          controller.mondaydailySpecialType = daily!;
                          controller.update();
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: H * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: CustomTextFieldWidget(
                    hintText: "Type Name",
                    textEditingController: textController,
                  ),
                ),
                SizedBox(
                  height: H * 0.02,
                ),
                Center(child: onConfrim)
              ],
            ),
          ),
        );
      },
    );
  }

  addTuesdayManually(
      BuildContext context,
      String title,
      Widget onConfrim,
      TextEditingController textController,
      ) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SizedBox(
            height: H * 0.56,
            width: W * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0, right: 16.0),
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/icons/Group 2062.png"),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
                SizedBox(
                  height: H * 0.01,
                ),
                Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  height: H * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(45),
                    ),
                    elevation: 5,
                    child: SizedBox(
                      height: H * 0.07,
                      width: W * 0.8,
                      child: DropdownButtonFormField<String>(
                        elevation: 15,
                        decoration: const InputDecoration(
                          enabled: false,
                          contentPadding:
                          EdgeInsets.fromLTRB(16.0, 30.0, 18.0, 12.0),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(45)),
                          ),
                        ),
                        isExpanded: true,
                        hint: const Text(
                          "Select Type",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: controller.dailyDropDown
                            .map((foodOrDrink) => DropdownMenuItem(
                          value: foodOrDrink,
                          child: Text(
                            foodOrDrink,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ))
                            .toList(),
                        onChanged: (daily) {
                          controller.tuesdaydailySpecialType = daily!;
                          controller.update();
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: H * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: CustomTextFieldWidget(
                    hintText: "Type Name",
                    textEditingController: textController,
                  ),
                ),
                SizedBox(
                  height: H * 0.02,
                ),
                Center(child: onConfrim)
              ],
            ),
          ),
        );
      },
    );
  }

  addWednesdayManually(
      BuildContext context,
      String title,
      Widget onConfrim,
      TextEditingController textController,
      ) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SizedBox(
            height: H * 0.56,
            width: W * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0, right: 16.0),
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/icons/Group 2062.png"),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
                SizedBox(
                  height: H * 0.01,
                ),
                Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  height: H * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(45),
                    ),
                    elevation: 5,
                    child: SizedBox(
                      height: H * 0.07,
                      width: W * 0.8,
                      child: DropdownButtonFormField<String>(
                        elevation: 15,
                        decoration: const InputDecoration(
                          enabled: false,
                          contentPadding:
                          EdgeInsets.fromLTRB(16.0, 30.0, 18.0, 12.0),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(45)),
                          ),
                        ),
                        isExpanded: true,
                        hint: const Text(
                          "Select Type",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: controller.dailyDropDown
                            .map((foodOrDrink) => DropdownMenuItem(
                          value: foodOrDrink,
                          child: Text(
                            foodOrDrink,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ))
                            .toList(),
                        onChanged: (daily) {
                          controller.wednesdaydailySpecialType = daily!;
                          controller.update();
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: H * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: CustomTextFieldWidget(
                    hintText: "Type Name",
                    textEditingController: textController,
                  ),
                ),
                SizedBox(
                  height: H * 0.02,
                ),
                Center(child: onConfrim)
              ],
            ),
          ),
        );
      },
    );
  }

  addThursdayManually(
      BuildContext context,
      String title,
      Widget onConfrim,
      TextEditingController textController,
      ) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SizedBox(
            height: H * 0.56,
            width: W * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0, right: 16.0),
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/icons/Group 2062.png"),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
                SizedBox(
                  height: H * 0.01,
                ),
                Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  height: H * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(45),
                    ),
                    elevation: 5,
                    child: SizedBox(
                      height: H * 0.07,
                      width: W * 0.8,
                      child: DropdownButtonFormField<String>(
                        elevation: 15,
                        decoration: const InputDecoration(
                          enabled: false,
                          contentPadding:
                          EdgeInsets.fromLTRB(16.0, 30.0, 18.0, 12.0),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(45)),
                          ),
                        ),
                        isExpanded: true,
                        hint: const Text(
                          "Select Type",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: controller.dailyDropDown
                            .map((foodOrDrink) => DropdownMenuItem(
                          value: foodOrDrink,
                          child: Text(
                            foodOrDrink,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ))
                            .toList(),
                        onChanged: (daily) {
                          controller.thursdaydailySpecialType = daily!;
                          controller.update();
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: H * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: CustomTextFieldWidget(
                    hintText: "Type Name",
                    textEditingController: textController,
                  ),
                ),
                SizedBox(
                  height: H * 0.02,
                ),
                Center(child: onConfrim)
              ],
            ),
          ),
        );
      },
    );
  }

  addFridayManually(
      BuildContext context,
      String title,
      Widget onConfrim,
      TextEditingController textController,
      ) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SizedBox(
            height: H * 0.56,
            width: W * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0, right: 16.0),
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/icons/Group 2062.png"),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
                SizedBox(
                  height: H * 0.01,
                ),
                Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  height: H * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(45),
                    ),
                    elevation: 5,
                    child: SizedBox(
                      height: H * 0.07,
                      width: W * 0.8,
                      child: DropdownButtonFormField<String>(
                        elevation: 15,
                        decoration: const InputDecoration(
                          enabled: false,
                          contentPadding:
                          EdgeInsets.fromLTRB(16.0, 30.0, 18.0, 12.0),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(45)),
                          ),
                        ),
                        isExpanded: true,
                        hint: const Text(
                          "Select Type",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: controller.dailyDropDown
                            .map((foodOrDrink) => DropdownMenuItem(
                          value: foodOrDrink,
                          child: Text(
                            foodOrDrink,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ))
                            .toList(),
                        onChanged: (daily) {
                          controller.fridaydailySpecialType = daily!;
                          controller.update();
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: H * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: CustomTextFieldWidget(
                    hintText: "Type Name",
                    textEditingController: textController,
                  ),
                ),
                SizedBox(
                  height: H * 0.02,
                ),
                Center(child: onConfrim)
              ],
            ),
          ),
        );
      },
    );
  }

  addSaturdayManually(
      BuildContext context,
      String title,
      Widget onConfrim,
      TextEditingController textController,
      ) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SizedBox(
            height: H * 0.56,
            width: W * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0, right: 16.0),
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/icons/Group 2062.png"),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
                SizedBox(
                  height: H * 0.01,
                ),
                Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  height: H * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(45),
                    ),
                    elevation: 5,
                    child: SizedBox(
                      height: H * 0.07,
                      width: W * 0.8,
                      child: DropdownButtonFormField<String>(
                        elevation: 15,
                        decoration: const InputDecoration(
                          enabled: false,
                          contentPadding:
                          EdgeInsets.fromLTRB(16.0, 30.0, 18.0, 12.0),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(45)),
                          ),
                        ),
                        isExpanded: true,
                        hint: const Text(
                          "Select Type",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: controller.dailyDropDown
                            .map((foodOrDrink) => DropdownMenuItem(
                          value: foodOrDrink,
                          child: Text(
                            foodOrDrink,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ))
                            .toList(),
                        onChanged: (daily) {
                          controller.saturdaydailySpecialType = daily!;
                          controller.update();
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: H * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: CustomTextFieldWidget(
                    hintText: "Type Name",
                    textEditingController: textController,
                  ),
                ),
                SizedBox(
                  height: H * 0.02,
                ),
                Center(child: onConfrim)
              ],
            ),
          ),
        );
      },
    );
  }
}
