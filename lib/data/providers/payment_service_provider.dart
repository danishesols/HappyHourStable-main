

// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';

// class PaymentServiceProvider {
//   final dio = Dio();

//   Future<bool> makePayment() async {
//     try {
//       dio.options.headers['content-Type'] = 'application/json';
//       var response = await dio.get(
//           "https://us-central1-coupon-f14bf.cloudfunctions.net/stripePayment");

//       Map<String, dynamic>? paymentIntentData = response.data;

//       await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           paymentIntentClientSecret: paymentIntentData!["paymentIntent"],
//           applePay: true,
//           googlePay: true,
//           style: ThemeMode.dark,
//           merchantCountryCode: "US",
//           merchantDisplayName: "ESOLS Technologies",
//         ),
//       );

//       await Stripe.instance.presentPaymentSheet(
//         parameters: PresentPaymentSheetParameters(
//           clientSecret: paymentIntentData["paymentIntent"],
//           confirmPayment: true,
//         ),
//       );

//       return true;
//     } catch (e) {
//       if (kDebugMode) {
//         print(e);
//       }

//       return false;
//     }
//   }

//   subscribe({required String email}) async {
//     // HttpsCallable callable;

//     // callable = FirebaseFunctions.instance.httpsCallable('checkout');

//     // final response = await callable();

//     // if (kDebugMode) {
//     //   print(response.data);
//     // }

//     // callable = FirebaseFunctions.instance.httpsCallable('createPaymentMethod');

//     // final response = await callable();

//     // if (kDebugMode) {
//     //   print(response.data);
//     // }

//     // callable = FirebaseFunctions.instance.httpsCallable('createPaymentMethod');

//     // final response = await callable();

//     // if (kDebugMode) {
//     //   print(response.data);
//     // }

//     // callable = FirebaseFunctions.instance.httpsCallable('registerCustomer');

//     // final response2 = await callable.call({
//     //   "email": email,
//     //   "payment_method_id": response.data["id"],
//     // });

//     // if (kDebugMode) {
//     //   print(response2.data);
//     // }

//     // callable = FirebaseFunctions.instance.httpsCallable('subscribe');

//     // final response3 = await callable.call({
//     //   "customer_id": "cus_L4mpbUQJ34rPBW",
//     //   "payment_method_id": "pm_1KOdFPKsz4NtnSwNO4NCKSNM",
//     // });

//     // if (kDebugMode) {
//     //   print(response3.data);
//     // }

//     // callable = FirebaseFunctions.instance.httpsCallable('retrieveSubscription');

//     // final response4 = await callable.call({
//     //   "subscription_id": "sub_1KOdZXKsz4NtnSwNQHda137g",
//     // });

//     // if (kDebugMode) {
//     //   print(response4.data["status"]);
//     // }

//     // callable = FirebaseFunctions.instance.httpsCallable('cancelSubscription');

//     // final response5 = await callable.call({
//     //   "subscription_id": "sub_1KOdSqKsz4NtnSwNcPACUzSL",
//     // });

//     // if (kDebugMode) {
//     //   print(response5.data);
//     // }
//   }
// }
