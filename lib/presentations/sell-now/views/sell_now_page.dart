import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:market_place/core/components/custom_button.dart';
import 'package:market_place/core/components/custom_button_tap.dart';
import 'package:market_place/core/constants/app_static_strings.dart';
import 'package:market_place/core/constants/color_constants.dart';
import 'package:market_place/core/constants/custom_text.dart';
import 'package:market_place/core/constants/fontsize_constant.dart';
import 'package:market_place/core/constants/image_constants.dart';
import 'package:market_place/core/constants/padding_constant.dart';
import 'package:market_place/core/constants/text_style_constant.dart';
import 'package:market_place/core/helper/helper_function.dart';
import 'package:market_place/presentations/navigation/controller/navigation_controller.dart';
import 'package:market_place/presentations/sell-now/controller/sell_controller.dart';

import '../../../core/components/custom_drop_down_button.dart';
import '../../../core/components/custom_textfield.dart';
import '../../../core/utils/variable.dart';

class SellNowPage extends StatelessWidget {
  static const String routeName = "/sell-now";
  const SellNowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: padding12.copyWith(top: 0),
        child: Obx(() {
          return !SellController.to.addProductInfo.value &&
                  !SellController.to.addLocationInfo.value
              ? Column(
                spacing: 12.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleBold(title: "Upload Product Images"),
                  Obx(() {
                    return Wrap(
                      spacing: 8.w,
                      runSpacing: 8.w,
                      children: List.generate(
                        SellController.to.imgList.length,
                        (index) {
                          final img = SellController.to.imgList[index];
                          return Stack(
                            children: [
                              Image.file(
                                File(img),
                                height: 110.w,
                                width: 110.w,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: -10,
                                right: -10,

                                child: IconButton(
                                  onPressed: () {
                                    removeImage(
                                      uploadImages: SellController.to.imgList,
                                      imagePath: img,
                                    );
                                  },
                                  icon: Icon(
                                    CupertinoIcons.multiply_circle_fill,
                                    size: 20,
                                    color: AppColors.kPrimaryColor,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  }),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        width: .5,
                        color: AppColors.kPrimaryColor,
                      ),
                    ),
                    child: ButtonTapWidget(
                      radius: 8.r,
                      onTap: () {
                        pickImages(
                          allowMultiple: true,
                          uploadImages: SellController.to.imgList,
                        );
                      },
                      child: Padding(
                        padding: padding12,
                        child: Column(
                          spacing: 12.h,
                          children: [
                            SvgPicture.asset(imgIcon),
                            CustomText(
                              text: AppStaticStrings.uploadImage,
                              color: AppColors.kPrimaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  CustomButton(
                    onTap: () {
                      SellController.to.addProductInfo.value = true;
                    },
                    title: AppStaticStrings.next,
                  ),
                ],
              )
              : !SellController.to.addLocationInfo.value
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12.h,
                children: [
                  titleBold(title: "Product Information "),
                  CustomTextField(
                    fillColor: AppColors.kWhiteColor,
                    title: "Product Title",
                  ),
                  CustomDropdown(
                    title: AppStaticStrings.category,
                    items: category,
                    selectedValue: SellController.to.selectedCategory.value,
                  ),
                  CustomDropdown(
                    title: AppStaticStrings.subCategory,
                    items: category,
                    selectedValue: SellController.to.selectedSubCategory.value,
                  ),
                  CustomDropdown(
                    title: AppStaticStrings.condition,
                    items: condition,
                    selectedValue: SellController.to.selectedCondition.value,
                  ),
                  CustomTextField(
                    fillColor: AppColors.kWhiteColor,
                    title: AppStaticStrings.price,
                  ),
                  CustomTextField(
                    fillColor: AppColors.kWhiteColor,
                    title: "Product Description",
                    maxLines: 6,
                  ),
                  Row(
                    spacing: 12.w,
                    children: [
                      Expanded(
                        child: CustomButton(
                          fillColor: Colors.transparent,
                          textColor: AppColors.kPrimaryColor,
                          onTap: () {
                            SellController.to.addProductInfo.value = false;
                          },
                          title: "Previous",
                        ),
                      ),
                      Expanded(
                        child: CustomButton(
                          onTap: () {
                            SellController.to.addProductInfo.value = false;
                            SellController.to.addLocationInfo.value = true;
                          },
                          title: AppStaticStrings.next,
                        ),
                      ),
                    ],
                  ),
                ],
              )
              : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12.h,
                children: [
                  titleBold(title: "Product Information "),

                  CustomDropdown(
                    title: AppStaticStrings.wilaya,
                    items: category,
                    selectedValue: SellController.to.selectedWilaya.value,
                  ),
                  CustomDropdown(
                    title: AppStaticStrings.city,
                    items: category,
                    selectedValue: SellController.to.selectedCity.value,
                  ),

                  Row(
                    spacing: 12.w,
                    children: [
                      Expanded(
                        child: CustomButton(
                          fillColor: Colors.transparent,
                          textColor: AppColors.kPrimaryColor,
                          onTap: () {
                            SellController.to.addLocationInfo.value = false;
                            SellController.to.addProductInfo.value = true;
                          },
                          title: "Previous",
                        ),
                      ),
                      Expanded(
                        child: CustomButton(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder:
                                  (context) => AlertDialog(
                                    content: Column(
                                      spacing: 8.h,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Lottie.asset(
                                          "assets/lottie/success.json",
                                        ),
                                        CustomText(
                                          text: AppStaticStrings.success,
                                          style: poppinsMedium,
                                          fontSize: getFontSizeDefault(),
                                        ),
                                        CustomText(
                                          textAlign: TextAlign.center,
                                          text:
                                              AppStaticStrings
                                                  .yourItemHasBeenSubmitted,
                                          color: AppColors.kExtraLightTextColor,
                                          fontSize: getFontSizeSemiSmall(),
                                        ),

                                        Container(
                                          width: ScreenUtil().screenWidth / 3,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: AppColors.kPrimaryDarkColor,
                                            borderRadius: BorderRadius.circular(
                                              4.r,
                                            ),
                                          ),
                                          child: ButtonTapWidget(
                                            onTap: () {
                                              Navigator.pop(context);
                                              NavigationController.to.selectedNavIndex.value =0;
                                              Get.back();
                                            },
                                            child: Padding(
                                              padding: paddingH16V6,
                                              child: CustomText(
                                                text: "Ok",
                                                fontSize: getFontSizeDefault(),
                                                color: AppColors.kWhiteColor,
                                                style: poppinsMedium,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                            );
                          },
                          title: AppStaticStrings.submit,
                        ),
                      ),
                    ],
                  ),
                ],
              );
        }),
      ),
    );
  }

  CustomText titleBold({required String title}) {
    return CustomText(
      text: title,
      style: poppinsSemiBold,
      color: Colors.black,
      fontSize: getFontSizeDefault(),
    );
  }
}
