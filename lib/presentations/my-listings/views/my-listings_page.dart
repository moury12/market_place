import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:market_place/core/components/custom_button_tap.dart';
import 'package:market_place/core/constants/color_constants.dart';
import 'package:market_place/core/constants/custom_text.dart';
import 'package:market_place/core/constants/fontsize_constant.dart';
import 'package:market_place/core/constants/padding_constant.dart';
import 'package:market_place/core/constants/text_style_constant.dart';
import 'package:market_place/core/utils/variable.dart';
import 'package:market_place/presentations/my-listings/views/listing_product_page.dart';

class MyListingsPage extends StatelessWidget {
  static const String routeName = "/my-listing";
  const MyListingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(

      itemCount: listingData.length,
      padding: padding12,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        mainAxisSpacing: 12.w,
        crossAxisSpacing: 12.w,
        maxCrossAxisExtent: 120.w,
        childAspectRatio: .6
      ),
      itemBuilder:
          (context, index) => Container(

            decoration: BoxDecoration(
              color: AppColors.kPrimaryColor,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: ButtonTapWidget(
              color: AppColors.kWhiteColor,
              radius: 6.r,
onTap: () {
  Get.toNamed(ListingProductPage.routeName,arguments:listingData[index].title );
},
              child: Padding(
                padding: padding8,
                child: Column(spacing: 8.h,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(listingData[index].img),
                    CustomText(
                      style: poppinsMedium,
                      fontSize: getFontSizeSemiSmall(),
                      color: AppColors.kWhiteColor,
                      text: listingData[index].title,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
