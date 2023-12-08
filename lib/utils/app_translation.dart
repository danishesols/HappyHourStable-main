import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          "enter name": "name",
        },
        'ur_PK': {'enter email': ''}
      };
}

class LocalLanguageStorage {
  /// Write
  void saveLangToDisk(String language) async {
    await GetStorage().write("Language", language);
  }

  /// Read
  Future<dynamic> get languageSelected async {
    return await GetStorage().read("Language");
  }
}

class AppLanguagesController extends GetxController {
  var appLocale = "English";
  var selectedLang = 'Deutsch';

  @override
  void onInit() async {
    LocalLanguageStorage languageStorage = LocalLanguageStorage();
    appLocale = await languageStorage.languageSelected;
    update();
    Get.updateLocale(Locale(appLocale));
    super.onInit();
  }

  void changeLanguage(String type) async {
    LocalLanguageStorage languageStorage = LocalLanguageStorage();
    if (appLocale == type) {
      return;
    }
    if (type == "Deutsch") {
      appLocale = "Deutsch";
      languageStorage.saveLangToDisk("Deutsch");
    } else {
      appLocale = "English";
      languageStorage.saveLangToDisk("English");
    }
  }
}

class LanguageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppLanguagesController());
  }
}
