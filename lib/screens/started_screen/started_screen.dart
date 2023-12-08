import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/colors.dart';
import 'package:happy_hour_app/core/constants.dart';
import 'package:happy_hour_app/global_widgets/main_button.dart';
import 'package:happy_hour_app/screens/started_screen/started_screen_controller.dart';
import 'package:get/get.dart';
class StartedScreen extends GetView<StartedScreenController> {
  const StartedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Padding(
        padding: EdgeInsets.only(top: H * 0.18, right: 16.0, left: 16.0, bottom: H*0.10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Center(
            //   child: SvgPicture.asset(
            //     "assets/images/Group 11393.svg",
            //     height: MediaQuery.of(context).size.height / 4,
            //   ),
            // ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: H * 0.05,
            ),
            const Text(
              //" A Little About",
              "Welcome To",
              style: TextStyle(
                fontSize: 46,
                color: blackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: H * 0.03,
            ),
            Center(
              child: Image.asset(
                "assets/images/Rectangle 2698.png",
                height: MediaQuery.of(context).size.height / 4,
              ),
            ),
            // const Text("Happy Hour Tap",
            //     style: TextStyle(
            //       fontSize: 32,
            //       color: primary,
            //       fontWeight: FontWeight.w600,
            //     )),
            SizedBox(
              height: H * 0.10,
            ),

            // const Padding(
            //   padding: EdgeInsets.only(left: 16.0, right: 16.0),
            //   child: Text(
            //     "Lorem ipsum Dolor sit amet der lorem ipsum dolor sit amit amet der lorem ipsum dolor sit amit",
            //     textAlign: TextAlign.center,
            //     style: TextStyle(
            //       fontSize: 16,
            //       fontWeight: FontWeight.w300,
            //     ),
            //   ),
            // ),

      GetBuilder<StartedScreenController>(
        init: StartedScreenController(),
        builder: (cont) {
          return Center(
  child: Container(
    width: double.infinity, // Optional: Set a maximum width for the content
    child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start, // Center horizontally within the row
              children: [
                Checkbox(value:cont.firstChecked, onChanged: (value) {
                  cont.updateFirstCheck(value);
                }),
                const SizedBox(width: 5),
                const Text(
                  "Agreed To Privacy Policy",
                  style: TextStyle(
                    fontSize: 18,
                    color: blackColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start, // Center horizontally within the row
              children: [
                Checkbox(value: cont.secondChecked, onChanged: (value) {
                  cont.updateSecondCheck(value);
                }),
                const SizedBox(width: 5),
                const Text(
                  "Agreed To Term of use",
                  style: TextStyle(
                    fontSize: 18,
                    color: blackColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),

            SizedBox(height: Get.height * 0.05),
         
            SizedBox(
              height: H * 0.075,
              width: W * 0.6,
              child: CustomWhiteButtonWidget(
                verticalPadding: 0,
                color: cont.firstChecked==false? Colors.grey[300]: cont.secondChecked==false ? Colors.grey[300]:  whiteColor,
                text: "I am  21 yo+",
                borderRadius: 45,
                onPressed: () {
                  if(cont.firstChecked==false || cont.secondChecked==false){

                  }else {
                    controller.onGetStartedTap();
                  }
                  
                },
              ),
            )
          ],
    ),
  ),
);
        }
      ),


         

            // CustomElevatedButtonWidget(
            //     text: "Get Started", onPressed: controller.onGetStartedTap())
          ],
        ),
      ),
    );
  }
}
