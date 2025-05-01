import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_place/core/constants/app_static_strings.dart';
import 'package:market_place/core/constants/image_constants.dart';

class NavigationControllerMain extends GetxController {
  static NavigationControllerMain get to => Get.find();
  RxInt selectedNavIndex = 0.obs;

  final List<Widget> screens = [
    const Center(child: Text('Home Screen')),
    const Center(child: Text('My Listings Screen')),
    const Center(child: Text('Sell Now Screen')),
    const Center(child: Text('Messages Screen')),
    const Center(child: Text('Profile Screen')),
  ];

  // List of icons for the navigation bar
  final List<String> icons = [navHomeIcon, navListingIcon, navSellNowIcon, navMessageIcon, navProfileIcon];

  // List of labels for the navigation bar
  final List<String> labels = [
    AppStaticStrings.home,
    AppStaticStrings.myListings,
    AppStaticStrings.sellNow,
    AppStaticStrings.messages,
    AppStaticStrings.profile,
  ];
}
