import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/colors.dart';
import '../../../../core/constants.dart';
import '../../../../global_widgets/main_button.dart';
import 'package:happy_hour_app/screens/happyhour_edit_screen/edit_screens/edit_controller.dart';

class EditAmenitiesScreen extends GetView<EditController> {
  const EditAmenitiesScreen({Key? key}) : super(key: key);

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
        title: const Text("Add Restaurant/Bar Amenities"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: RawScrollbar(
          thumbColor: primary,
          // trackColor: whiteColor,
          // thumbVisibility: true,
          // trackVisibility: true,
          radius: const Radius.circular(20),
          thickness: 10,
          child: ListView(
            children: [
              SizedBox(
                height: H * 0.009,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  "Add Happy Hour Bar Amenities",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: H * 0.02,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.amenityModelList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Obx(() => Transform.scale(
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
                                        value: controller.amenityModelList[index]
                                            .isSelect.value,
                                        onChanged: (v) {
                                          controller.updateAmenity(index);
                                        }),
                                  ),
                                ),
                              )),
                          SizedBox(
                            width: W * 0.02,
                          ),
                          Text(controller.amenityModelList[index].name,
                              style: const TextStyle(
                                fontSize: 20,
                                color: blackColor,
                                fontWeight: FontWeight.w400,
                              ))
                        ],
                      ),
                    );
                  },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 32),
        child: SizedBox(
          height: H * 0.09,
          child: CustomElevatedButtonWidget(
            onPressed: () {
              controller.updateBusinessHourToFireStore();
              controller.update();
              Get.back();
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
}
