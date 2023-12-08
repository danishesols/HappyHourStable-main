import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:happy_hour_app/core/constants.dart';
import 'package:happy_hour_app/firebase_options.dart';
import 'package:happy_hour_app/logger.dart';
import 'package:happy_hour_app/screens/account_business/claim_report/clain_controller.dart';
import 'package:happy_hour_app/utils/app_translation.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'screens/splash/splash_screen_binding.dart';

// stable git

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await defaultAppSettings();
  runApp(const MyApp());
}

defaultAppSettings() async {
  // * initialize Get Storage service.
  await GetStorage.init();
  GetStorage box = GetStorage();
  // * make it true for first time, after showing intro screen make it false for forever.
  box.writeIfNull(showstartedScreen, true);
  // * make login screen's remember me false by default.
  box.writeIfNull(loginRememberMeStatus, false);
  Get.lazyPut(() => ClaimReportController());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: AppTranslations(),
      title: 'Happy Hour App',
      debugShowCheckedModeBanner: false,

      builder: (context, widget) {
        return ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget!),
          maxWidth: 1200,
          minWidth: 320,
          defaultName: MOBILE,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(320, name: MOBILE, scaleFactor: 0.9),
            const ResponsiveBreakpoint.resize(480, name: MOBILE),
            const ResponsiveBreakpoint.resize(600, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(850, name: TABLET),
            const ResponsiveBreakpoint.resize(1080, name: DESKTOP),
          ],
        );
      },
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      getPages: AppPages.pages,
      initialRoute: Routes.initialSplash,
      initialBinding: SplashBinding(),
      defaultTransition: Transition.fade,
      enableLog: true,
      logWriterCallback: Logger.write,
    );
  }
}
