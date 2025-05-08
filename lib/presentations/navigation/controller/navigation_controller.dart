import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_place/core/constants/image_constants.dart';
import 'package:market_place/presentations/home/controller/home_controller.dart';
import 'package:market_place/presentations/message/controllers/message_controller.dart';
import 'package:market_place/presentations/message/views/message_page.dart';
import 'package:market_place/presentations/my-listings/views/my-listings_page.dart';
import 'package:market_place/presentations/profile/controllers/account_information_controller.dart';
import 'package:market_place/presentations/profile/views/profile_page.dart';
import 'package:market_place/presentations/sell-now/controller/sell_controller.dart';
import 'package:market_place/presentations/sell-now/views/sell_now_page.dart';

import '../../../core/api-client/api_endpoints.dart';
import '../../../core/api-client/api_service.dart';
import '../../../core/helper/helper_function.dart';
import '../../../core/utils/hive_boxes.dart';
import '../../../core/utils/variable.dart';
import '../../auth/views/login_page.dart';
import '../../home/views/home_page.dart';

class NavigationController extends GetxController {
  static NavigationController get to => Get.find();
  RxInt selectedNavIndex = 0.obs;
  Rx<bool> isLoadingLogout = false.obs;

  List<Widget> getPages() {
    return [
      HomePage(),
      MyListingsPage(),
      SellNowPage(),
      MessageListPage(),
      ProfilePage(),
    ];
  }

  @override
  void onInit() {

    super.onInit();
  }

  // List of icons for the navigation bar
  final List<String> icons = [
    navHomeIcon,
    navListingIcon,
    navSellNowIcon,
    navMessageIcon,
    navProfileIcon,
  ];

  ///------------------------------ log out method -------------------------///

  Future<void> logoutRequest() async {
    try {
      isLoadingLogout.value = true;
      final response = await ApiService().request(
        endpoint: logoutEndPoint,
        method: 'POST',
      );
      isLoadingLogout.value = false;
      if (response['success'] == true) {
        logger.d(response);
        showCustomSnackbar(title: 'Success', message: response['message']);
        Boxes.getUserData().delete(tokenKey);
        Get.offAllNamed(LoginPage.routeName);
      } else {
        logger.e(response);
        showCustomSnackbar(
          title: 'Failed',
          message: response['message'],
          type: SnackBarType.failed,
        );
      }
    } catch (e) {
      logger.e(e.toString());
    }
  }
  // List of labels for the navigation bar
}
