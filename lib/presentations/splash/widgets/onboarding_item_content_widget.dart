import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_place/core/constants/padding_constant.dart';
import 'package:market_place/core/utils/variable.dart';
import 'package:market_place/presentations/auth/views/login_page.dart';
import 'package:market_place/presentations/auth/views/verify_otp_page.dart';
import 'package:market_place/presentations/splash/controller/splash_controller.dart';
import 'package:market_place/presentations/splash/controller/splash_controller.dart';
import 'package:market_place/presentations/splash/controller/splash_controller.dart';
import 'package:market_place/presentations/splash/controller/splash_controller.dart';

import '../../../core/components/custom_button.dart';
import '../../../core/components/custom_textfield.dart';
import '../../../core/constants/app_static_strings.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/constants/custom_space.dart';
import '../../../core/constants/custom_text.dart';
import '../../../core/constants/fontsize_constant.dart';
import '../../../core/constants/text_style_constant.dart';
import '../../../core/utils/hive_boxes.dart';
class OnboardingItemContentWidget extends StatelessWidget {
  final OnboardingModel onboardingModel;
  const OnboardingItemContentWidget({
    super.key,
    required this.onboardingModel,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        onboardingModel.backgroundImgUrl != null
            ? Image.asset(
          onboardingModel.backgroundImgUrl ?? '',
          fit: BoxFit.cover,
        )
            : SizedBox.shrink(),
        Column(
          // spacing: 12.h ,
          children: [
            SizedBox(
              height:
              MediaQuery.of(context).viewPadding.top /*+ kToolbarHeight*/,
            ),

            onboardingModel.frontImgUrl != null
                ? Expanded(
                child: Padding(
                  padding: padding16V,
                  child: Image.asset(
                    onboardingModel.frontImgUrl ?? '',
                  ),
                ))
                : Spacer(),
            Padding(
              padding: padding16H,
              child: CustomText(
                textAlign: TextAlign.center,
                text: onboardingModel.message,
                style: poppinsSemiBold,
                fontSize: getFontSizeExtraLarge(),
              ),
            ),
            space16H,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10.w,
              children: List.generate(
                onboardingData.length,
                    (index) => Obx(() {
                  return Container(
                    height: 4,
                    width: 20.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.r),
                        color:
                        SplashController.to.currentIndex.value == index
                            ? AppColors.kPrimaryColor
                            : AppColors.kTextColor.withValues(alpha: .3)),
                  );
                }),
              ),
            ),
            space16H,
            Padding(
              padding: padding16H,
              child: CustomButton(
                title: 'intro.button'.tr,
                onTap: () {
                  if (SplashController.to.currentIndex.value <
                      onboardingData.length - 1) {
                    SplashController.to.pageController!.value.animateToPage(
                        SplashController.to.currentIndex.value + 1,
                        duration: Duration(milliseconds: 300),
                        curve: Easing.linear);

                  } else {
                    Boxes.getUserData().put(initialKey, true);
                  }
                },
              ),
            ),
            space16H,
          ],
        ),
      ],
    );
  }
}
