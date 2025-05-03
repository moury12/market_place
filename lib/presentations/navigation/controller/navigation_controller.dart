import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_place/core/constants/app_static_strings.dart';
import 'package:market_place/core/constants/image_constants.dart';
import 'package:market_place/presentations/home/controller/home_controller.dart';
import 'package:market_place/presentations/message/controllers/message_controller.dart';
import 'package:market_place/presentations/message/views/message_page.dart';
import 'package:market_place/presentations/my-listings/views/my-listings_page.dart';

import '../../home/views/home_page.dart';

class NavigationController extends GetxController {
  static NavigationController get to => Get.find();
  RxInt selectedNavIndex = 0.obs;

  List<Widget> getPages() {
    return [HomePage(),MyListingsPage(),HomePage(),MessageListPage(),HomePage(),];
  }
  List<String> appbarTitle= [
    AppStaticStrings.myListings,
    AppStaticStrings.myListings,
    AppStaticStrings.orders,
    AppStaticStrings.notifications,
  ];
@override
  void onInit() {
  Get.put(HomeController());
  Get.put(MessageController());
    super.onInit();
  }
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
