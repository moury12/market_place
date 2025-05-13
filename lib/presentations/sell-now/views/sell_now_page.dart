import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:market_place/core/components/custom_button.dart';
import 'package:market_place/core/components/custom_button_tap.dart';
import 'package:market_place/core/constants/app_static_strings.dart';
import 'package:market_place/core/constants/color_constants.dart';
import 'package:market_place/core/constants/custom_space.dart';
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
import '../../home/model/category_subcategory_model.dart';
import '../../product/widgets/image_list_widget.dart';

class SellNowPage extends StatelessWidget {
  static const String routeName = "/sell-now";
  SellNowPage({super.key});
  final _formKey = GlobalKey<FormState>();
  final _formKeyForLocation = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: padding12.copyWith(top: 0),
        child: Obx(() {
          return !SellController.to.addProductInfo.value &&
                  !SellController.to.addLocationInfo.value
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleBold(title: AppStaticStrings.uploadProductImages.tr),
                  space8H,
                  ListOfImages(images: SellController.to.imgList),
                  ListOfImages(images: SellController.to.editImgList),

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
                  space12H,
                  CustomButton(
                    onTap: () {
                      if (SellController.to.imgList.isNotEmpty) {
                        SellController.to.addProductInfo.value = true;
                      } else if (SellController.to.isEditMode.value == true &&
                          SellController.to.editImgList.isNotEmpty) {
                        SellController.to.addProductInfo.value = true;

                      } else {
                        showCustomSnackbar(
                          title: AppStaticStrings.failed.tr,
                          message: "At least one image is required",
                          type: SnackBarType.failed,
                        );
                      }
                    },
                    title: AppStaticStrings.next.tr,
                  ),
                ],
              )
              : !SellController.to.addLocationInfo.value
              ? Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12.h,
                  children: [
                    titleBold(title: AppStaticStrings.productInformation.tr),
                    CustomTextField(
                      isRequired: true,
                      fillColor: AppColors.kWhiteColor,
                      title: AppStaticStrings.productTitle.tr,
                      textEditingController:
                          SellController.to.nameController.value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppStaticStrings.fieldRequired.tr;
                        }
                        return null;
                      },
                    ),

                    CustomDropdown<CategoryModel>(
                      isRequired: true,
                      validator:
                          (value) =>
                              value == null
                                  ? AppStaticStrings.fieldRequired.tr
                                  : null,
                      isLoading: HomeController.to.isLoadingCategory.value,
                      title: AppStaticStrings.category.tr,
                      items: HomeController.to.catList,
                      onChanged: (value) async {
                        if (value != null) {
                          // Clear the subcategory list first
                          HomeController.to.subCatList.clear();
                          HomeController.to.subCatList.value = [];

                          // Important: Set selectedSubCategory to null BEFORE refreshing the list
                          SellController.to.selectedSubCategory.value = null;

                          // Set new category
                          SellController.to.selectedCategory.value = value;

                          // Load new subcategories
                          await HomeController.to.getSubCategoryListRequest(
                            catId: value.sId.toString(),
                          );

                          // Force UI update
                          HomeController.to.subCatList.refresh();
                        }
                      },
                      displayText: (cat) => cat.name.toString(),
                      selectedValue: SellController.to.selectedCategory.value??HomeController.to.catList.first,
                    ),
                    CustomDropdown<SubCategoryModel>(
                      isRequired: true,
                      onChanged: (value) {
                        SellController.to.selectedSubCategory.value = value;
                      },
                      validator: (value) {
                        if ( /*HomeController.to.cityList.isNotEmpty &&*/ value ==
                            null) {
                          return AppStaticStrings.fieldRequired.tr;
                        }
                        return null;
                      },

                      isLoading: HomeController.to.isLoadingSubCategory.value,
                      displayText: (cat) => cat.name.toString(),
                      title: AppStaticStrings.subCategory.tr,
                      items: HomeController.to.subCatList,

                      selectedValue:
                          SellController.to.selectedSubCategory.value == null
                              ? null
                              : HomeController.to.subCatList.firstWhereOrNull(
                                (e) =>
                                    e.sId ==
                                    SellController
                                        .to
                                        .selectedSubCategory
                                        .value!
                                        .sId,
                              ),
                    ),
                    CustomDropdown(
                      isRequired: true,
                      validator: (value) {
                        if (value == null) {
                          return AppStaticStrings.fieldRequired.tr;
                        }
                        return null;
                      },
                      title: AppStaticStrings.condition.tr,
                      items: condition,
                      selectedValue: SellController.to.selectedCondition.value,
                      onChanged: (value) {
                        SellController.to.selectedCondition.value = value;
                      },
                    ),
                    CustomTextField(
                      fillColor: AppColors.kWhiteColor,
                      textEditingController:
                          SellController.to.priceController.value,
                      title: AppStaticStrings.price.tr,
                      isRequired: true,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppStaticStrings.fieldRequired.tr;
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      fillColor: AppColors.kWhiteColor,
                      title: AppStaticStrings.productDescription.tr,
                      isRequired: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppStaticStrings.fieldRequired.tr;
                        }
                        return null;
                      },
                      maxLines: 6,
                      textEditingController:
                          SellController.to.descriptionController.value,
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
                              if (_formKey.currentState!.validate()) {
                                SellController.to.addProductInfo.value = false;
                                SellController.to.addLocationInfo.value = true;
                              }
                            },
                            title: AppStaticStrings.next.tr,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
              : Form(
                key: _formKeyForLocation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12.h,
                  children: [
                    titleBold(title: AppStaticStrings.productInformation.tr),

                    CustomDropdown<CategoryModel>(
                      isRequired: true,
                      validator: (value) {
                        if (value == null) {
                          return AppStaticStrings.fieldRequired.tr;
                        }
                        return null;
                      },
                      isLoading: HomeController.to.isLoadingDivision.value,
                      title: AppStaticStrings.wilaya.tr,
                      items: HomeController.to.divisionList,
                      onChanged: (value) async {
                        if (value != null) {
                          // Immediately clear previous selections and subcategories
                          SellController.to.selectedCity.value = null;
                          HomeController.to.cityList.clear();
                          HomeController.to.cityList.refresh();

                          // Set new category
                          SellController.to.selectedWilaya.value = value;

                          // Load new subcategories
                          await HomeController.to.getCityListRequest(
                            division: value.sId.toString(),
                          );
                          HomeController.to.cityList.refresh();
                        }
                      },
                      displayText: (cat) => cat.name.toString(),
                      selectedValue: SellController.to.selectedWilaya.value,
                    ),
                    CustomDropdown<CityModel>(
                      isRequired: true,
                      validator: (value) {
                        if ( /*HomeController.to.cityList.isNotEmpty &&*/ value ==
                            null) {
                          return AppStaticStrings.fieldRequired.tr;
                        }
                        return null;
                      },

                      selectedValue: HomeController.to.cityList
                          .firstWhereOrNull(
                            (item) =>
                                item.sId ==
                                SellController.to.selectedCity.value?.sId,
                          ),
                      isLoading: HomeController.to.isLoadingCity.value,
                      displayText: (cat) => cat.name.toString(),
                      onChanged: (value) {
                        SellController.to.selectedCity.value = value;
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
                          child: Obx(() {
                            return CustomButton(
                              isLoading:
                                  SellController.to.isLoadingAddProduct.value,

                              onTap: () {
                                if (_formKeyForLocation.currentState!
                                    .validate()) {
                                  SellController.to.addProductRequest();
                                  successDialogCustom(
                                    title:
                                        AppStaticStrings
                                            .yourItemHasBeenSubmitted
                                            .tr,
                                    onTap: () {
                                      NavigationController
                                          .to
                                          .selectedNavIndex
                                          .value = 0;
                                      Get.back();
                                    },
                                  );
                                }
                              },
                              title: AppStaticStrings.submit.tr,
                            );
                          }),
                        ),
                      ],
                    ),
                  ],
                ),
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
