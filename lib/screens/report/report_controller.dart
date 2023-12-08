import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/global_controller/global_general_controller.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/providers/add_review_provider.dart';
import '../../global_controller/auth_controller.dart';

class ReportController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  final hourid = Get.arguments;
  final AddReviewProvider _addReviewProvider = AddReviewProvider();
  final reportController = TextEditingController();

  final _happyHourMultiMenuImage = <String>[].obs;

  RxBool isLoading = false.obs;
  List<String> get happyHourMultiImages => _happyHourMultiMenuImage;
  set happyHourMultiImages(value) => _happyHourMultiMenuImage.value = value;

  Future pickMultiMenuImage() async {
    final List<XFile>? images = await _picker.pickMultiImage();

    if (images != null) {
      for(var i in images){
        happyHourMultiImages.add(i.path);
      }

    }
    update();
  }

  Future pickSingleHappyHourMenuImage() async {
    final XFile? imageFile =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 85);
    if (imageFile != null) {
      happyHourMenuImage = imageFile.path;
      happyHourMultiImages.add(imageFile.path);
    }
  }

  final _happyHourMenuImage = "".obs;
  String get happyHourMenuImage => _happyHourMenuImage.value;
  set happyHourMenuImage(value) => _happyHourMenuImage.value = value;

  Future<List<String>>uploadMenuImage()async{
    final DateTime now = DateTime.now();
    List<String> menuUrls = [];
    final int millSeconds = now.microsecondsSinceEpoch;
    final String imagename = (millSeconds.toString());
    //Converting the imageurl into the file
    for(int i =0; i<happyHourMultiImages.length;i++){
      File imageFile = File(happyHourMultiImages[i]);
      // Get.find<AddHappyhourBusinessController>().isLoading = true;
      //Upload the menuImage to the firebase Storage
      TaskSnapshot taskSnapshot = await FirebaseStorage.instance
          .ref('reportImages/$hourid/$imagename')
          .putFile(imageFile);
      String menuImageAccessUrl = await taskSnapshot.ref.getDownloadURL();
      menuUrls.add(menuImageAccessUrl);
    }
    // Get.find<AddHappyhourBusinessController>().isLoading = false;
    return menuUrls;
  }

  Future<void>addReportOnHour(String hourId) async{
    if (reportController.text.toString() != '') {
      Get.back();
      isLoading.value = true;
      update();
      List<String>? images;
      if(_happyHourMultiMenuImage.isNotEmpty) {
         images = await uploadMenuImage();
      }
      await _addReviewProvider.reportHappyHour(
        hourId: hourId,
        userId: Get.find<AuthController>().user.uid,
        reportText: reportController.text,
        images: images ?? [],
      );

      reportController.clear();
      _happyHourMultiMenuImage.value=[];
      isLoading.value = false;
      update();

    } else {
      Get.find<GlobalGeneralController>().errorSnackbar(
          title: "Error",
          description: "Add Report and attach atleast one image Then Submit");
    }
  }
}
