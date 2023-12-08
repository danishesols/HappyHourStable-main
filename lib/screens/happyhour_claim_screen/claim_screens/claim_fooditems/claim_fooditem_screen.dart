import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/global_controller/global_general_controller.dart';
import 'package:happy_hour_app/global_widgets/price_field.dart';
import 'package:happy_hour_app/global_widgets/text_field.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

import '../../../../core/colors.dart';
import '../../../../core/constants.dart';
import '../../../../global_widgets/main_button.dart';
import '../claim_controller.dart';

class ClaimFoodItemScreen extends GetView<ClaimController> {
  const ClaimFoodItemScreen({Key? key}) : super(key: key);

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
      body: GetBuilder<ClaimController>(
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
                                    controller.update();
                                  },
                                  textEditingController: controller
                                      .foodList[index].priceController,
                                  onChanged: (val) {
                                    controller.foodList[index].price = val;
                                  },
                                  keyboardType: TextInputType.number,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                // SizedBox(
                                //   width: W * 0.21,
                                //   height: H * 0.044,
                                //   child: CustomTextFieldWidget(
                                //     onTap: () {
                                //       controller.foodList[index].discountController =
                                //           TextEditingController();
                                //       controller.foodList[index].discountController
                                //           ?.text = "";
                                //       controller.update();
                                //     },
                                //     textEditingController:
                                //         controller.foodList[index].priceController,
                                //     onChanged: (val) {
                                //       controller.foodList[index].price = val;
                                //     },
                                //     keyboardType: TextInputType.number,
                                //   ),
                                // ),

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
                                                  onTap: () => controller
                                                      .foodList[index]
                                                      .priceController
                                                      .clear(),
                                                  obscureText: false,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  onChanged: (val) {
                                                    controller.foodList[index]
                                                            .discount =
                                                        int.parse(val);
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
                                                            .foodList.isNotEmpty
                                                        ? controller
                                                            .foodList[index]
                                                            .dropDown[0]
                                                        : controller
                                                            .foodList[index]
                                                            .dropDown[1],
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
                                                              .dropDown[0] =
                                                          newValue!;
                                                      controller.foodList[index]
                                                              .dropDown[1] =
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
                                    )
                                  ],
                                ),

                                // SizedBox(
                                //   width: W * 0.21,
                                //   height: H * 0.045,
                                //   child: CustomTextFieldWidget(
                                //     onChanged: (val) {
                                //       controller.localFoodsShow[index]["fooddiscount"] =
                                //           val;
                                //     },
                                //     keyboardType: TextInputType.number,
                                //   ),
                                // ),
                              ],
                            ),
                            Obx(
                              () => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () =>
                                          controller.showBothTimeFood(index),
                                      child: chipWidget(
                                        controller.foodList[index].time,
                                        () =>
                                            controller.showBothTimeFood(index),
                                      ),
                                    ),
                                    SizedBox(
                                      width: W * 0.02,
                                    ),
                                    controller
                                            .foodList[index].bothTimeFood.isTrue
                                        ? Flexible(
                                            child: Material(
                                              elevation: 2,
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: H * 0.01,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        controller.foodBothTime(
                                                            index);
                                                      },
                                                      child: const Text(
                                                        "Both Time",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: H * 0.01,
                                                    ),
                                                    controller.hFromTime2 !=
                                                            null
                                                        ? GestureDetector(
                                                            onTap: () {
                                                              controller
                                                                  .foodfirstTime(
                                                                      index);
                                                            },
                                                            child: Text(
                                                              controller
                                                                      .hFromTime
                                                                      .toString() +
                                                                  "- " +
                                                                  controller
                                                                      .hToTime
                                                                      .toString(),
                                                              style: const TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          )
                                                        : const SizedBox(),
                                                    SizedBox(
                                                      height: H * 0.01,
                                                    ),
                                                    controller.hFromTime2 !=
                                                            null
                                                        ? GestureDetector(
                                                            onTap: () {
                                                              controller
                                                                  .foodSecondTime(
                                                                      index);
                                                            },
                                                            child: Text(
                                                              controller
                                                                      .hFromTime2
                                                                      .toString() +
                                                                  "- " +
                                                                  controller
                                                                      .hToTime2
                                                                      .toString(),
                                                              style: const TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          )
                                                        : const SizedBox(),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        : SizedBox(
                                            width: W * 0.36,
                                          ),
                                  ],
                                ),
                              ),
                            ),
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
                                        controller.addfoodmanually();
                                        Navigator.pop(context);
                                        controller.addfoodManuallyController
                                            .clear();
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
                              // Card(
                              //   shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.circular(45),
                              //   ),
                              //   elevation: 5,
                              //   child: SizedBox(
                              //     width: W * 0.7,
                              //     child: DropDownMultiSelect(
                              //       hint: const Text("Select item"),
                              //       decoration: const InputDecoration(
                              //         enabled: false,
                              //         contentPadding: EdgeInsets.fromLTRB(
                              //             15.0, 30.0, 15.0, 30.0),
                              //         filled: true,
                              //         fillColor: Colors.white,
                              //         border: OutlineInputBorder(
                              //           borderRadius:
                              //               BorderRadius.all(Radius.circular(45)),
                              //         ),
                              //       ),
                              //       onChanged: controller.addFoodFromDropDownList,
                              //       options: controller.foo,
                              //       selectedValues: controller.foods,
                              //     ),
                              //   ),
                              // ),
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
                  Get.back();
                }
              }
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
