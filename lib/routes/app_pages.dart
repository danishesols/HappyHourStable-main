import 'package:get/get.dart';
import 'package:happy_hour_app/routes/app_routes.dart';
import 'package:happy_hour_app/screens/account_business/add_for_guest/guest_amenities/guest_amenities_binding.dart';
import 'package:happy_hour_app/screens/account_business/add_for_guest/guest_amenities/guest_aminities_screen.dart';
import 'package:happy_hour_app/screens/account_business/add_for_guest/guest_bartype/guest_bartype_binding.dart';
import 'package:happy_hour_app/screens/account_business/add_for_guest/guest_bartype/guest_bartype_screen.dart';
import 'package:happy_hour_app/screens/account_business/add_for_guest/guest_business_form/guest_form_screen.dart';
import 'package:happy_hour_app/screens/account_business/add_for_guest/guest_daily_special/guest_daily_special_binding.dart';
import 'package:happy_hour_app/screens/account_business/add_for_guest/guest_daily_special/guest_daily_specials_screen.dart';
import 'package:happy_hour_app/screens/account_business/add_for_guest/guest_daytime/guest_daytime_binding.dart';
import 'package:happy_hour_app/screens/account_business/add_for_guest/guest_daytime/guest_daytime_screen.dart';
import 'package:happy_hour_app/screens/account_business/add_for_guest/guest_drinks/guest_drinks_binding.dart';
import 'package:happy_hour_app/screens/account_business/add_for_guest/guest_drinks/guest_drinks_screen.dart';
import 'package:happy_hour_app/screens/account_business/add_for_guest/guest_events/guest_events_binding.dart';
import 'package:happy_hour_app/screens/account_business/add_for_guest/guest_events/guest_events_screen.dart';
import 'package:happy_hour_app/screens/account_business/add_for_guest/guest_fooditems/guest_fooditem_binding.dart';
import 'package:happy_hour_app/screens/account_business/add_for_guest/guest_fooditems/guest_fooditem_screen.dart';
import 'package:happy_hour_app/screens/account_business/business_home_screen/business_home_binding.dart';
import 'package:happy_hour_app/screens/account_business/business_home_screen/business_home_screen.dart';
import 'package:happy_hour_app/screens/account_business/business_items/add_business_hour/add_business_hour_binding.dart';
import 'package:happy_hour_app/screens/account_business/business_items/add_business_hour/add_business_hour_screen.dart';
import 'package:happy_hour_app/screens/account_business/business_items/business_amenities/business_amenities_binding.dart';
import 'package:happy_hour_app/screens/account_business/business_items/business_bartype/business_bartype_binding.dart';
import 'package:happy_hour_app/screens/account_business/business_items/business_daytime/business_deytime_binding.dart';
import 'package:happy_hour_app/screens/account_business/business_items/business_description/business_description_binding.dart';
import 'package:happy_hour_app/screens/account_business/business_items/business_drinks/business_drinks_binding.dart';
import 'package:happy_hour_app/screens/account_business/business_items/business_events/business_events_binding.dart';
import 'package:happy_hour_app/screens/account_business/business_items/business_fooditems/business_fooditem_binding.dart';
import 'package:happy_hour_app/screens/account_business/claim_this_business_form/claim_this_business_form_binding.dart';
import 'package:happy_hour_app/screens/account_business/subcription_screen/subcripiton_screen.dart';
import 'package:happy_hour_app/screens/account_business/subcription_screen/subcription_binding.dart';
import 'package:happy_hour_app/screens/account_business/subcription_screen/subscription_detail/subcription_detail_binding.dart';
import 'package:happy_hour_app/screens/account_standard/home/login_home_screen.dart';
import 'package:happy_hour_app/screens/add_happyhour/add_happyhour_screen.dart';
import 'package:happy_hour_app/screens/add_happyhour/add_happyhour_screen_binding.dart';
import 'package:happy_hour_app/screens/add_happyhour_business/add_happyhour_business.dart';
import 'package:happy_hour_app/screens/add_happyhour_business/add_happyhour_business_binding.dart';
import 'package:happy_hour_app/screens/add_happyhour_standard_item/add_happyhour_amenities/add_happyhour_amenities_binding.dart';
import 'package:happy_hour_app/screens/add_happyhour_standard_item/add_happyhour_bartype/add_happyhour_bartype_binding.dart';
import 'package:happy_hour_app/screens/add_happyhour_standard_item/add_happyhour_business_detail/add_happyhour_business_details_screen.dart';
import 'package:happy_hour_app/screens/add_happyhour_standard_item/add_happyhour_drinks/add_happyhour_drinks_screen_binding.dart';
import 'package:happy_hour_app/screens/add_happyhour_standard_item/add_happyhour_events/add_happyhour_events_binding.dart';
import 'package:happy_hour_app/screens/add_happyhour_standard_item/add_happyhour_fooditems/add_happyhour_fooditem_screen_binding.dart';
import 'package:happy_hour_app/screens/add_review/add_review_binding.dart';
import 'package:happy_hour_app/screens/add_review/add_review_screen.dart';
import 'package:happy_hour_app/screens/checkout/check_out_screen_binding.dart';
import 'package:happy_hour_app/screens/checkout_claim/check_out_claim_screen.dart';
import 'package:happy_hour_app/screens/claim_happyhour_detail/claim_happyhour_detail_binding.dart';
import 'package:happy_hour_app/screens/claim_this_business/claim_this_business_binding.dart';
import 'package:happy_hour_app/screens/claim_your_business/claim_your_business_screen_binding.dart';
import 'package:happy_hour_app/screens/credientials/forget_password/reset_password/reset_password_binding.dart';
import 'package:happy_hour_app/screens/credientials/forget_password/reset_password/reset_password_screen.dart';
import 'package:happy_hour_app/screens/credientials/forget_password/send_forgetpassword_inemail/forget_password_sendemail_screen.dart';
import 'package:happy_hour_app/screens/credientials/forget_password/send_forgetpassword_inemail/forgetpassword_sendemail_binding.dart';
import 'package:happy_hour_app/screens/credientials/login/login_binding.dart';
import 'package:happy_hour_app/screens/credientials/login/login_screen.dart';
import 'package:happy_hour_app/screens/credientials/forget_password/password_updated_screen.dart';
import 'package:happy_hour_app/screens/credientials/signup/business_account_signup/business_account_signup_binding.dart';
import 'package:happy_hour_app/screens/credientials/signup/signup_screen.dart';
import 'package:happy_hour_app/screens/duplicate_happyhour/duplicate_happyhour_binding.dart';
import 'package:happy_hour_app/screens/duplicate_happyhour/duplicate_items/duplicate_amenities/duplicate_amenities_binding.dart';
import 'package:happy_hour_app/screens/duplicate_happyhour/duplicate_items/duplicate_amenities/duplicate_aminities_screen.dart';
import 'package:happy_hour_app/screens/duplicate_happyhour/duplicate_items/duplicate_bartype/duplicate_bartype_binding.dart';
import 'package:happy_hour_app/screens/duplicate_happyhour/duplicate_items/duplicate_bartype/duplicate_bartype_screen.dart';
import 'package:happy_hour_app/screens/duplicate_happyhour/duplicate_items/duplicate_business_hour/duplicate_business_hour_binding.dart';
import 'package:happy_hour_app/screens/duplicate_happyhour/duplicate_items/duplicate_business_hour/duplicate_business_hour_screen.dart';
import 'package:happy_hour_app/screens/duplicate_happyhour/duplicate_items/duplicate_daily_special/duplicate_daily_special_binding.dart';
import 'package:happy_hour_app/screens/duplicate_happyhour/duplicate_items/duplicate_daily_special/duplicate_daily_specials_screen.dart';
import 'package:happy_hour_app/screens/duplicate_happyhour/duplicate_items/duplicate_daytime/duplicate_daytime_binding.dart';
import 'package:happy_hour_app/screens/duplicate_happyhour/duplicate_items/duplicate_daytime/duplicate_daytime_screen.dart';
import 'package:happy_hour_app/screens/duplicate_happyhour/duplicate_items/duplicate_description/duplicate_description_binding.dart';
import 'package:happy_hour_app/screens/duplicate_happyhour/duplicate_items/duplicate_description/duplicate_description_screen.dart';
import 'package:happy_hour_app/screens/duplicate_happyhour/duplicate_items/duplicate_drinks/duplicate_drinks_binding.dart';
import 'package:happy_hour_app/screens/duplicate_happyhour/duplicate_items/duplicate_drinks/duplicate_drinks_screen.dart';
import 'package:happy_hour_app/screens/duplicate_happyhour/duplicate_items/duplicate_events/duplicate_events_binding.dart';
import 'package:happy_hour_app/screens/duplicate_happyhour/duplicate_items/duplicate_events/duplicate_events_screen.dart';
import 'package:happy_hour_app/screens/duplicate_happyhour/duplicate_items/duplicate_fooditems/duplicate_fooditem_binding.dart';
import 'package:happy_hour_app/screens/duplicate_happyhour/duplicate_items/duplicate_fooditems/duplicate_fooditem_screen.dart';
import 'package:happy_hour_app/screens/favorites_screen/favorite_binding.dart';
import 'package:happy_hour_app/screens/find_your_happyhour_screen/find_your_happyhour_screen.dart';
import 'package:happy_hour_app/screens/find_your_happyhour_screen/find_your_happyhour_screen_binding.dart';
import 'package:happy_hour_app/screens/happyhour_claim_screen/claim_packages/claim_packages_screen.dart';
import 'package:happy_hour_app/screens/happyhour_claim_screen/claim_screens/claim_account/claim_account_screen.dart';
import 'package:happy_hour_app/screens/happyhour_detail_screen/happyhour_detail_screen_binding.dart';
import 'package:happy_hour_app/screens/happyhour_edit_screen/edit_happyhour_detail/edit_detail_screen_binding.dart';
import 'package:happy_hour_app/screens/happyhour_edit_screen/edit_screens/edit_description/edit_description_binding.dart';
import 'package:happy_hour_app/screens/happyhour_edit_screen/edit_screens/edit_description/edit_description_screen.dart';
import 'package:happy_hour_app/screens/happyhour_edit_screen/edit_screens/edit_hour/edit_hour_screen.dart';
import 'package:happy_hour_app/screens/happyhour_filter_screen/happyhour_filter_screen_binding.dart';
import 'package:happy_hour_app/screens/happyhour_map_screen.dart/happyhour_map_screen.dart';
import 'package:happy_hour_app/screens/happyhour_map_screen.dart/happyhour_map_screen_binding.dart';
import 'package:happy_hour_app/screens/home_screen/home_screen.dart';
import 'package:happy_hour_app/screens/home_screen/home_screen_binding.dart';
import 'package:happy_hour_app/screens/map_argument_screen/map_binding.dart';
import 'package:happy_hour_app/screens/map_argument_screen/map_screen.dart';
import 'package:happy_hour_app/screens/packages/packages_screen_binding.dart';
import 'package:happy_hour_app/screens/payment_method/payment_card_detail/payment_card_detail_screen_binding.dart';
import 'package:happy_hour_app/screens/reply_screen.dart/reply_binding.dart';
import 'package:happy_hour_app/screens/report/report_binding.dart';
import 'package:happy_hour_app/screens/reviews/review_binding.dart';
import 'package:happy_hour_app/screens/splash/splash_screen.dart';
import 'package:happy_hour_app/screens/started_screen/started_screen.dart';
import 'package:happy_hour_app/screens/started_screen/started_screen_binding.dart';
import '../screens/about_us/about_us_screen.dart';
import '../screens/account_business/add_for_guest/guest_business_form/guest_form_binding.dart';
import '../screens/account_business/add_haapyhour_business_account/add_happyhour_business_account_binding.dart';
import '../screens/account_business/add_haapyhour_business_account/add_happyhour_business_account_screen.dart';
import '../screens/account_business/business_filter_screen/business_filter_screen.dart';
import '../screens/account_business/business_filter_screen/business_filter_screen_binding.dart';
import '../screens/account_business/business_happyhour_detail/business_happyhour_detail_screen.dart';
import '../screens/account_business/business_happyhour_detail/business_happyhour_detail_screen_binding.dart';
import '../screens/account_business/business_items/add_happyhour_request_submitted_screen.dart';
import '../screens/account_business/business_items/business_amenities/business_aminities_screen.dart';
import '../screens/account_business/business_items/business_bartype/business_bartype_screen.dart';
import '../screens/account_business/business_items/business_daily_special/business_daily_special_binding.dart';
import '../screens/account_business/business_items/business_daily_special/business_daily_specials_screen.dart';
import '../screens/account_business/business_items/business_daytime/business_daytime_screen.dart';
import '../screens/account_business/business_items/business_description/business_description_screen.dart';
import '../screens/account_business/business_items/business_drinks/business_drinks_screen.dart';
import '../screens/account_business/business_items/business_events/business_events_screen.dart';
import '../screens/account_business/business_items/business_fooditems/business_fooditem_screen.dart';
import '../screens/account_business/business_search_result/business_search_result_binding.dart';
import '../screens/account_business/business_search_result/business_search_result_screen.dart';
import '../screens/account_business/claim_business_hour/claim_business_hour_binding.dart';
import '../screens/account_business/claim_business_hour/claim_business_hour_screen.dart';
import '../screens/account_business/claim_this_business_form/claim_thisbusiness_form_screen.dart';
import '../screens/account_business/claimed_screen/claimed_binding.dart';
import '../screens/account_business/claimed_screen/claimed_screen.dart';
import '../screens/account_business/find_your_happyhour_screen_business/find_your_happyhour_screen.dart';
import '../screens/account_business/find_your_happyhour_screen_business/find_your_happyhour_screen_binding.dart';
import '../screens/account_business/subcription_screen/subscription_detail/subcription_detail_screen.dart';
import '../screens/account_standard/home/login_home_binding.dart';
import '../screens/account_standard/standard_find_your_happyhour/find_your_happyhour_standard_binding.dart';
import '../screens/account_standard/standard_find_your_happyhour/find_your_happyhour_standard.dart';
import '../screens/account_standard/standard_happyhour_detail/standard_happyhour_detail_screen.dart';
import '../screens/account_standard/standard_happyhour_detail/standard_happyhour_detail_screen_binding.dart';
import '../screens/account_standard/submitted_screen.dart';
import '../screens/add_happyhour_standard_item/add_happyhour_amenities/add_happyhour_aminities_screen.dart';
import '../screens/add_happyhour_standard_item/add_happyhour_bartype/add_happyhour_bartype_screen.dart';
import '../screens/add_happyhour_standard_item/add_happyhour_business_detail/add_happyhour_business_detail_binding.dart';
import '../screens/add_happyhour_standard_item/add_happyhour_daily_special/add_happyhour_daily_special_binding.dart';
import '../screens/add_happyhour_standard_item/add_happyhour_daily_special/add_happyhour_daily_specials_screen.dart';
import '../screens/add_happyhour_standard_item/add_happyhour_drinks/add_happyhour_drinks_screen.dart';
import '../screens/add_happyhour_standard_item/add_happyhour_events/add_happyhour_events_screen.dart';
import '../screens/add_happyhour_standard_item/add_happyhour_fooditems/add_happyhour_fooditem_screen.dart';
import '../screens/add_happyhour_standard_item/add_happyhour_request_submitted_screen.dart';
import '../screens/checkout/check_out_screen.dart';
import '../screens/checkout_claim/check_out_claim_screen_binding.dart';
import '../screens/claim_happyhour_detail/claim_happyhour_detail_screen.dart';
import '../screens/claim_this_business/claim_this_business_screen.dart';
import '../screens/claim_your_business/claim_your_business_screen.dart';
import '../screens/credientials/account_created_screen.dart';
import '../screens/credientials/login_create_account_screen.dart';
import '../screens/credientials/signup/business_account_signup/create_business_account_screen.dart';
import '../screens/credientials/signup/standard_account_signup/create_standard_account_screen.dart';
import '../screens/credientials/signup/standard_account_signup/standard_account_signup_binding.dart';
import '../screens/duplicate_happyhour/duplicate_happyhour_screen.dart';
import '../screens/duplicate_happyhour/duplicate_packages/duplicate_packages_screen.dart';
import '../screens/edit_happyhour_screen/edit_happyhour_screen.dart';
import '../screens/edit_happyhour_screen/edit_happyhour_screen_binding.dart';
import '../screens/faq_screen/faq_screen.dart';
import '../screens/favorite_details/favorite_detail_binding.dart';
import '../screens/favorite_details/favorite_detail_screen.dart';
import '../screens/favorites_screen/favorite_screen.dart';
import '../screens/happyhour_claim_screen/claim_screens/claim_amenities/claim_amenities_binding.dart';
import '../screens/happyhour_claim_screen/claim_screens/claim_amenities/claim_aminities_screen.dart';
import '../screens/happyhour_claim_screen/claim_screens/claim_bartype/claim_bartype_binding.dart';
import '../screens/happyhour_claim_screen/claim_screens/claim_bartype/claim_bartype_screen.dart';
import '../screens/happyhour_claim_screen/claim_screens/claim_daily_special/claim_daily_special_binding.dart';
import '../screens/happyhour_claim_screen/claim_screens/claim_daily_special/claim_daily_specials_screen.dart';
import '../screens/happyhour_claim_screen/claim_screens/claim_daytime/claim_daytime_binding.dart';
import '../screens/happyhour_claim_screen/claim_screens/claim_daytime/claim_daytime_screen.dart';
import '../screens/happyhour_claim_screen/claim_screens/claim_drinks/claim_drinks_binding.dart';
import '../screens/happyhour_claim_screen/claim_screens/claim_drinks/claim_drinks_screen.dart';
import '../screens/happyhour_claim_screen/claim_screens/claim_events/claim_events_binding.dart';
import '../screens/happyhour_claim_screen/claim_screens/claim_events/claim_events_screen.dart';
import '../screens/happyhour_claim_screen/claim_screens/claim_fooditems/claim_fooditem_binding.dart';
import '../screens/happyhour_claim_screen/claim_screens/claim_fooditems/claim_fooditem_screen.dart';
import '../screens/happyhour_claim_screen/claim_screens/claim_hour/Claim_hour_screen.dart';
import '../screens/happyhour_claim_screen/claim_screens/claim_hour/claim_hour_binding.dart';
import '../screens/happyhour_claim_screen/claim_screens/claim_account/claim_account_binding.dart';
import '../screens/happyhour_claim_screen/happyhour_claim_screen.dart';
import '../screens/happyhour_detail_screen/happyhour_detail_screen.dart';
import '../screens/happyhour_edit_screen/edit_happyhour_detail/edit_detail_screen.dart';
import '../screens/happyhour_edit_screen/edit_screens/edit_account/edit_account_binding.dart';
import '../screens/happyhour_edit_screen/edit_screens/edit_account/edit_account_screen.dart';
import '../screens/happyhour_edit_screen/edit_screens/edit_amenities/edit_amenities_binding.dart';
import '../screens/happyhour_edit_screen/edit_screens/edit_amenities/edit_aminities_screen.dart';
import '../screens/happyhour_edit_screen/edit_screens/edit_bartype/edit_bartype_binding.dart';
import '../screens/happyhour_edit_screen/edit_screens/edit_bartype/edit_bartype_screen.dart';
import '../screens/happyhour_edit_screen/edit_screens/edit_daily_special/edit_daily_special_binding.dart';
import '../screens/happyhour_edit_screen/edit_screens/edit_daily_special/edit_daily_specials_screen.dart';
import '../screens/happyhour_edit_screen/edit_screens/edit_daytime/edit_daytime_binding.dart';
import '../screens/happyhour_edit_screen/edit_screens/edit_daytime/edit_daytime_screen.dart';
import '../screens/happyhour_edit_screen/edit_screens/edit_drinks/edit_drinks_binding.dart';
import '../screens/happyhour_edit_screen/edit_screens/edit_drinks/edit_drinks_screen.dart';
import '../screens/happyhour_edit_screen/edit_screens/edit_events/edit_events_binding.dart';
import '../screens/happyhour_edit_screen/edit_screens/edit_events/edit_events_screen.dart';
import '../screens/happyhour_edit_screen/edit_screens/edit_fooditems/edit_fooditem_binding.dart';
import '../screens/happyhour_edit_screen/edit_screens/edit_fooditems/edit_fooditem_screen.dart';
import '../screens/happyhour_edit_screen/edit_screens/edit_hour/edit_hour_binding.dart';
import '../screens/happyhour_edit_screen/happyhour_edit_binding.dart';
import '../screens/happyhour_edit_screen/happyhour_edit_screen.dart';
import '../screens/happyhour_filter_screen/happyhour_filter_screen.dart';
import '../screens/happyhour_search_result/happyhour_search_result_binding.dart';
import '../screens/happyhour_search_result/happyhour_search_result_screen.dart';
import '../screens/my_profile/my_profile_binding.dart';
import '../screens/my_profile/my_profile_screen.dart';
import '../screens/notification/notification_screen.dart';
import '../screens/packages/packages_screen.dart';
import '../screens/payment_method/payment_card_detail/payment_card_detail_screen.dart';
import '../screens/payment_method/payment_method_request_completed_screen.dart';
import '../screens/payment_method/payment_method_screen.dart';
import '../screens/payment_method/payment_method_screen_binding.dart';
import '../screens/privacy_policy/privacy_policy_screen.dart';
import '../screens/privacy_policy/privacy_policy_screen_binding.dart';
import '../screens/reply_screen.dart/reply_screen.dart';
import '../screens/report/report_screen.dart';
import '../screens/reviews/reviews_screen.dart';
import '../screens/term_of_use/term_of_use_screen.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.initialSplash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Routes.startedScreen,
      page: () => const StartedScreen(),
      binding: StartedScreenBinding(),
    ),
    GetPage(
      name: Routes.homeScreen,
      page: () => const HomeScreen(),
      binding: HomeScreenBinding(),
    ),
    GetPage(
      name: Routes.findYourHappyHourScreen,
      page: () => const FindYourHappyHourScreen(),
      binding: FindYourHappyHourScreenBinding(),
    ),
    GetPage(
      name: Routes.addHappyhourScreen,
      page: () => const AddHappyhourScreen(),
      binding: AddHappyhourScreenBinding(),
    ),
    GetPage(
      name: Routes.loginCreateAccountScreen,
      page: () => const LoginCreateAccountScreen(),
    ),
    GetPage(
      name: Routes.loginScreen,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.signUpScreen,
      page: () => const SignUpScreen(),
    ),
    GetPage(
      name: Routes.forgetPasswordSendEmailScreen,
      page: () => const ForgetPasswordSendEmailScreen(),
      binding: ForgetPasswordSendEmailBinding(),
    ),
    GetPage(
      name: Routes.resetPasswordScreen,
      page: () => const ResetPasswordScreen(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: Routes.passwordUpdatedScreen,
      page: () => const PasswordUpdatedScreen(),
    ),
    GetPage(
        name: Routes.happyHourDetailScreen,
        page: () => const HappyHourDetailScreen(),
        binding: HappyhourDetailScreenBindings()),

    //*This is Description Screen
    // GetPage(
    //   name: Routes.happyhourDescriptionScreen,
    //   page: () => const HappyhourDescriptionScreen(),
    //   binding: AddHappyhourDescriptionBinding(),
    // ),
    GetPage(
        name: Routes.createBusinessAccountScreen,
        page: () => const CreateBusinessAccountScreen(),
        binding: BusinessAccountSignUpBinding()),
    GetPage(
        name: Routes.createStandardAccountScreen,
        page: () => const CreateStandardAccountScreen(),
        binding: StandardAccountBinding()),

    GetPage(
      name: Routes.accountCreatedScreen,
      page: () => const AccountCreatedScreen(),
    ),
    GetPage(
        name: Routes.happyHourFilterScreen,
        page: () => const HappyHourFilterScreen(),
        binding: HappyHourFilterScreenBinding()),
    GetPage(
        name: Routes.happyHourMapScreen,
        page: () => const HappyHourMapScreen(),
        binding: HappyHourMapScreenBinding()),
    GetPage(
        name: Routes.addHappyHourBusinessScreen,
        page: () => const AddHappyHourBusinessScreen(),
        binding: AddHappyHourBusinessBinding()),

    GetPage(
      name: Routes.addHappyHourBusinessDetailScreen,
      page: () => const AddHappyHourBusinessDetailScreen(),
      binding: AddHappyHourBusinessDetailBinding(),
    ),
    GetPage(
      name: Routes.addHappyHourFoodItemScreen,
      page: () => const AddHappyHourFoodItemScreen(),
      binding: AddHappyHourFoodItemScreenBinding(),
    ),
    GetPage(
      name: Routes.addHappyHourDrinksScreen,
      page: () => const AddHappyHourDrinksScreen(),
      binding: AddHappyHOurDrinksScreenBinding(),
    ),
    GetPage(
      name: Routes.addHappyHourAmenitiesScreen,
      page: () => const AddHappyHourAmenitiesScreen(),
      binding: AddHappyHourAmenitiesBinding(),
    ),
    GetPage(
      name: Routes.addHappyHourBarTypeScreen,
      page: () => const AddHappyHourBarTypeScreen(),
      binding: AddHappyHourBarTypeBinding(),
    ),
    GetPage(
        name: Routes.addHappyDailySpecialScreen,
        page: () => const AddHappyDailySpecialScreen(),
        binding: AddHappyDailySpecialBinding()),
    GetPage(
      name: Routes.addHappyHourEventsScreen,
      page: () => const AddHappyHourEventsScreen(),
      binding: AddHappyHourEventsBinding(),
    ),
    GetPage(
      name: Routes.addHappyHourRequestSubmittedScreen,
      page: () => const AddHappyHourRequestSubmittedScreen(),
    ),
    GetPage(
      name: Routes.claimYourBusinessScreen,
      page: () => const ClaimYourBusinessScreen(),
      binding: ClaimYourBusinessScreenBinding(),
    ),
    GetPage(
      name: Routes.editHappyHourScreen,
      page: () => const EditHappyHourScreen(),
      binding: EditHappyHourScreenBinding(),
    ),
    GetPage(
      name: Routes.privacyPolicyScreen,
      page: () => const PrivacyPolicyScreen(),
      binding: PrivacyPolicyScreenBinding(),
    ),
    GetPage(
      name: Routes.reviewScreen,
      page: () => const ReviewScreen(),
      binding: ReviewBinding(),
    ),
    GetPage(
      name: Routes.favoritesScreen,
      page: () => const FavoritesScreen(),
      binding: FavoriteBinding(),
    ),
    GetPage(
      name: Routes.myProfileScreen,
      page: () => const MyProfileScreen(),
      binding: MyProfileBinding(),
    ),
    GetPage(
      name: Routes.notificationScreen,
      page: () => const NotificationScreen(),
    ),
    GetPage(
      name: Routes.packagesScreen,
      page: () => const PackagesScreen(),
      binding: PackagesScreenBinding(),
    ),
    GetPage(
      name: Routes.checkOutScreen,
      page: () => const CheckOutScreen(),
      binding: CheckOutScreenBinding(),
    ),
    GetPage(
      name: Routes.paymentMethodScreen,
      page: () => const PaymentMethodScreen(),
      binding: PaymentMethodScreenBinding(),
    ),
    GetPage(
      name: Routes.paymentMethodrequestCompletedScreen,
      page: () => const PaymentMethodrequestCompletedScreen(),
    ),

    GetPage(
      name: Routes.paymentCardDetailScreen,
      page: () => const PaymentCardDetailScreen(),
      binding: PaymentCardDeatailScreenBinding(),
    ),
    GetPage(
      name: Routes.addReviewScreen,
      page: () => const AddReviewScreen(),
      binding: AddReviewBinding(),
    ),
    GetPage(
      name: Routes.reportScreen,
      page: () => const ReportScreen(),
      binding: ReportBinding(),
    ),
    GetPage(
      name: Routes.claimThisBusinessScreen,
      page: () => const ClaimThisBusinessScreen(),
      binding: ClaimThisBusinessBinding(),
    ),
    GetPage(
      name: Routes.addBusinessHourScreen,
      page: () => const AddBusinessHourScreen(),
      binding: AddBusinessHourBinding(),
    ),
    GetPage(
      name: Routes.happyHourEditScreen,
      page: () => const HappyHourEditScreen(),
      binding: HappyHourEditBinding(),
    ),
    GetPage(
        name: Routes.favoriteDetailScreen,
        page: () => const FavoriteDetailScreen(),
        binding: FavoriteDetailBindings()),

    GetPage(
        name: Routes.claimHappyHourDetailScreen,
        page: () => const ClaimHappyHourDetailScreen(),
        binding: ClaimHappyHourDetailBinding()),
    //Paid Screens
    GetPage(
      name: Routes.businessAccountHomeScreen,
      page: () => const BusinessAccountHomeScreen(),
      binding: BusinessAccountHomeBinding(),
    ),
    GetPage(
      name: Routes.loginHomeScreen,
      page: () => const LoginHomeScreen(),
      binding: LoginHomeBinding(),
    ),
    GetPage(
      name: Routes.addHappyHourBusinessAccountScreen,
      page: () => const AddHappyHourBusinessAccountScreen(),
      binding: AddHappyHourBusinessAccountBinding(),
    ),
    GetPage(
      name: Routes.happyHourSearchResultScreen,
      page: () => const HappyHourSearchResultScreen(),
      binding: HappyHourSearchResultBinding(),
    ),
    GetPage(
      name: Routes.faqScreen,
      page: () => const FaqScreen(),
    ),
    GetPage(
      name: Routes.termOfUseScreen,
      page: () => const TermOfUseScreen(),
    ),
    GetPage(
      name: Routes.aboutUsScreen,
      page: () => const AboutUsScreen(),
    ),
    GetPage(
      name: Routes.claimBusinessHourScreen,
      page: () => const ClaimBusinessHourScreen(),
      binding: ClaimBusinessHourBindings(),
    ),
    GetPage(
      name: Routes.businessAmenitiesScreen,
      page: () => const BusinessAmenitiesScreen(),
      binding: BusinessAmenitiesBinding(),
    ),

    GetPage(
      name: Routes.businessBarTypeScreen,
      page: () => const BusinessBarTypeScreen(),
      binding: BusinessBarTypeBinding(),
    ),

    GetPage(
      name: Routes.businessDailySpecialScreen,
      page: () => const BusinessDailySpecialScreen(),
      binding: BusinessDailySpecialBinding(),
    ),

    GetPage(
      name: Routes.businessDayTimeScreen,
      page: () => const BusinessDayTimeScreen(),
      binding: BusinessDaytTimeBinding(),
    ),

    GetPage(
      name: Routes.businessDrinksScreen,
      page: () => const BusinessDrinksScreen(),
      binding: BusinessDrinksBinding(),
    ),

    GetPage(
      name: Routes.businessEventsScreen,
      page: () => const BusinessEventsScreen(),
      binding: BusinessEventsBinding(),
    ),
    GetPage(
      name: Routes.businessFoodItemScreen,
      page: () => const BusinessFoodItemScreen(),
      binding: BusinessFoodItemBinding(),
    ),
    GetPage(
      name: Routes.addBusinessRequestSubmittedScreen,
      page: () => const AddBusinessHappyHourRequestSubmittedScreen(),
    ),
    GetPage(
      name: Routes.businessFindYourHappyHourScreen,
      page: () => const BusinessFindYourHappyHourScreen(),
      binding: BusinessFindYourHappyHourScreenBinding(),
    ),
    GetPage(
      name: Routes.businessHappyHourDetailScreen,
      page: () => const BusinessHappyHourDetailScreen(),
      binding: BusinessHappyhourDetailScreenBindings(),
    ),

    GetPage(
      name: Routes.claimThisBusinessFormScreen,
      page: () => const ClaimThisBusinessFormScreen(),
      binding: ClaimThisBusinessFormBinding(),
    ),
    GetPage(
      name: Routes.businessDescriptionScreen,
      page: () => const BusinessDescriptionScreen(),
      binding: BusinessDescriptionBinding(),
    ),
    GetPage(
      name: Routes.duplicateBusinessAccountScreen,
      page: () => const DuplicateBusinessAccountScreen(),
      binding: DuplicateHappyhourBinding(),
    ),

    GetPage(
      name: Routes.replyScreen,
      page: () => const ReplyScreen(),
      binding: ReplyBinding(),
    ),
    GetPage(
        name: Routes.businessFilterScreen,
        page: () => const BusinessFilterScreen(),
        binding: BusinessFilterScreenBinding()),
    GetPage(
      name: Routes.businessSearchResultScreen,
      page: () => const BusinessSearchResultScreen(),
      binding: BusinessSearchResultBinding(),
    ),

//*Standard Screen
    GetPage(
      name: Routes.standardFindYourHappyHourScreen,
      page: () => const StandardFindYourHappyHourScreen(),
      binding: FindYourHappyHourScreenBindingStandard(),
    ),

    GetPage(
      name: Routes.standardHappyHourDetailScreen,
      page: () => const StandardHappyHourDetailScreen(),
      binding: StandardHappyhourDetailScreenBindings(),
    ),

    GetPage(
      name: Routes.standardRequestSubmitted,
      page: () => const StandardRequestSubmitted(),
    ),
    GetPage(
      name: Routes.mapScreen,
      page: () => const MapScreen(),
      binding: MapBinding(),
    ),
    GetPage(
      name: Routes.claimedScreen,
      page: () => const ClaimedScreen(),
      binding: ClaimedBinding(),
    ),

    //=======* Edit Screenss ===============*//
    GetPage(
      name: Routes.editAccountScreen,
      page: () => const EditAccountScreen(),
      binding: EditAccountBinding(),
    ),

    GetPage(
      name: Routes.editDescriptionScreen,
      page: () => const EditDescriptionScreen(),
      binding: EditDescriptionBinding(),
    ),

    GetPage(
      name: Routes.editHourScreen,
      page: () => const EditHourScreen(),
      binding: EditHourBinding(),
    ),
    GetPage(
      name: Routes.editFoodItemScreen,
      page: () => const EditFoodItemScreen(),
      binding: EditFoodItemBinding(),
    ),
    GetPage(
      name: Routes.editDrinksScreen,
      page: () => EditDrinksScreen(),
      binding: EditDrinksBinding(),
    ),
    GetPage(
      name: Routes.editAmenitiesScreen,
      page: () => const EditAmenitiesScreen(),
      binding: EditAmenitiesBinding(),
    ),
    GetPage(
      name: Routes.editBarTypeScreen,
      page: () => const EditBarTypeScreen(),
      binding: EditBarTypeBinding(),
    ),
    GetPage(
      name: Routes.editDailySpecialScreen,
      page: () => const EditDailySpecialScreen(),
      binding: EditDailySpecialBinding(),
    ),
    GetPage(
      name: Routes.editDayTimeScreen,
      page: () => const EditDayTimeScreen(),
      binding: EditDaytTimeBinding(),
    ),
    GetPage(
      name: Routes.editEventsScreen,
      page: () => const EditEventsScreen(),
      binding: EditEventsBinding(),
    ),

    GetPage(
      name: Routes.editDetailScreen,
      page: () => const EditDetailScreen(),
      binding: EditDetailScreenBindings(),
    ),

    //=======* Duplicate Screenss ===============*//

    GetPage(
      name: Routes.duplicateBusinessHourScreen,
      page: () => const DuplicateBusinessHourScreen(),
      binding: DuplicateBusinessHourBinding(),
    ),
    GetPage(
      name: Routes.duplicateDescriptionScreen,
      page: () => const DuplicateDescriptionScreen(),
      binding: DuplicateDescriptionBinding(),
    ),
    GetPage(
      name: Routes.duplicateFoodItemScreen,
      page: () => const DuplicateFoodItemScreen(),
      binding: DuplicateFoodItemBinding(),
    ),
    GetPage(
      name: Routes.duplicateDrinksScreen,
      page: () => const DuplicateDrinksScreen(),
      binding: DuplicateDrinksBinding(),
    ),
    GetPage(
      name: Routes.duplicateAmenitiesScreen,
      page: () => const DuplicateAmenitiesScreen(),
      binding: DuplicateAmenitiesBinding(),
    ),
    GetPage(
      name: Routes.duplicateBarTypeScreen,
      page: () => const DuplicateBarTypeScreen(),
      binding: DupliacteBarTypeBinding(),
    ),
    GetPage(
      name: Routes.duplicateDailySpecialScreen,
      page: () => const DuplicateDailySpecialScreen(),
      binding: DuplicateDailySpecialBinding(),
    ),
    GetPage(
      name: Routes.duplicateDayTimeScreen,
      page: () => const DuplicateDayTimeScreen(),
      binding: DuplicateDayTimeBinding(),
    ),
    GetPage(
      name: Routes.duplicateEventsScreen,
      page: () => const DuplicateEventsScreen(),
      binding: DuplicateEventsBinding(),
    ),
    GetPage(
      name: Routes.duplicatePackagesScreen,
      page: () => const DuplicatePackagesScreen(),
      // binding: DuplicateEventsBinding(),
    ),

    //=======* Claim Screenss ===============*//
    GetPage(
      name: Routes.happyHourClaimScreen,
      page: () => const HappyHourClaimScreen(),
      binding: ClaimAccountBinding(),
    ),

    GetPage(
      name: Routes.claimAccountScreen,
      page: () => const ClaimAccountScreen(),
      binding: ClaimAccountBinding(),
    ),
    GetPage(
      name: Routes.claimHourScreen,
      page: () => const ClaimHourScreen(),
      binding: ClaimHourBinding(),
    ),
    GetPage(
      name: Routes.claimFoodItemScreen,
      page: () => const ClaimFoodItemScreen(),
      binding: ClaimFoodItemBinding(),
    ),
    GetPage(
      name: Routes.claimDrinksScreen,
      page: () => const ClaimDrinksScreen(),
      binding: ClaimDrinksBinding(),
    ),
    GetPage(
      name: Routes.claimAmenitiesScreen,
      page: () => const ClaimAmenitiesScreen(),
      binding: ClaimAmenitiesBinding(),
    ),
    GetPage(
      name: Routes.claimBarTypeScreen,
      page: () => const ClaimBarTypeScreen(),
      binding: ClaimBarTypeBinding(),
    ),
    GetPage(
      name: Routes.claimDailySpecialScreen,
      page: () => const ClaimDailySpecialScreen(),
      binding: ClaimDailySpecialBinding(),
    ),
    GetPage(
      name: Routes.claimDayTimeScreen,
      page: () => const ClaimDayTimeScreen(),
      binding: ClaimDaytTimeBinding(),
    ),
    GetPage(
      name: Routes.claimEventsScreen,
      page: () => const ClaimEventsScreen(),
      binding: ClaimEventsBinding(),
    ),
    GetPage(
      name: Routes.claimPackagesScreen,
      page: () => const ClaimPackagesScreen(),
      // binding: DuplicateEventsBinding(),
    ),

    //=======* AddHappyHOur For Guest Screenss ===============*//
    GetPage(
      name: Routes.guestAmenitiesScreen,
      page: () => const GuestAmenitiesScreen(),
      binding: GuestAmenitiesBinding(),
    ),

    GetPage(
      name: Routes.guestBarTypeScreen,
      page: () => const GuestBarTypeScreen(),
      binding: GuestBarTypeBinding(),
    ),

    GetPage(
      name: Routes.guestDailySpecialScreen,
      page: () => const GuestDailySpecialScreen(),
      binding: GuestDailySpecialBinding(),
    ),
    GetPage(
      name: Routes.guestDrinksScreen,
      page: () => const GuestDrinksScreen(),
      binding: GuestDrinksBinding(),
    ),
    GetPage(
      name: Routes.guestEventsScreen,
      page: () => const GuestEventsScreen(),
      binding: GuestEventsBinding(),
    ),
    GetPage(
      name: Routes.guestFoodItemScreen,
      page: () => const GuestFoodItemScreen(),
      binding: GuestFoodItemBinding(),
    ),
    GetPage(
      name: Routes.guestDayTimeScreen,
      page: () => const GuestDayTimeScreen(),
      binding: GuestDaytTimeBinding(),
    ),

    GetPage(
      name: Routes.guestFormScreen,
      page: () => const GuestFormScreen(),
      binding: GuestFormBinding(),
    ),
    GetPage(
      name: Routes.guestBarTypeScreen,
      page: () => const GuestBarTypeScreen(),
      binding: GuestBarTypeBinding(),
    ),
    GetPage(
      name: Routes.guestAmenitiesScreen,
      page: () => const GuestAmenitiesScreen(),
      binding: GuestAmenitiesBinding(),
    ),

    GetPage(
      name: Routes.subcriptionScreen,
      page: () => const SubcriptionScreen(),
      binding: SubcriptionBinding(),
    ),
    GetPage(
      name: Routes.subcriptionDetail,
      page: () => const SubcriptionDetail(),
      binding: SubcriptionDetailBinding(),
    ),

    GetPage(
      name: Routes.checkOutClaimScreen,
      page: () => const CheckOutClaimScreen(),
      binding: CheckOutClaimScreenBinding(),
    ),
  ];
}
