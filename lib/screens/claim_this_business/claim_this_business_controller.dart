import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ClaimThisBusinessController extends GetxController {
  final ImagePicker _picker = ImagePicker();

  final _claimBusniessCard = "".obs;
  String get claimBbusinessCard => _claimBusniessCard.value;
  set claimBbusinessCard(value) => _claimBusniessCard.value = value;

  Future uploadClaimBusinessCard() async {
    final XFile? imageFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (imageFile != null) {
      claimBbusinessCard = imageFile.path;
    }
  }

  final _claimBusniessLogo = "".obs;
  String get claimBusinessLogo => _claimBusniessLogo.value;
  set claimBusinessLogo(value) => _claimBusniessLogo.value = value;

  Future uploadclaimBusinessLogo() async {
    final XFile? imageFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (imageFile != null) {
      claimBusinessLogo = imageFile.path;
    }
  }

  final _claimBusniessImage = "".obs;
  String get claimBusinessImage => _claimBusniessImage.value;
  set claimBusinessImage(value) => _claimBusniessImage.value = value;

  Future uploadBusinessImage() async {
    final XFile? imageFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (imageFile != null) {
      claimBusinessImage = imageFile.path;
    }
  }
}
