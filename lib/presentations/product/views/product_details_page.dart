import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:market_place/core/components/custom_appbar.dart';
import 'package:market_place/core/components/custom_button.dart';
import 'package:market_place/core/components/custom_button_tap.dart';
import 'package:market_place/core/components/custom_network_image.dart';
import 'package:market_place/core/constants/app_static_strings.dart';
import 'package:market_place/core/constants/color_constants.dart';
import 'package:market_place/core/constants/custom_space.dart';
import 'package:market_place/core/constants/custom_text.dart';
import 'package:market_place/core/constants/fontsize_constant.dart';
import 'package:market_place/core/constants/image_constants.dart';
import 'package:market_place/core/constants/padding_constant.dart';
import 'package:market_place/core/constants/text_style_constant.dart';
import 'package:market_place/core/utils/variable.dart';
import 'package:market_place/presentations/home/widgets/product_card_item_widget.dart';
import 'package:market_place/presentations/home/widgets/view_all_row_widget.dart';
import 'package:market_place/presentations/product/views/seller_profile_page.dart';

import '../widgets/manage_option_widget.dart';
import '../widgets/product_details_card_widget.dart';
import '../widgets/seller_profile_widgets.dart';

class ProductDetailsPage extends StatelessWidget {
  static const String routeName = "/product-details";
  ProductDetailsPage({super.key});
  final fromSeller = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomDefaultAppbar(
        title: fromSeller ?  AppStaticStrings.manageProduct.tr: "",
        action: [
          fromSeller
              ? SizedBox.shrink()
              : ButtonTapWidget(
                child: Padding(
                  padding: padding8,
                  child: SvgPicture.asset(favIcon),
                ),
              ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: padding12.copyWith(top: 0),
          child: Column(
            spacing: 4.h,
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
                    5,
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

              fromSeller
                  ? SizedBox.shrink()
                  : Padding(
                    padding: padding8V,
                    child: Column(
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
                                  CustomText(
                                    text: "Marvin@gmail.com",
                                    fontSize: getFontSizeSmall(),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: CustomButton(
                                onTap: () {
                                  Get.toNamed(SellerProfilePage.routeName);
                                },
                                title: AppStaticStrings.viewProfile.tr,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

              CustomText(
                text: AppStaticStrings.productDetails.tr,
                style: poppinsSemiBold,
                fontSize: getFontSizeDefault(),
              ),
              space8H,

              ProductDetailsCardWidget(
                title: "Product Category ",
                value: "Jewelary",
              ),
              ProductDetailsCardWidget(
                title: "Product Category ",
                value: "Jewelary",
              ),
              ProductDetailsCardWidget(
                title: "Product Category ",
                value: "Jewelary",
              ),
              CustomText(text: AppStaticStrings.productDescription.tr),
              space8H,
              CustomText(text: dummyDesc, fontSize: getFontSizeSmall()),
              space8H,
              fromSeller
                  ? Column(
                spacing: 8.h,
                    children: [
                      ManageOptionWidget(
                        title: AppStaticStrings.editListingInfo.tr,
                        color: AppColors.kPrimaryColor,
                        icon: editIcon,
                        action: () {},
                      ),
                      ManageOptionWidget(
                        title: AppStaticStrings.markAsSold.tr,
                        color: AppColors.kPrimaryColor,
                        icon: markSoldIcon,
                        action: () {},
                      ),
                      ManageOptionWidget(
                        title: AppStaticStrings.archiveListings.tr,
                        color: AppColors.kYellowColor,
                        icon: archiveListingsIcon,
                        action: () {},
                      ),
                      ManageOptionWidget(
                        title: AppStaticStrings.deletePermanently.tr,
                        color: AppColors.kRedColor,
                        icon: deleteIcon,
                        action: () {},
                      ),
                    ],
                  )
                  : ViewAllRow(title: "Related product", onPressed: () {}),
              // fromSeller ? SizedBox.shrink() : ProductGridWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

