import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
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
import '../../home/controller/home_controller.dart';

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
                  titleBold(title: AppStaticStrings.uploadProductImages.tr),
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
                              text: AppStaticStrings.uploadImage.tr,
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
                    title: AppStaticStrings.next.tr,
                  ),
                ],
              )
              : !SellController.to.addLocationInfo.value
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12.h,
                children: [
                  titleBold(title: AppStaticStrings.productInformation.tr),
                  CustomTextField(
                    fillColor: AppColors.kWhiteColor,
                    title: AppStaticStrings.productTitle.tr,
                  ),
                  CustomDropdown(

                      isLoading: HomeController.to.isLoadingCategory.value,
                      title: AppStaticStrings.category.tr,
                      items: HomeController.to.catList,
                      onChanged: (value) {

                        if (value != null) {
                          SellController.to.selectedCategory.value = value;

                          HomeController.to.getSubCategoryListRequest(
                            catId: value.sId.toString(),
                          );
                        }
                      },
                      displayText: (cat) => cat.name.toString(),


                    selectedValue: SellController.to.selectedCategory.value,
                  ),
                  CustomDropdown(
                    isLoading: HomeController.to.isLoadingSubCategory.value,
                    displayText: (cat) => cat.name.toString(),
                    title: AppStaticStrings.subCategory.tr,
                    items: HomeController.to.subCatList,
                    onChanged: (value) {
                      SellController.to.selectedSubCategory.value= value;
                    },

                    selectedValue: SellController.to.selectedSubCategory.value,
                  ),
                  CustomDropdown(
                    title: AppStaticStrings.condition.tr,
                    items: condition,
                    selectedValue: SellController.to.selectedCondition.value,
                    onChanged: (value) {
                      SellController.to.selectedCondition.value=value;
                    },
                  ),
                  CustomTextField(
                    fillColor: AppColors.kWhiteColor,
                    title: AppStaticStrings.price.tr,
                  ),
                  CustomTextField(
                    fillColor: AppColors.kWhiteColor,
                    title: AppStaticStrings.productDescription.tr,
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
                          title: AppStaticStrings.previous.tr,
                        ),
                      ),
                      Expanded(
                        child: CustomButton(
                          onTap: () {
                            SellController.to.addProductInfo.value = false;
                            SellController.to.addLocationInfo.value = true;
                          },
                          title: AppStaticStrings.next.tr,
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
                  titleBold(title: AppStaticStrings.productInformation.tr),

                  CustomDropdown(

                    isLoading: HomeController.to.isLoadingDivision.value,
                    title: AppStaticStrings.wilaya.tr,
                    items: HomeController.to.divisionList,
                    onChanged: (value) {
                      if (value != null) {
                        SellController.to.selectedWilaya.value = value;

                        HomeController.to.getCityListRequest(
                          division: value.sId.toString(),
                        );
                      }
                    },
                    displayText: (cat) => cat.name.toString(),
                    selectedValue: SellController.to.selectedWilaya.value,
                  ),
                  CustomDropdown(

                    selectedValue: SellController.to.selectedCity.value,
                    isLoading: HomeController.to.isLoadingCity.value,
                    displayText: (cat) => cat.name.toString(),
                    onChanged: (value) {
                      SellController.to.selectedCity.value= value;
                    },
                    title: AppStaticStrings.city.tr,
                    items: HomeController.to.cityList,
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
                          title: AppStaticStrings.previous.tr,
                        ),
                      ),
                      Expanded(
                        child: CustomButton(
                          onTap: () {
                            successDialogCustom(title: AppStaticStrings
                                .yourItemHasBeenSubmitted
                                .tr, onTap: () {   NavigationController
                                .to
                                .selectedNavIndex
                                .value = 0;
                            Get.back();  });
                          },
                          title: AppStaticStrings.submit.tr,
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
