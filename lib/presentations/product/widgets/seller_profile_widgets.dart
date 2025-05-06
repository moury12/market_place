import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:market_place/core/components/custom_button.dart';
import 'package:market_place/core/constants/app_static_strings.dart';
import 'package:market_place/core/constants/image_constants.dart';
import 'package:market_place/core/helper/helper_function.dart';
import 'package:market_place/presentations/navigation/controller/navigation_controller.dart';
import 'package:market_place/presentations/navigation/views/navigation_page.dart';
class CallAndChatButtons extends StatelessWidget {
  const CallAndChatButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8.w,
      children: [
        Expanded(
          child: CustomButton(
            prefixWidget: Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: SvgPicture.asset(callIcon),
            ),
            onTap: () {
              callOnPhone(phoneNumber: "01716");
            },
            title: AppStaticStrings.cancel.tr,
          ),
        ),
        Expanded(
          child: CustomButton(
            prefixWidget: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: SvgPicture.asset(chatIcon),
            ),
            onTap: () {
              NavigationController.to.selectedNavIndex.value = 3;
              Get.toNamed(NavigationPage.routeName);
            },
            title: AppStaticStrings.chatNow.tr,
          ),
        ),
      ],
    );
  }
}

