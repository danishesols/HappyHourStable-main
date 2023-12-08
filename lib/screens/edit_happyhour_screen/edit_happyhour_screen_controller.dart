import 'package:get/get.dart';
import 'package:happy_hour_app/data/providers/add_review_provider.dart';
import '../../data/providers/add_happyhour_provider.dart';
import '../../data/providers/favorite_provider.dart';
import '../../global_controller/global_general_controller.dart';
import '../account_business/subcription_screen/unsubscribed_screen.dart';

class EditHappyHourScreenController extends GetxController {
  final AddHappyHourProvider _addHappyHourProvider = AddHappyHourProvider();
  final AddReviewProvider _addReviewProvider = AddReviewProvider();
  final FavoriteProvider favoriteProvider = FavoriteProvider();

  //final HappyHourModel hours = Get.arguments[1];

  deleteHour(id) {
    _addHappyHourProvider.deleteHour(id);
    update();
    Get.back();
    // Get.find<GlobalGeneralController>()
    //     .toastMessage(message: "Happy hour Deleted!");
    Get.find<GlobalGeneralController>()
        .errorSnackbar(title: "Deleted", description: "Happy hour Deleted!");
    // Get.toNamed(Routes.businessAccountHomeScreen);
  }

  final _isPromote = false.obs;
  bool get isPromote => _isPromote.value;
  set isPromote(value) => _isPromote.value = value;

  // promtion(hourId) {
  //   if (Get.find<AuthController>().user.hasSubscription) {
  //     // * mark hour as claimed.
  //     favoriteProvider.promoteHour(
  //       userId: Get.find<AuthController>().user.uid,
  //       hourId: hourId,
  //     );
  //   }
  // }

  onPromotedClick(id) {
    _addReviewProvider.promoted(hourId: id, isPromoted: false);

    update();
    Get.to(() => const UnsubscribedScreen());
  }

  // void onPromotionTap() {
  //   Get.find<AuthController>().user.isBusiness
  //       ? isPromote == true
  //           ? Get.find<GlobalGeneralController>().dialogueCard(
  //               Get.context!,
  //               "Promote Happy Hour",
  //               "Do you want to promote this Happy hour?",
  //               "Promote", () {
  //               Get.find<GlobalGeneralController>().successSnackbar(
  //                   title: "Happy Hour", description: "Happy Hour Promoted");
  //               navigator?.pop(Get.context!);
  //             })
  //           : Get.find<GlobalGeneralController>().dialogueCard(
  //               Get.context!,
  //               "Stop Promotion",
  //               "Do you want to stop the promotion of this Happy hour?",
  //               "Stop Promotion", () {
  //               Get.find<GlobalGeneralController>().successSnackbar(
  //                   title: "Happy Hour", description: "Happy Hour Promoted");
  //               navigator?.pop(Get.context!);
  //             })
  //       : Get.find<GlobalGeneralController>().errorSnackbar(
  //           title: "Subscription ", description: "Please Subcribe a Plan!");
  // }
}
