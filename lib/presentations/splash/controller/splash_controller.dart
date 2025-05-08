import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_place/presentations/splash/views/onboarding_page.dart';

import '../../../core/api-client/api_service.dart';
import '../../../core/utils/hive_boxes.dart';
import '../../../core/utils/variable.dart';
import '../../auth/views/login_page.dart';
import '../../navigation/views/navigation_page.dart';

class SplashController extends GetxController {
  static SplashController get to => Get.find();
  Rx<PageController>? pageController;
  RxInt currentIndex = 0.obs;
  @override
  void onInit() {
    pageController = PageController(initialPage: currentIndex.value).obs;
    Future.delayed(Duration(seconds: 3), () {
      if (Boxes.getUserData().get(tokenKey) == null ||
          Boxes.getUserData().get(tokenKey).toString().isEmpty) {
        Get.offAllNamed(LoginPage.routeName);
      } else if (Boxes.getUserData().get(initialKey) == null ||
          Boxes.getUserData().get(initialKey).toString().isEmpty||
          Boxes.getUserData().get(initialKey) != true) {
        Get.offAllNamed(OnboardingPage.routeName);
      } else {
        ApiService().setAuthToken(
          Boxes.getUserData().get(tokenKey).toString(),
        );
        Get.offAllNamed(NavigationPage.routeName);
      }
    });
    super.onInit();
  }
}
