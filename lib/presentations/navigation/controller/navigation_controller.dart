import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_place/core/constants/app_static_strings.dart';
import 'package:market_place/core/constants/image_constants.dart';

import '../../home/views/home_page.dart';

class NavigationControllerMain extends GetxController {
  static NavigationControllerMain get to => Get.find();
  RxInt selectedNavIndex = 0.obs;

  List<Widget> getPages() {
    return [HomePage(),HomePage(),HomePage(),HomePage(),HomePage(),];
  }
  List<String> appbarTitle= [
    AppStaticStrings.addToCard,
    AppStaticStrings.orders,
    AppStaticStrings.notifications,
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
