import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_place/core/components/custom_button.dart';
import 'package:market_place/core/components/custom_drop_down_button.dart';
import 'package:market_place/core/constants/app_static_strings.dart';
import 'package:market_place/core/constants/color_constants.dart';

import 'package:market_place/core/constants/fontsize_constant.dart';
import 'package:market_place/core/constants/padding_constant.dart';
import 'package:market_place/core/utils/variable.dart';
import 'package:market_place/presentations/home/controller/home_controller.dart';

import '../constants/text_style_constant.dart';

class FilterDrawerWidget extends StatelessWidget {
  const FilterDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: AppColors.kPrimaryAccentColor,
        width: MediaQuery.sizeOf(context).width / 1.5,
        child: Padding(
          padding: padding12,
          child: SingleChildScrollView(
            child: Obx(() {
              return Column(
                spacing: 12.h,
                children: [
                  CustomDropdown(
                    title: AppStaticStrings.category,
                    items: category,
                    selectedValue: HomeController.to.selectedCategory.value,
                  ),
                  CustomDropdown(
                    title: AppStaticStrings.subCategory,
                    items: category,
                    selectedValue: HomeController.to.selectedSubCategory.value,
                  ),
                  CustomDropdown(
                    title: AppStaticStrings.wilaya,
                    items: category,
                    selectedValue: HomeController.to.selectedWilaya.value,
                  ),
                  CustomDropdown(
                    title: AppStaticStrings.city,
                    items: category,
                    selectedValue: HomeController.to.selectedCity.value,
                  ),
                  Text(
                    AppStaticStrings.priceRange,
                    style: poppinsSemiBold.copyWith(
                      color: AppColors.kBlackColor,
                      fontSize: getFontSizeSemiSmall(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _priceBox(
                        "\$ ${HomeController.to.rangeValues.value.start.toInt()}",
                      ),
                      _priceBox(
                        "\$ ${HomeController.to.rangeValues.value.end.toInt()}",
                      ),
                    ],
                  ),
                  Obx(() {
                    return RangeSlider(
                      values: HomeController.to.rangeValues.value,
                      min: 0,
                      max: 1000,
            
                      activeColor: AppColors.kPrimaryColor, // Green track
                      inactiveColor: const Color(0xFFDDE6E7), // Light gray track
                      divisions: 100,
                      onChanged: (RangeValues values) {
                        HomeController.to.rangeValues.value = values;
                      },
                    );
                  }),
                  CustomDropdown(
                    title: AppStaticStrings.condition,
                    items: condition,
                    selectedValue: HomeController.to.selectedCondition.value,
                  ),
                  CustomDropdown(
                    title: AppStaticStrings.sortBy,
                    items: sortBy,
                    selectedValue: HomeController.to.selectedSortBy.value,
                  ),
                  CustomButton(onTap: () {
            
                  },
                  title:AppStaticStrings.applyFilter ,),  CustomButton(
                    fillColor: Colors.transparent,
                    textColor: AppColors.kPrimaryColor,
                    onTap: () {
            Navigator.pop(context);
                  },
                  title:AppStaticStrings.close ,),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _priceBox(String value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF2ECC71)),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        value,
        style: TextStyle(
          color: const Color(0xFF2ECC71),
          fontWeight: FontWeight.w500,
          fontSize: 12.sp,
        ),
      ),
    );
  }
}
