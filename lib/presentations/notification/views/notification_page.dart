import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:market_place/core/components/custom_appbar.dart';
import 'package:market_place/core/constants/app_static_strings.dart';
import 'package:market_place/core/constants/color_constants.dart';
import 'package:market_place/core/constants/image_constants.dart';
import 'package:market_place/core/constants/text_style_constant.dart';

import '../../../core/constants/custom_text.dart';
import '../../../core/constants/padding_constant.dart';

class NotificationPage extends StatelessWidget {
  static const String routeName = "/notification";
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomDefaultAppbar(title: AppStaticStrings.notifications),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: padding12,
          child: Column(
            spacing: 8.h,
            children: List.generate(
              10,
              (index) => Container(
                padding: padding12H,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: AppColors.kWhiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: .1),
                      blurRadius: 12.r,
                    ),
                  ],
                ),
                child: Padding(
                  padding: padding6V,
                  child: Row(
                    spacing: 8.w,
                    children: [
                      SvgPicture.asset(logoIcon, height: 40.w),

                      ///------------------------dynamic title-------------------------///
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Listing Marked as Sold",
                              style: poppinsSemiBold,
                            ),
                            CustomText(
                              text:
                                  "You marked “Wooden Dining Table” as sold. Congrats on the successful sale!",
                              style: poppinsRegular,
                              color: AppColors.kExtraLightGreyTextColor,
                              fontSize: 10.sp,
                            ),
                          ],
                        ),
                      ),
                      // CustomText(
                      //   text: NotificationController.to.formatDate(NotificationController.to.notificationList[index].updatedAt.toString()),
                      //   style: poppinsLight,
                      //   fontSize: getFontSizeSmall(),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
