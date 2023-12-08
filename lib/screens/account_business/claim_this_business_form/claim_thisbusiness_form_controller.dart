// import 'package:get/get.dart';
// import 'package:happy_hour_app/data/models/happyhour_model.dart';
// import 'package:happy_hour_app/global_controller/global_general_controller.dart';
// import 'package:image_picker/image_picker.dart';

// import '../../../routes/app_routes.dart';

// class ClaimThisBusinessFormController extends GetxController {
//   final HappyHourModel id = Get.arguments;
//   final ImagePicker _picker = ImagePicker();

//   final _busniessCard = "".obs;
//   String get businessCard => _busniessCard.value;
//   set businessCard(value) => _busniessCard.value = value;

//   void claimedHourTap(hourId) {
//     if (businessImage != "" && businessLogo != "" && businessCard != "") {
//       Get.toNamed(Routes.happyHourClaimScreen, arguments: Get.arguments);
//       // claimed(hourId);
//     } else {
//       Get.find<GlobalGeneralController>()
//           .errorSnackbar(title: "Error", description: "Add All Images");
//     }
//   }

//   Future uploadBusinessCard() async {
//     final XFile? imageFile =
//         await _picker.pickImage(source: ImageSource.gallery);
//     if (imageFile != null) {
//       businessCard = imageFile.path;
//     }
//   }

//   final _busniessLogo = "".obs;
//   String get businessLogo => _busniessLogo.value;
//   set businessLogo(value) => _busniessLogo.value = value;

//   Future uploadBusinessLogo() async {
//     final XFile? imageFile =
//         await _picker.pickImage(source: ImageSource.gallery);
//     if (imageFile != null) {
//       businessLogo = imageFile.path;
//     }
//   }

//   final _busniessImage = "".obs;
//   String get businessImage => _busniessImage.value;
//   set businessImage(value) => _busniessImage.value = value;

//   Future uploadBusinessImage() async {
//     final XFile? imageFile =
//         await _picker.pickImage(source: ImageSource.gallery);
//     if (imageFile != null) {
//       businessImage = imageFile.path;
//     }
//   }
// }
