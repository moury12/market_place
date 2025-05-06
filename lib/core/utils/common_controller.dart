import 'dart:ui';

import 'package:get/get.dart';
import 'package:market_place/core/utils/variable.dart';

import 'hive_boxes.dart';

class CommonController extends GetxController {
 static CommonController get to => Get.find();

 final RxString selectedLanguageCode = 'en'.obs;

 @override
 void onInit() {
  super.onInit();
  selectedLanguageCode.value = Boxes.getSettingsData().get(
      languageKey,
      defaultValue: 'en'
  );
 }

 Future<void> changeLanguage(Locale locale) async {
  selectedLanguageCode.value = locale.languageCode;
  await Boxes.getSettingsData().put(languageKey, locale.languageCode);
  Get.updateLocale(locale);
  logger.d("Updated locale to: ${Get.locale?.languageCode}");
// This forces the entire app to rebuild
 }
}


