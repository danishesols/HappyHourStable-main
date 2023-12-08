import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/global_controller/global_general_controller.dart';
import 'package:happy_hour_app/global_widgets/upload_Image_card.dart';
import 'package:happy_hour_app/screens/add_happyhour_business/add_happyhour_manually.dart';
import '../../core/colors.dart';
import '../../core/constants.dart';
import '../../global_widgets/main_button.dart';
import '../../global_widgets/text_field.dart';
import '../../routes/app_routes.dart';
import '../add_happyhour_standard_item/add_happyhour_controller.dart';

class AddHappyHourBusinessScreen extends GetView<AddHappyhourController> {
  const AddHappyHourBusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddHappyhourController>(
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
                icon: SvgPicture.asset(
                  "assets/icons/Group 9108.svg",
                  height: 25,
                  width: 25,
                ),),
            title: const Text("Add Happy Hour",),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: controller.businessFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: H * 0.009,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0,),
                      child: Text(
                        "Please fill out this form",
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
                      padding: const EdgeInsets.only(left: 8.0),
                      child: topText("Business Information"),
                    ),
                    SizedBox(
                      height: H * 0.02,
                    ),
                    CustomTextFieldWidget(
                      onTap: () async { await  controller.onBusinessNameClick();},
                      readOnly: true,
                      validator: controller.nameValidator,
                      labelText: "Business Name",
                      textEditingController: controller.businessNameController,
                    ),
                    SizedBox(
                      height: H * 0.02,
                    ),
                    CustomTextFieldWidget(
                      // onTap: () => controller.onBusinessAddressClick(),

                      validator: controller.addressValidator,
                      labelText: "Business Address",
                      textEditingController:
                          controller.businessAddressController,
                    ),

                    // ),
                    SizedBox(
                      height: H * 0.03,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() =>  AddHappyHOurManually());
                      },
                      child: const Center(
                        child: Text(
                          "Add Manually",
                          style: TextStyle(
                            fontSize: 20,
                            color: primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Center(
                    //       child: SizedBox(
                    //         width: MediaQuery.of(context).size.width / 3,
                    //         height: MediaQuery.of(context).size.height / 16,
                    //         child: Material(
                    //           elevation: 3,
                    //           borderRadius: BorderRadius.circular(45),
                    //           child: Row(
                    //             children: [
                    //               Flexible(
                    //                 child: TextFormField(
                    //                   readOnly:
                    //                       controller.foodDiscount == "%"
                    //                           ? true
                    //                           : false,
                    //                   obscureText: false,
                    //                   keyboardType: TextInputType.number,
                    //                   controller:
                    //                       controller.discountController,
                    //                   decoration: InputDecoration(
                    //                     hintText: "Enter Discount",
                    //                     hintStyle: const TextStyle(
                    //                         color: Colors.grey),
                    //                     contentPadding:
                    //                         const EdgeInsets.fromLTRB(
                    //                             15.0, 20.0, 15.0, 20.0),
                    //                     filled: false,
                    //                     fillColor: Colors.white,
                    //                     border: OutlineInputBorder(
                    //                       borderSide: BorderSide.none,
                    //                       borderRadius:
                    //                           BorderRadius.circular(10),
                    //                     ),
                    //                   ),
                    //                 ),
                    //               ),
                    //               Flexible(
                    //                 child: Padding(
                    //                   padding: const EdgeInsets.all(8.0),
                    //                   child: DropdownButton(
                    //                     underline: Container(),
                    //                     isExpanded: true,
                    //                     hint: const Text(""),
                    //                     value: controller.foodDiscount == ""
                    //                         ? null
                    //                         : controller.foodDiscount,
                    //                     items: controller
                    //                         .foodDiscountDropdown
                    //                         .map((String items) {
                    //                       return DropdownMenuItem(
                    //                           value: items,
                    //                           child: Text(items));
                    //                     }).toList(),
                    //                     onChanged: (String? newValue) {
                    //                       controller.foodDiscount =
                    //                           newValue;
                    //                       newValue == "Discount"
                    //                           ? controller
                    //                               .discountController
                    //                               .clear()
                    //                           : "";
                    //                     },
                    //                   ),
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // ),
                    // Obx(
                    //   () => controller.isShowMap
                    //       ? const SizedBox()
                    //       : Row(
                    //           children: [
                    //             Flexible(
                    //               child: CustomTextFieldWidget(
                    //                 labelText: "Latitude",
                    //                 textEditingController:
                    //                     controller.latFieldController,
                    //                 validator: controller.validateNumber,
                    //                 keyboardType: const TextInputType
                    //                     .numberWithOptions(decimal: true),
                    //               ),
                    //             ),
                    //             Flexible(
                    //               child: CustomTextFieldWidget(
                    //                 labelText: "Longitude",
                    //                 textEditingController:
                    //                     controller.longFieldController,
                    //                 validator: controller.validateNumber,
                    //                 keyboardType: const TextInputType
                    //                     .numberWithOptions(decimal: true),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    // ),
                    // Obx(
                    //   () => controller.isShowMap
                    //       ? Padding(
                    //           padding: const EdgeInsets.all(8.0),
                    //           child: Center(
                    //             child: SizedBox(
                    //               height: H / 4,
                    //               width: W * 0.98,
                    //               child: GoogleMap(
                    //                 onTap: (LatLng point) {
                    //                   controller.latLong(point);
                    //                 },
                    //                 myLocationButtonEnabled: true,
                    //                 myLocationEnabled: true,
                    //                 zoomControlsEnabled: true,
                    //                 initialCameraPosition:
                    //                     controller.defaultCameraPosition,
                    //                 onMapCreated: (mapController) =>
                    //                     controller.googleMapController =
                    //                         mapController,
                    //               ),
                    //             ),
                    //           ),
                    //         )
                    //       : const SizedBox(),
                    //),
                    const SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child:        Row(
                        children: [
                          topText("Happy Hour Menu"),
                          SizedBox(
                            width: W * 0.02,
                          ),
                          Image.asset(
                            "assets/icons/Group 11537.png",
                            height: H * 0.025,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text("Multiple Happy Hour Menu images can be uploaded"),
                    ),
                    SizedBox(
                      height: H * 0.02,
                    ),
                    Obx(
                      () => controller.happyHourMultiImages.isEmpty
                          ? UploadImageCard(
                              title: "Upload Menu Image",
                              onpressed: () {
                                dialogueCard(
                                    context,
                                    "Add From Gallery",
                                    () {
                                      Navigator.pop(context);
                                      controller.uploadMultiMenuImage();
                                    },
                                    "Open Camera",
                                    () {
                                      Navigator.pop(context);
                                      controller.uploadMenuImage();
                                    });
                              },
                            )
                          : Center(
                              child: GestureDetector(
                                  onTap: () {
                                    dialogueCard(
                                        context,
                                        "Add From Gallery",
                                        () {
                                          Navigator.pop(context);
                                          controller.uploadMultiMenuImage();
                                        },
                                        "Open Camera",
                                        () {
                                          Navigator.pop(context);
                                          controller.uploadMenuImage();
                                        });
                                  },
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        controller.happyHourMultiImages.length,
                                    itemBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Stack(
                                        children: [
                                          Image.file(
                                            File(controller
                                                .happyHourMultiImages[index]
                                                .path),
                                            width: W,
                                            height: H * 0.2,
                                            fit: BoxFit.cover,
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 5,
                                            child: IconButton(
                                                onPressed: () {
                                                  controller
                                                      .happyHourMultiImages
                                                      .removeAt(index);
                                                },
                                                icon: const Icon(
                                                  Icons.cancel_outlined,
                                                  size: 40,
                                                  color: Colors.red,
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                            ),
                    ),

                    // Obx(
                    //   () => controller.menuImage == ""
                    //       ? UploadImageCard(
                    //           title: "Upload Menu Image",
                    //           onpressed: () {
                    //             controller.uploadMenuImage();
                    //           },
                    //         )
                    //       : Center(
                    //           child: GestureDetector(
                    //             onTap: () {
                    //               controller.uploadMenuImage();
                    //             },
                    //             child: Image.file(
                    //               File(controller.menuImage),
                    //               width: W * 0.95,
                    //               height: H * 0.2,
                    //               fit: BoxFit.cover,
                    //             ),
                    //           ),
                    //         ),
                    // ),
                    // SizedBox(
                    //   height: H * 0.02,
                    // ),
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
                  if (controller.businessFormKey.currentState!.validate()) {
                    if (controller.happyHourMultiImages.isEmpty) {
                      Get.find<GlobalGeneralController>().errorSnackbar(
                          title: "Image",
                          description: "Make sure you have picked the images");
                    } else if (controller.businessFormKey.currentState!.validate() &&
                        controller.happyHourMultiImages.isNotEmpty) {
                      Get.toNamed(Routes.addHappyHourBusinessDetailScreen);
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
      },
    );
  }
}

Text topText(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
  );
}

Future<dynamic> dialogueCard(
  BuildContext context,
  String buttonText,
  VoidCallback onConfrim,
  String buttonText2,
  VoidCallback onConfrim2,
) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
              child: CustomElevatedButtonWidget(
                horizontalPadding: 20,
                verticalPadding: 22,
                borderRadius: 35,
                fontSize: 20,
                textColor: blackColor,
                text: (buttonText),
                onPressed: onConfrim,
              ),
            ),
            SizedBox(
              height: H * 0.01,
            ),
            Center(
              child: CustomElevatedButtonWidget(
                horizontalPadding: 30,
                verticalPadding: 22,
                borderRadius: 35,
                fontSize: 20,
                textColor: blackColor,
                text: (buttonText2),
                onPressed: onConfrim2,
              ),
            ),
            SizedBox(height: H * 0.03),
          ],
        ),
      );
    },
  );
}
