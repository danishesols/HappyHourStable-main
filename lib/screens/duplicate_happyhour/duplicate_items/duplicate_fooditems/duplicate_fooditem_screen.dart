import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/global_controller/global_general_controller.dart';
import 'package:happy_hour_app/global_widgets/price_field.dart';
import 'package:happy_hour_app/global_widgets/text_field.dart';
import 'package:happy_hour_app/screens/duplicate_happyhour/duplicate_happyhour_controller.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

import '../../../../core/colors.dart';
import '../../../../core/constants.dart';
import '../../../../global_widgets/main_button.dart';
import '../../../../routes/app_routes.dart';

class DuplicateFoodItemScreen extends GetView<DuplicateController> {
  const DuplicateFoodItemScreen({Key? key}) : super(key: key);

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
      body: GetBuilder<DuplicateController>(
        builder: (_) {
          return Padding(
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
                child: ListView(
                  children: [
                    SizedBox(
                      height: H * 0.009,
                    ),
                    const Text(
                      "Add Happy Hour Food Item",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: H * 0.02,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: W * 0.1, right: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: W * 0.25,
                            child: const Text(
                              "Item Name",
                              style: TextStyle(
                                fontSize: 16,
                                color: blackColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: W * 0.25,
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
                    SizedBox(
                      height: H * 0.02,
                    ),
                    ListView.builder(
                      itemCount: controller.foodList.length,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  child: IconButton(
                                    onPressed: () {
                                      controller.removeFood(index);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      size: 20,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                //*Food Names show Here
                                SizedBox(
                                  width: W * 0.2,
                                  child: Text(
                                    controller.foodList[index].name.toString(),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                                //* increment decrement here
                                Flexible(
                                  child: SizedBox(
                                    width: W * 0.27,
                                    child: Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            controller.fooddecrement(index);
                                          },
                                          icon: const Image(
                                            image: AssetImage(
                                                "assets/icons/Group 8197.png"),
                                          ),
                                        ),
                                        Text(
                                          controller.foodList[index].quantity
                                              .toString(),
                                          style: const TextStyle(
                                              overflow: TextOverflow.clip,
                                              fontSize: 16),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            controller.foodincrement(index);
                                          },
                                          icon: const Image(
                                            image: AssetImage(
                                                "assets/icons/Group 8192@2x.png"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                PriceField(
                                  width: W * 0.21,
                                  height: H * 0.036,
                                  onTap: () {
                                    controller.foodList[index]
                                            .discountController =
                                        TextEditingController();
                                    controller.foodList[index]
                                        .discountController?.text = "";
                                    controller.foodList[index].discount = 0;
                                    controller.updateFoodLists();
                                    controller.update();
                                  },
                                  validator: (val) {
                                    if (val != null && val.isEmpty) {
                                      if (controller.foodList[index]
                                              .discountController?.text !=
                                          '') return null;
                                      return 'Empty';
                                    } else if (double.tryParse(val!) != null) {
                                      return null;
                                    } else {
                                      return 'should be a valid number';
                                    }
                                  },
                                  textEditingController: controller
                                      .foodList[index].priceController,
                                  onChanged: (val) {
                                    if (double.tryParse(val) != null) {
                                      controller.foodList[index].price = val;
                                      controller.foodList[index].discount = 0;
                                      controller.updateFoodLists();
                                    } else {
                                      Get.find<GlobalGeneralController>()
                                          .errorSnackbar(
                                              title: "UnValid value",
                                              description: "Not a valid value");
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),

                                Column(
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
                                                      .foodList[index]
                                                      .discountController,
                                                  onTap: () {
                                                    controller.foodList[index]
                                                        .priceController
                                                        .clear();
                                                    controller.foodList[index]
                                                        .price = '';
                                                    controller
                                                        .updateFoodLists();
                                                  },
                                                  obscureText: false,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  onChanged: (val) {
                                                    controller.foodList[index]
                                                            .discount =
                                                        int.parse(val);
                                                    controller.foodList[index]
                                                        .price = '';
                                                    controller
                                                        .updateFoodLists();
                                                  },
                                                  decoration: InputDecoration(
                                                    // hintText: "Enter Discount",
                                                    // hintStyle: const TextStyle(
                                                    //     color: Colors.grey),
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
                                                      const EdgeInsets.all(8.0),
                                                  child: DropdownButton(
                                                    underline: Container(),
                                                    isExpanded: true,
                                                    //hint: const Text(""),
                                                    value: controller
                                                        .foodList[index]
                                                        .discountIcon,
                                                    items: controller
                                                        .drinkDiscountDropdown
                                                        .map((String items) {
                                                      return DropdownMenuItem(
                                                        value: items,
                                                        child: Text(
                                                          items,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 12),
                                                        ),
                                                      );
                                                    }).toList(),
                                                    onChanged:
                                                        (String? newValue) {
                                                      controller.foodList[index]
                                                              .discountIcon =
                                                          newValue!;
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
                              ],
                            ),
                            Obx(
                              () => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Checkbox(
                                      value: controller
                                          .foodList[index].earlyFood.value,
                                      onChanged: (v) async {
                                        if (controller
                                            .earlyDayTimeList.isNotEmpty) {
                                          controller.showEarlyTimeFood(index);
                                        } else {
                                          await Get.find<
                                                  GlobalGeneralController>()
                                              .infoSnackbar(
                                            title: 'No Early Hour Time',
                                            description:
                                                'Add at least one early Happy Hour time',
                                          );
                                          Get.toNamed(
                                            Routes.duplicateDayTimeScreen,
                                            arguments: controller.firestoreObj,
                                          );
                                        }
                                      },
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 16.0),
                                        child: Column(children: const [
                                          SizedBox(
                                            child: Text(
                                              "Early Happy Hour",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ]),
                                      ),
                                    ),
                                    Checkbox(
                                        value: controller
                                            .foodList[index].lateFood.value,
                                        onChanged: (v) async {
                                          if (controller
                                              .lateDaytimeList.isNotEmpty) {
                                            controller.showLateTimeFood(index);
                                          } else {
                                            await Get.find<
                                                    GlobalGeneralController>()
                                                .infoSnackbar(
                                              title: 'No Early Hour Time',
                                              description:
                                                  'Add at least one early Happy Hour time',
                                            );
                                            Get.toNamed(
                                              Routes.duplicateDayTimeScreen,
                                              arguments:
                                                  controller.firestoreObj,
                                            );
                                          }
                                        }),
                                    Flexible(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 16.0),
                                        child: Column(children: const [
                                          SizedBox(
                                            child: Text(
                                              "Late Happy Hour",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Obx(
                            //   () => Padding(
                            //     padding: const EdgeInsets.all(8.0),
                            //     child: Row(
                            //       mainAxisAlignment: MainAxisAlignment.end,
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         InkWell(
                            //           onTap: () =>
                            //               controller.showBothTimeDrink(index),
                            //           child: chipWidget(
                            //             controller.localdrinkList[index].time
                            //                 .toString(),
                            //             () =>
                            //                 controller.showBothTimeDrink(index),
                            //           ),
                            //         ),
                            //         SizedBox(
                            //           width: W * 0.02,
                            //         ),
                            //         controller.localdrinkList[index]
                            //                 .bothTimeDrink.isTrue
                            //             ? Flexible(
                            //                 child: Material(
                            //                   elevation: 2,
                            //                   borderRadius:
                            //                       BorderRadius.circular(16.0),
                            //                   child: Padding(
                            //                     padding:
                            //                         const EdgeInsets.all(12.0),
                            //                     child: Column(
                            //                       mainAxisAlignment:
                            //                           MainAxisAlignment.start,
                            //                       crossAxisAlignment:
                            //                           CrossAxisAlignment.start,
                            //                       children: [
                            //                         SizedBox(
                            //                           height: H * 0.01,
                            //                         ),
                            //                         GestureDetector(
                            //                           onTap: () {
                            //                             controller
                            //                                 .drinkBothTime(
                            //                                     index);
                            //                           },
                            //                           child: const Text(
                            //                             "Both Time",
                            //                             style: TextStyle(
                            //                                 fontSize: 12,
                            //                                 fontWeight:
                            //                                     FontWeight
                            //                                         .w600),
                            //                           ),
                            //                         ),
                            //                         SizedBox(
                            //                           height: H * 0.01,
                            //                         ),
                            //                         controller.hFromTime != null
                            //                             ? GestureDetector(
                            //                                 onTap: () {
                            //                                   controller
                            //                                       .drinkfirstTime(
                            //                                           index);
                            //                                 },
                            //                                 child: Text(
                            //                                   controller
                            //                                           .hFromTime
                            //                                           .toString() +
                            //                                       "- " +
                            //                                       controller
                            //                                           .hToTime
                            //                                           .toString(),
                            //                                   style: const TextStyle(
                            //                                       fontSize: 12,
                            //                                       fontWeight:
                            //                                           FontWeight
                            //                                               .w600),
                            //                                 ),
                            //                               )
                            //                             : const SizedBox(),
                            //                         SizedBox(
                            //                           height: H * 0.01,
                            //                         ),
                            //                         controller.hFromTime2 !=
                            //                                 null
                            //                             ? GestureDetector(
                            //                                 onTap: () {
                            //                                   controller
                            //                                       .drinkSecondTime(
                            //                                           index);
                            //                                 },
                            //                                 child: Text(
                            //                                   controller
                            //                                           .hFromTime2
                            //                                           .toString() +
                            //                                       "- " +
                            //                                       controller
                            //                                           .hToTime2
                            //                                           .toString(),
                            //                                   style: const TextStyle(
                            //                                       fontSize: 12,
                            //                                       fontWeight:
                            //                                           FontWeight
                            //                                               .w600),
                            //                                 ),
                            //                               )
                            //                             : const SizedBox(),
                            //                       ],
                            //                     ),
                            //                   ),
                            //                 ),
                            //               )
                            //             : SizedBox(
                            //                 width: W * 0.36,
                            //               ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                          ],
                        );
                      },
                    ),

                    //*Add Product to food list
                    Center(
                      child: SizedBox(
                        height: H * 0.05,
                        width: W * 0.4,
                        child: CustomElevatedButtonWidget(
                          onPressed: () {
                            Get.find<GlobalGeneralController>()
                                .addNewItemDialog(
                              context,
                              "Add new item",
                              () {
                                navigator?.pop(context);

                                addfoodManually(
                                  context,
                                  "Add Manually",
                                  CustomElevatedButtonWidget(
                                      horizontalPadding: 60,
                                      verticalPadding: 22,
                                      borderRadius: 35,
                                      fontSize: 24,
                                      textColor: blackColor,
                                      text: ("Add"),
                                      onPressed: () {
                                        if (controller
                                                .addfoodManuallyController.text
                                                .trim() !=
                                            "") {
                                          controller.addfoodmanually();
                                          Navigator.pop(context);
                                          controller.addfoodManuallyController
                                              .clear();
                                        }
                                      }),
                                  controller.addfoodManuallyController,
                                );
                              },
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(45),
                                ),
                                elevation: 5,
                                child: SizedBox(
                                  width: W * 0.7,
                                  height: H * 0.07,
                                  child: MultiSelectDialogField(
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
                                    items: controller.foodallList
                                        .map(
                                          (e) => MultiSelectItem(e, e.name),
                                        )
                                        .toList(),
                                    title: const Text("Food"),
                                    selectedColor: primary,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(35)),
                                    ),
                                    buttonText: const Text(
                                      "Select Items",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                      ),
                                    ),
                                    onConfirm:
                                        controller.addFoodFromDropDownList,
                                  ),
                                ),
                              ),
                              CustomElevatedButtonWidget(
                                  horizontalPadding: 60,
                                  verticalPadding: 20,
                                  borderRadius: 35,
                                  fontSize: 24,
                                  textColor: blackColor,
                                  text: ("Add"),
                                  onPressed: () {
                                    //controller.addFoodsList();
                                    Get.back();
                                    // Get.find<GlobalGeneralController>()
                                    //     .successSnackbar(
                                    //         title: "Added",
                                    //         description: "New Item Addded");
                                  }),
                            );
                          },
                          text: "Add new item",
                          textColor: blackColor,
                          horizontalPadding: 0,
                          verticalPadding: 0,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: H * 0.02,
                    ),
                    SizedBox(
                      height: H * 0.1,
                    ),
                  ],
                ),
              ),
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
              if (controller.foodList.isEmpty) {
                controller.updateFoodLists();
                controller.update();
                Get.back();
              } else {
                var a = controller.foodList.where((e) =>
                    e.name != "" &&
                    e.quantity != 0 &&
                    (e.price != "" || e.discount != 0 || e.discount.isNaN));
                if (a.isEmpty) {
                  Get.find<GlobalGeneralController>().errorSnackbar(
                      title: "Error",
                      description:
                          "Food Quantity and Price/Discount Is Required");
                }
                if (a.length == controller.foodList.length) {
                  controller.updateFoodLists();
                  controller.update();
                  Get.back();
                }
              }

              // Get.to(() => const DuplicateDrinksScreen(),
              //     binding: DuplicateDrinksBinding());
              // if (controller.foodList.isEmpty) {
              //   Get.toNamed(Routes.businessDrinksScreen);
              // } else {
              //   var a = controller.foodList.where((e) =>
              //       e.name != "" &&
              //       e.quantity != 0 &&
              //       (e.price != "" || e.discount != 0 || e.discount.isNaN));
              //   if (a.isEmpty) {
              //     Get.find<GlobalGeneralController>().errorSnackbar(
              //         title: "Error",
              //         description:
              //             "Food Quantity and Price/Discount Is Required");
              //   }
              //   if (a.length == controller.foodList.length) {
              //     Get.toNamed(Routes.businessDrinksScreen);
              //   }
              // }
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
  }
}

Future<dynamic> addfoodManually(
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
          height: H * 0.4,
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
                height: H * 0.04,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: CustomTextFieldWidget(
                  hintText: "Item Name",
                  textEditingController: textController,
                ),
              ),
              SizedBox(
                height: H * 0.04,
              ),
              Center(child: onConfrim)
            ],
          ),
        ),
      );
    },
  );
}

Chip chipWidget(String text, function) {
  return Chip(
    padding: const EdgeInsets.only(left: 8, right: 4, bottom: 4, top: 4),
    deleteIcon: const Icon(
      Icons.arrow_drop_down_sharp,
      color: blackColor,
    ),
    onDeleted: function,
    deleteIconColor: Colors.green,
    label: Text(
      text,
      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
    ),
    backgroundColor: whiteColor,
    elevation: 5,
  );
}
