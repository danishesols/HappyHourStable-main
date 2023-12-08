import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/constants.dart';
import 'package:happy_hour_app/data/models/happyhour_model.dart';
import 'package:happy_hour_app/global_controller/auth_controller.dart';
import 'package:happy_hour_app/global_widgets/happyhour_card.dart';
import 'package:happy_hour_app/screens/reviews/review_controller.dart';
import '../../core/colors.dart';
import '../../routes/app_routes.dart';

class ReviewScreen extends GetView<ReviewController> {
  const ReviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: const Text(
          "Reviews",
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24),
        ),
        centerTitle: true,
      ),
      // extendBodyBehindAppBar: true,
       body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: Get.height,
          width: Get.width,

          child: Center(
            child: SizedBox(
            //  child:   Lottie.asset('assets/animations/coming-soon.json'),
            //child: Image.asset('assets/images/coming-soon.jpg'),
              child: Image.asset('assets/images/coming-soon5.png'),
            ),
          ),
        ),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 20),
      //   child: SingleChildScrollView(
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         SizedBox(
      //           height: H * 0.01,
      //         ),
      //         const Text(
      //           "List of Happy Hours",
      //           style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
      //         ),
      //         SizedBox(
      //           height: H * 0.01,
      //         ),
      //         ReviewListGenerator(
      //           query: controller.reviewProvider.reviewQuery(
      //             userId: Get.find<AuthController>().user.uid,
      //           ),
      //         ),

      //         // const Center(
      //         //   child: CircularProgressIndicator(),
      //         // ),
      //         // Expanded(
      //         //   child:
      //         //    ListView.builder(
      //         //       shrinkWrap: true,
      //         //       itemCount: 1,
      //         //       itemBuilder: (context, index) {
      //         //         return CustomHappyhourCard(
      //         //           ontap: () {},
      //         //           title: "lorem ipsum Store",
      //         //           image: "assets/icons/Group 9200.png",
      //         //           subtitle: "New york USA",
      //         //           time: "Reviews",
      //         //           rating: "assets/icons/Path 16148.svg",
      //         //           rateCount: "",
      //         //         );
      //         //       }),
      //         // ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}

class ReviewListGenerator extends StatelessWidget {
  const ReviewListGenerator({
    Key? key,
    required this.query,
  }) : super(key: key);

  final Query<HappyHourModel> query;

  @override
  Widget build(BuildContext context) {
    return FirestoreListView<HappyHourModel>(
      query: query,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, snapshot) {
        HappyHourModel happyHourModel = snapshot.data();

        return CustomHappyhourCard(
            title: happyHourModel.businessName.toString(),
            subtitle: happyHourModel.businessAddress.toString(),
            image: happyHourModel.menuImage.toString(),
            time:'',
            rating: const SizedBox(),
            // time:
            //     "Review (${happyHourModel.reviewStar!.isEmpty ? 0 : happyHourModel.reviewStar?.length})",
            // rating: RatingBarIndicator(
            //   unratedColor: Colors.grey.shade300,
            //   direction: Axis.horizontal,
            //   rating: happyHourModel.reviewStar!.isEmpty
            //       ? 0
            //       : happyHourModel.reviewStar?[0]["stars"],
            //   itemCount: 5,
            //   itemSize: 20,
            //   itemBuilder: (context, index) => Image.asset(
            //     "assets/icons/Path 602@2x.png",
            //     height: 7,
            //     width: 10,
            //     color: primary,
            //   ),
            // ),
            rateCount:"",
            ontap: () {
              Get.toNamed(Routes.replyScreen, arguments: happyHourModel);
            });

        // HourCard hourCard = HourCard(
        //   name: hoursFavoriteModel.businessName,
        //   menuImage: hoursFavoriteModel.menuImage,
        //   description: hoursFavoriteModel.description,
        //   onTap: () {
        //     // Get.find<GlobalGeneralController>().onHourTap(
        //     //   hoursFavoriteModel: hoursFavoriteModel,
        //     // );
        //   },
        //   icon: Container(),
        // );

        // return hourCard;
      },
    );
  }
}



// class CustomHappyhourCard extends StatelessWidget {
//   const CustomHappyhourCard({
//     Key? key,
//     required this.title,
//     required this.subtitle,
//     required this.image,
//     this.height,
//     this.width,
//     required this.time,
//     required this.rating,
//     required this.rateCount,
//     required this.ontap,
//   }) : super(key: key);
//   final String title;
//   final String subtitle;
//   final String image;
//   final double? height;
//   final double? width;
//   final String time;
//   final String rating;
//   final String rateCount;
//   final VoidCallback ontap;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: ontap,
//       child: Card(
//         elevation: 5,
//         color: whiteColor,
//         shadowColor: bgColor,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(6.0),
//               child: image.isEmpty
//                   ? const Center(
//                       child: FaIcon(
//                         FontAwesomeIcons.circleExclamation,
//                         color: primary,
//                       ),
//                     )
//                   : Container(
//                       height: H * 0.11,
//                       width: W * 0.23,
//                       // child: SvgPicture.asset(image),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         image: DecorationImage(
//                             image: AssetImage(image), fit: BoxFit.cover),
//                       ),
//                     ),
//             ),
//             SizedBox(
//               width: W * 0.002,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
//               child: SizedBox(
//                 width: W * 0.5,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   // mainAxisSize: MainAxisSize.max,
//                   // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Text(
//                       title,
//                       style: const TextStyle(
//                           fontSize: 16, fontWeight: FontWeight.w500),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Text(
//                       subtitle,
//                       style: const TextStyle(
//                           color: Colors.grey,
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500),
//                     ),
//                     SizedBox(
//                       height: H * 0.01,
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           time,
//                           style: const TextStyle(
//                               color: Colors.grey,
//                               fontSize: 12,
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       children: [
//                         SvgPicture.asset(
//                           rating,
//                           height: 15,
//                           // width: 15,
//                         ),
//                         const SizedBox(
//                           width: 5,
//                         ),
//                         SvgPicture.asset(
//                           rating,
//                           height: 15,
//                           width: 15,
//                         ),
//                         const SizedBox(
//                           width: 5,
//                         ),
//                         SvgPicture.asset(
//                           rating,
//                           height: 15,
//                           width: 15,
//                         ),
//                         const SizedBox(
//                           width: 5,
//                         ),
//                         SvgPicture.asset(
//                           rating,
//                           height: 15,
//                           width: 15,
//                         ),
//                         const SizedBox(
//                           width: 5,
//                         ),
//                         SvgPicture.asset(
//                           rating,
//                           height: 15,
//                           width: 15,
//                         ),
//                         const SizedBox(
//                           width: 5,
//                         ),
//                         Text(
//                           rateCount,
//                           style: const TextStyle(
//                               color: Colors.grey,
//                               fontSize: 8,
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }