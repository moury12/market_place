import 'dart:ui';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:market_place/core/utils/variable.dart';

import '../services/app_strings.dart';

class CommonController extends GetxController{
 static  CommonController get to =>Get.find();
  RxString selectedLanguageCode = 'fr'.obs;
 late Box settingsBox;
 Future<void> initHive() async {
  // Check if box is already open to avoid errors
  if (!Hive.isBoxOpen(settingBox)) {
   settingsBox = await Hive.openBox(settingBox);
  } else {
   settingsBox = Hive.box(settingBox);
  }
 }

 // // Load saved language preference from Hive
 // Future<void> loadSavedLanguage() async {
 //  // Get language from Hive with 'en' as default
 //  final savedLang = settingsBox.get(languageKey, defaultValue: 'en');
 //  selectedLanguageCode.value = savedLang;
 //  await changeLanguage(savedLang);
 // }
 Future<void> changeLanguage(Locale locale) async {
  // Update the language code
  // selectedLanguageCode.value = langCode;



  // // Get translations instance
  // final translations = Get.find<AppTranslations>();
  //
  // // Ensure translations for this language are loaded
  // if ((translations.keys[langCode] ?? {}).isEmpty) {
  //  final loadedTranslations = await translations.loadLanguage(langCode);

   // Add translations to GetX system
   Get.updateLocale(locale);
   // _locale = locale;
   // saveLanguage(_locale);
   update();// Updates GetBuilder widgets
   Get.forceAppUpdate();
  }

  // Update locale
  // Get.updateLocale(Locale(langCode));
 }


