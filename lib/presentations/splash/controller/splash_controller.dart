import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController{
  static SplashController get to => Get.find();
  Rx<PageController>? pageController;
  RxInt currentIndex = 0.obs;
  @override
  void onInit() {
    pageController = PageController(initialPage: currentIndex.value).obs;
    super.onInit();
  }
}