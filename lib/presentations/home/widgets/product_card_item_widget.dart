import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_place/core/components/custom_network_image.dart';
import 'package:market_place/core/constants/app_static_strings.dart';
import 'package:market_place/core/constants/color_constants.dart';
import 'package:market_place/core/constants/custom_text.dart';
import 'package:market_place/core/constants/fontsize_constant.dart';
import 'package:market_place/core/constants/padding_constant.dart';
import 'package:market_place/core/constants/text_style_constant.dart';
import 'package:market_place/core/utils/variable.dart';

class ProductCardItemWidget extends StatelessWidget {
  const ProductCardItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding4,
      decoration: BoxDecoration(
        color: AppColors.kWhiteColor,
        borderRadius: BorderRadius.circular(4.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .1),
            blurRadius: 24.r,
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Stack(
              children: [
                CustomNetworkImage(
                  imageUrl: imageUrl,
                  height: 150.w,
                  radius: 4.r,
                ),
                Positioned(
                  bottom: 10,left: 6,
                  child: GreenAccentContainerWidget(child: CustomText(
                    text: "New",
                    style: poppinsSemiBold,
                    color: AppColors.kPrimaryColor,
                    fontSize: getFontSizeSmall(),
                  ),),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: padding4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: AppStaticStrings.productCategories * 2,
                    maxLines: 2,
                    style: poppinsSemiBold,
                  ),
                  CustomText(
                    text: "Premium support",
                    maxLines: 2,
                    style: poppinsRegular,
                    color: AppColors.kExtraLightTextColor,
                  ),
                  CustomText(
                    text: "UM 49.99",
                    maxLines: 2,
                    style: poppinsMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GreenAccentContainerWidget extends StatelessWidget {
  final Widget child;
  const GreenAccentContainerWidget({
    super.key, required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w
      ),
      decoration: BoxDecoration(
        color: AppColors.kPrimaryAccentColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          width: .5,
          color: AppColors.kPrimaryColor,
        ),
      ),
      child: child,
    );
  }
}