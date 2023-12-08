import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/global_controller/global_general_controller.dart';
import 'package:happy_hour_app/screens/account_business/add_for_guest/guest_controller.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import '../../../../core/colors.dart';
import '../../../../core/constants.dart';
import '../../../../global_widgets/main_button.dart';
import '../../../../global_widgets/price_field.dart';
import '../../../../global_widgets/text_field.dart';
import '../../../../routes/app_routes.dart';

class GuestDrinksScreen extends GetView<GuestController> {
  const GuestDrinksScreen({Key? key}) : super(key: key);

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
      body: GetBuilder<GuestController>(
        builder: (_) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: RawScrollbar(
              thumbColor: primary,
              // trackColor: whiteColor,
              // thumbVisibility: true,
              // trackVisibility: true,
              radius: const Radius.circular(20),
              thickness: 8,
              child: ListView(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: H * 0.009,
                  ),
                  const Text(
                    "Add Happy Hour Drinks",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: H * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: W * 0.1, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Item name",
                          style: TextStyle(
                            fontSize: 16,
                            color: blackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Size",
                          style: TextStyle(
                            fontSize: 16,
                            color: blackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Price",
                          style: TextStyle(
                            fontSize: 16,
                            color: blackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Discount",
                          style: TextStyle(
                            fontSize: 16,
                            color: blackColor,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: H * 0.02,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.localdrinkList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0, top: 8.0, bottom: 8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  child: IconButton(
                                    onPressed: () {
                                      controller.removeDrink(index);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      size: 20,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: W * 0.22,
                                  child: Text(
                                    controller.localdrinkList[index].name,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),

                                //*Size
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
                                                      .localdrinkList[index]
                                                      .sizeController,
                                                  obscureText: false,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  onChanged: (val) {
                                                    controller
                                                            .localdrinkList[index]
                                                            .sizeController =
                                                        TextEditingController();
                                                    controller
                                                        .localdrinkList[index]
                                                        .sizeController
                                                        ?.text = val;
                                                    controller
                                                        .localdrinkList[index]
                                                        .size = val;
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
                                                flex: 1,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(0.0),
                                                  child: DropdownButton(
                                                    underline: Container(),
                                                    isExpanded: true,
                                                    hint: const Text(""),
                                                    value: controller
                                                            .localdrinkList[
                                                                index]
                                                            .sizeicon
                                                            .isNotEmpty
                                                        ? controller
                                                            .localdrinkList[
                                                                index]
                                                            .dropDownSize[index]
                                                        : "oz",

                                                    //  controller
                                                    //     .localdrinkList[index]
                                                    //     .dropDownSize[index],
                                                    items: controller
                                                        .sizeDropdownList
                                                        .map((String sizes) {
                                                      return DropdownMenuItem(
                                                          value: sizes,
                                                          child: Text(
                                                            sizes,
                                                            maxLines: 1,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        10),
                                                          ));
                                                    }).toList(),
                                                    onChanged: (String? q) {
                                                      controller
                                                          .localdrinkList[index]
                                                          .dropDownSize[index] = q!;
                                                      controller
                                                          .localdrinkList[index]
                                                          .sizeicon = q;
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

                                PriceField(
                                  width: W * 0.21,
                                  height: H * 0.036,
                                  onTap: () {
                                    controller.localdrinkList[index]
                                            .discountController =
                                        TextEditingController();
                                    controller.localdrinkList[index]
                                        .discountController?.text = "";
                                    controller.localdrinkList[index]
                                        .discount = 0;
                                    controller.update();
                                  },
                                  textEditingController: controller
                                      .localdrinkList[index].drinkController,
                                  onChanged: (val) {
                                    controller.localdrinkList[index].price =
                                        val;
                                    controller.localdrinkList[index].discount = 0;
                                  },
                                  keyboardType: TextInputType.number,
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
                                                      .localdrinkList[index]
                                                      .discountController,
                                                  onTap: () => controller
                                                      .localdrinkList[index]
                                                      .drinkController
                                                      .clear(),
                                                  obscureText: false,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  onChanged: (val) {
                                                    controller.localdrinkList[index].price = "";
                                                    controller
                                                            .localdrinkList[index]
                                                            .discount =
                                                        int.parse(val);
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
                                                      const EdgeInsets.all(8.0),
                                                  child: DropdownButton(
                                                    underline: Container(),
                                                    isExpanded: true,
                                                    hint: const Text(""),
                                                    value: controller
                                                            .localdrinkList
                                                            .isNotEmpty
                                                        ? controller
                                                            .localdrinkList[
                                                                index]
                                                            .dropDown[0]
                                                        : controller
                                                            .localdrinkList[
                                                                index]
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
                                                                    fontSize:
                                                                        12),
                                                          ));
                                                    }).toList(),
                                                    onChanged:
                                                        (String? newValue) {
                                                      controller
                                                          .localdrinkList[index]
                                                          .dropDown[0] = newValue!;
                                                      controller
                                                          .localdrinkList[index]
                                                          .dropDown[1] = newValue;
                                                      controller
                                                          .localdrinkList[index].discounticon = newValue;
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
                            controller.showDayList == true &&
                                    controller.showLateDayList == true
                                ? Obx(() => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Checkbox(
                                              value: controller
                                                  .localdrinkList[index]
                                                  .earlyDrink
                                                  .value,
                                              onChanged: (v) {
                                                controller
                                                    .showEarlyTimeDrink(index);
                                              }),

                                          Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 16.0),
                                              child: Column(children: const [
                                                SizedBox(
                                                  child: Text(
                                                    "Early Happy Hour",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ]),
                                            ),
                                          ),
                                          Checkbox(
                                              value: controller
                                                  .localdrinkList[index]
                                                  .lateDrink
                                                  .value,
                                              onChanged: (v) {
                                                controller
                                                    .showLateTimeDrink(index);
                                              },
                                          ),

                                          Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 16.0),
                                              child: Column(children: const [
                                                SizedBox(
                                                  child: Text(
                                                    "Late Happy Hour",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ]),
                                            ),
                                          ),

                                          // InkWell(
                                          //   onTap: () =>
                                          //       controller.showBothTimeFood(index),
                                          //   child: chipWidget(
                                          //     controller.foodList[index].time,
                                          //     () =>
                                          //         controller.showBothTimeFood(index),
                                          //   ),
                                          // ),
                                          // SizedBox(
                                          //   width: W * 0.02,
                                          // ),
                                        ],
                                      ),
                                    ))
                                : const SizedBox(),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: H * 0.02,
                  ),
                  Center(
                    child: SizedBox(
                      height: H * 0.05,
                      width: W * 0.4,
                      child: CustomElevatedButtonWidget(
                        onPressed: () {
                          Get.find<GlobalGeneralController>().addNewItemDialog(
                            context,
                            "Add new item",
                            () {
                              navigator?.pop(context);
                              addDrinksManually(
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
                                      if(controller.addDrinksManuallyController.text.trim() != "") {
                                        controller.addDrinksmanually();
                                        Navigator.pop(context);
                                        controller.addDrinksManuallyController
                                            .clear();
                                      }else {
                                        Get.find<GlobalGeneralController>()
                                            .errorSnackbar(
                                            title: "Error",
                                            description:
                                            "Please add drink");
                                      }
                                    }),
                                controller.addDrinksManuallyController,
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
                                  buttonIcon: const Icon(
                                    Icons.arrow_drop_down,
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
                                  items: controller.drinkList
                                      .map(
                                        (e) => MultiSelectItem(e, e.name),
                                      )
                                      .toList(),
                                  title: const Text("Drinks"),
                                  selectedColor: primary,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(35)),
                                      boxShadow: []),
                                  buttonText: const Text(
                                    "Select Items",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 24,
                                    ),
                                  ),
                                  onConfirm:
                                      controller.addDrinkFromDropDownList,
                                ),
                                //  DropDownMultiSelect(
                                //   hint: const Text("Select item"),
                                //   decoration: const InputDecoration(
                                //     enabled: false,
                                //     contentPadding: EdgeInsets.fromLTRB(
                                //         15.0, 30.0, 15.0, 30.0),
                                //     filled: true,
                                //     fillColor: Colors.white,
                                //     border: OutlineInputBorder(
                                //       borderRadius:
                                //           BorderRadius.all(Radius.circular(45)),
                                //     ),
                                //   ),
                                //   onChanged:
                                //       controller.addDrinkFromDropDownList,
                                //   options: controller.dri,
                                //   selectedValues: controller.drinkss,
                                // ),
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
                                  Get.back();
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
                    height: H * 0.05,
                  ),
                ],
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
              if (controller.localdrinkList.isEmpty) {
                Get.toNamed(Routes.guestDailySpecialScreen);
              } else {
                var a = controller.localdrinkList.where((e) =>
                    e.name != "" &&
                    e.size != "" &&
                    (e.price != "" || e.discount != 0 || e.discount.isNaN));
                if (a.isEmpty) {
                  Get.find<GlobalGeneralController>().errorSnackbar(
                      title: "Error",
                      description: "Drink Size and Price/Discount Is Required");
                }
                if (a.length == controller.localdrinkList.length) {
                  Get.toNamed(Routes.guestDailySpecialScreen);
                }else{
                  Get.find<GlobalGeneralController>().errorSnackbar(
                      title: "Error",
                      description: "Drink Size and Price/Discount Is Required");
                }
              }
            },
            text: "Next",
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

Future<dynamic> addDrinksManually(
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
    deleteIconColor: Colors.green,
    onDeleted: function,
    label: Text(
      text,
      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
    ),
    backgroundColor: whiteColor,
    elevation: 5,
  );
}
