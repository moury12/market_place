import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:market_place/core/components/custom_appbar.dart';
import 'package:market_place/core/components/custom_button.dart';
import 'package:market_place/core/components/custom_button_tap.dart';
import 'package:market_place/core/components/custom_network_image.dart';
import 'package:market_place/core/constants/custom_space.dart';
import 'package:market_place/core/constants/custom_text.dart';
import 'package:market_place/core/constants/fontsize_constant.dart';
import 'package:market_place/core/constants/image_constants.dart';
import 'package:market_place/core/constants/padding_constant.dart';
import 'package:market_place/core/constants/text_style_constant.dart';
import 'package:market_place/core/utils/variable.dart';
import 'package:market_place/presentations/product/views/seller_profile_page.dart';

import '../widgets/seller_profile_widgets.dart';

class ProductDetailsPage extends StatelessWidget {
  static const String routeName = "/product-details";
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomDefaultAppbar(
        action: [
          ButtonTapWidget(
            child: Padding(padding: padding8, child: SvgPicture.asset(favIcon)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: padding12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              CustomNetworkImage(
                radius: 2.r,
                imageUrl: imageUrl,
                height: 250.w,
              ),
              space8H,
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 8.w,
                  children: List.generate(
                    10,
                    (index) => CustomNetworkImage(
                      radius: 2.r,
                      imageUrl: imageUrl,
                      height: 50.w,
                      width: 50.w,
                    ),
                  ),
                ),
              ),
              space8H,
              CustomText(
                text: "Product Name..",
                style: poppinsSemiBold,
                fontSize: getFontSizeDefault(),
              ),
              CustomText(
                text: "UM  49.99",
                style: poppinsSemiBold,
                fontSize: getFontSizeDefault(),
              ),
              space8H,
              Column(
                spacing: 8.h,
                children: [
                  CallAndChatButtons(),

                  ///----------------------- seller info ------------------------///
                  Row(
                    spacing: 8.h,
                    children: [
                      CustomNetworkImage(
                        imageUrl: dummyProfileImage,
                        height: 40.w,
                        width: 40.w,
                        boxShape: BoxShape.circle,
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          spacing: 4.h,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(text: "Seller Name"),
                            SellerRatingWidget(),
                          ],
                        ),
                      ),
                      Expanded(flex: 2,
                        child: CustomButton(
                          onTap: () {
                            Get.toNamed(SellerProfilePage.routeName);
                          },
                          title: "View Profile",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
