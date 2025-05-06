import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_place/core/components/custom_button_tap.dart';
import 'package:market_place/core/components/custom_network_image.dart';
import 'package:market_place/core/constants/app_static_strings.dart';
import 'package:market_place/core/constants/color_constants.dart';
import 'package:market_place/core/constants/custom_text.dart';
import 'package:market_place/core/constants/fontsize_constant.dart';
import 'package:market_place/core/constants/padding_constant.dart';
import 'package:market_place/core/constants/text_style_constant.dart';
import 'package:market_place/core/utils/variable.dart';
import 'package:market_place/presentations/product/views/product_details_page.dart';

class ProductCardItemWidget extends StatelessWidget {
  final bool fromSeller;

  const ProductCardItemWidget({
    super.key,  this.fromSeller =false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(

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
      child: ButtonTapWidget(
        radius: 4.r,
        onTap: () {
          Get.toNamed(ProductDetailsPage.routeName, arguments: fromSeller);
        },
        child: Padding(
          padding: padding4,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    CustomNetworkImage(
                      imageUrl: imageUrl,
                      // height: 150.w,
                      radius: 4.r,
                    ),
                    Positioned(
                      bottom: 10,left: 6,
                      child: GreenAccentContainerWidget(child: CustomText(
                        text: AppStaticStrings.newLabel.tr,
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
                        text: AppStaticStrings.productCategories.tr * 2,
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
        ),
      ),
    );
  }
}
class ProductGridWidget extends StatelessWidget {
  final bool fromSeller;
  const ProductGridWidget({

    super.key,  this.fromSeller=false,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      primary: false,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        crossAxisSpacing: 8.w,
        mainAxisSpacing: 12.w,
        mainAxisExtent: 265.w,
        // childAspectRatio: .5,
        maxCrossAxisExtent: 210.w,
      ),
      itemBuilder:
          (context, index) => ProductCardItemWidget(fromSeller: fromSeller,),
    );
  }
}

class GreenAccentContainerWidget extends StatelessWidget {
  final Widget child;
  final double? radius;
  final Color? color;
  const GreenAccentContainerWidget({
    super.key, required this.child, this.radius, this.color=AppColors.kPrimaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w
      ),
      decoration: BoxDecoration(
        color: color!.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(radius??radiusCommon),
        border: Border.all(
          width: .5,
          color: color!,
        ),
      ),
      child: child,
    );
  }
}