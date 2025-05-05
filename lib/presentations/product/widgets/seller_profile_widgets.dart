import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:market_place/core/components/custom_button.dart';
import 'package:market_place/core/constants/color_constants.dart';
import 'package:market_place/core/constants/custom_text.dart';
import 'package:market_place/core/constants/image_constants.dart';
import 'package:market_place/core/constants/padding_constant.dart';
import 'package:market_place/core/constants/text_style_constant.dart';
import 'package:market_place/presentations/home/widgets/product_card_item_widget.dart';
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
            onTap: () {},
            title: "Call Now",
          ),
        ),
        Expanded(
          child: CustomButton(
            prefixWidget: Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: SvgPicture.asset(chatIcon),
            ),
            onTap: () {
              NavigationController.to.selectedNavIndex.value = 3;
              Get.toNamed(NavigationPage.routeName);
            },
            title: "Chat Now",
          ),
        ),
      ],
    );
  }
}

class SellerRatingWidget extends StatelessWidget {
  const SellerRatingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 70.w,
      child: GreenAccentContainerWidget(
        color: AppColors.kYellowColor,
        radius: 4.r,
        child: Padding(
          padding: padding2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 4.w,
            children: [
              Icon(
                Icons.star_rounded,
                color: AppColors.kYellowColor,
                size: 15.r,
              ),
              CustomText(
                text: "4.9",
                style: poppinsSemiBold,
                fontSize: 10.sp,
                color: AppColors.kYellowColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}