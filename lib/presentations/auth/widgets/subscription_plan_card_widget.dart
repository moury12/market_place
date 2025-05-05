import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_place/core/components/custom_button.dart';
import 'package:market_place/core/constants/color_constants.dart';
import 'package:market_place/core/constants/custom_text.dart';
import 'package:market_place/core/constants/fontsize_constant.dart';
import 'package:market_place/core/constants/text_style_constant.dart';
import 'package:market_place/core/utils/variable.dart';

import '../../../core/constants/padding_constant.dart';class SubscriptionPlanWidget extends StatelessWidget {
  final bool isYear;
  const SubscriptionPlanWidget({
    super.key,  this.isYear =false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding12V.copyWith(top: 0),
      child: Container(
        padding: padding16,
        decoration: BoxDecoration(
          color: AppColors.kWhiteColor,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .1),
              blurRadius: 16.r,
            ),
          ],
        ),
        child: Column(
          spacing: 8.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text:isYear?"Yearly Plan": "Monthly Plan",
                  style: poppinsSemiBold,
                  fontSize: getFontSizeDefault(),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 4.w),
                  decoration: BoxDecoration(
                    color: AppColors.kPrimaryDarkColor.withValues(alpha: .1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: CustomText(
                    text:isYear?"Save 20%": "Popular",
                    color: AppColors.kPrimaryDarkColor,
                    fontSize: getFontSizeSmall(),
                  ),
                ),
              ],
            ),
            CustomText(
              text: "UM 2.99 /month",
              style: poppinsBold,
              color: AppColors.kPrimaryColor,
              fontSize: getButtonFontSizeLarge(),
            ), CustomText(
              text: dummyDesc,

              fontSize: getFontSizeSmall(),
            ),
            CustomButton(onTap: () {

            },title: "Subscribe Now",)
          ],
        ),
      ),
    );
  }
}
