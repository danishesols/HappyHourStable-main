import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/colors.dart';
import '../../../../core/constants.dart';
import '../../../../global_widgets/main_button.dart';
import '../../duplicate_happyhour_controller.dart';

class DuplicateBarTypeScreen extends GetView<DuplicateController> {
  const DuplicateBarTypeScreen({Key? key}) : super(key: key);

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
        title: const Text("Restaurant/Bar Type"),
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
              const Text(
                "Add Happy Hour Bar Type",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: H * 0.02,
              ),
              const Text(
                "You can only select three options",
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(
                height: H * 0.01,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.barTypeList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
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
                                    checkColor: Theme.of(context).primaryColor,
                                    splashRadius: 20,
                                    shape: const StadiumBorder(),
                                    side: BorderSide.none,
                                    value: controller
                                        .barTypeList[index].isSelect.value,
                                    onChanged: (v) {
                                      controller.updateBartype(index);
                                    }),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: W * 0.02,
                        ),
                        Text(controller.barTypeList[index].amenity,
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
              SizedBox(
                height: H * 0.01,
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
              // controller.barTypeAddList.add(controller.barType);
              // var index =
              //     controller.barTypeList.where((e) => e.isSelect.isTrue);
              // int a = index.length;
              // if (a == 0) {
              //   Get.find<GlobalGeneralController>().errorSnackbar(
              //       title: "Error", description: "Select atleast one Bar Type");
              // }
              // if (a > 3) {
              //   Get.find<GlobalGeneralController>().errorSnackbar(
              //       title: "Error", description: "Select only Three Bar Type");
              // }
              // if (a <= 3 && a > 0) {
              //   Get.to(() => const DuplicateEventsScreen());
              // }
              controller.onBartypeDoneTap();
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
