import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/screens/account_business/claim_report/report_done_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_platform_interface/src/types/image_source.dart';

import '../../../global_controller/auth_controller.dart';

class ClaimReportController extends GetxController {
  final busniessCard = "".obs;

  bool isLoading = false;
  uploadBusinessCard(ImageSource gallery) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? imageFile =
        await _picker.pickImage(source: gallery, imageQuality: 85);
    if (imageFile != null) {
      busniessCard.value = imageFile.path;
      update();
    }

  }

  Future<String> uploadMenuImage(hourId) async {
    final DateTime now = DateTime.now();

    final int millSeconds = now.microsecondsSinceEpoch;
    final String imagename = (millSeconds.toString());
    //Converting the imageurl into the file

    File imageFile = File(busniessCard.value);
    // Get.find<AddHappyhourBusinessController>().isLoading = true;
    //Upload the menuImage to the firebase Storage
    TaskSnapshot taskSnapshot = await FirebaseStorage.instance
        .ref('claimReportImages/$hourId/$imagename')
        .putFile(imageFile);
    String menuImageAccessUrl = await taskSnapshot.ref.getDownloadURL();
    return (menuImageAccessUrl);
  }

  sendHappyHourClaimReport(
    String reportText, hourId
  ) async {
    isLoading = true;
    update();
   String image =
        await uploadMenuImage(Get.find<AuthController>().user.uid);
    await FirebaseFirestore.instance
        .collection('happyHourClaimReports')
        .doc()
        .set({
      "hourId": hourId,
      "reportText": reportText,
      "businessCardImage": image,
      "reportTime": DateTime.now(),
      'userId': Get.find<AuthController>().user.uid,
      'status': 'pending',
    });

    isLoading = false;
    update();

  }
}
