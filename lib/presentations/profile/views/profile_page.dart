import 'package:flutter_svg/flutter_svg.dart';
import 'package:market_place/core/components/custom_button_tap.dart';
import 'package:market_place/core/components/custom_network_image.dart';
import 'package:market_place/core/constants/color_constants.dart';
import 'package:market_place/core/constants/custom_text.dart';
import 'package:market_place/core/constants/fontsize_constant.dart';
import 'package:market_place/core/constants/image_constants.dart';
import 'package:market_place/core/constants/padding_constant.dart';
import 'package:market_place/core/constants/text_style_constant.dart';
import 'package:market_place/core/utils/variable.dart';
import 'package:market_place/presentations/home/widgets/product_card_item_widget.dart';
import 'package:market_place/presentations/my-listings/views/listing_product_page.dart';

import 'package:market_place/presentations/notification/views/notification_page.dart';
import 'package:market_place/presentations/profile/views/account_settings_page.dart';
import 'package:market_place/presentations/profile/views/edit_profile_page.dart';
import 'package:market_place/presentations/profile/views/term_policy_help_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_static_strings.dart';
import '../widgets/profile_action_item_widget.dart';

class ProfilePage extends StatelessWidget {
  static const String routeName = '/profile';
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: padding16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.h,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: AppColors.kWhiteColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.kExtraLightGreyTextColor.withValues(
                      alpha: .3,
                    ),
                    blurRadius: 6.r,
                  ),
                ],
              ),
              child: Padding(
                padding: padding6,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12.w,
                  children: [
                    CustomNetworkImage(
                      imageUrl: dummyProfileImage,
                      height: 80.w,
                      width: 80.w,
                    ),
                    Expanded(
                      child: Column(
                        spacing: 4.w,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          CustomText(
                            text: "Ely Mohammed",
                            style: poppinsMedium,
                          ),
                          Row(
                            spacing: 4.w,
                            children: [
                              SvgPicture.asset(mainIcon),
                              CustomText(
                                text: "Marvin@gmail.com",
                                style: poppinsRegular,
                                fontSize: 10.sp,
                              ),
                            ],
                          ),
                          Row(
                            spacing: 4.w,
                            children: [
                              SvgPicture.asset(
                                callIcon,
                                colorFilter: ColorFilter.mode(
                                  AppColors.kPrimaryColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                              CustomText(
                                text: "(555) 123-4567",
                                style: poppinsRegular,
                                fontSize: 10.sp,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ButtonTapWidget(
                      onTap: () {
                        Get.toNamed(EditProfilePage.routeName);
                      },
                      child: GreenAccentContainerWidget(
                        radius: 4.r,
                        child: Padding(
                          padding: padding2,
                          child: Row(
                            spacing: 4.w,
                            children: [
                              SvgPicture.asset(
                                editIcon,
                                colorFilter: ColorFilter.mode(
                                  AppColors.kPrimaryColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                              CustomText(
                                text: AppStaticStrings.editProfile,
                                style: poppinsRegular,
                                color: AppColors.kPrimaryColor,
                                fontSize: 10.sp,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ProfileActionItemWidget(
              img: settingIcon,
              title: AppStaticStrings.accountSetting,
              onTap: () {
                Get.toNamed(AccountSettingsPage.routeName);
              },
            ),
            ProfileActionItemWidget(
              img: favItemIcon,
              title: AppStaticStrings.favoriteItems,
              onTap: () {
                Get.toNamed(
                  ListingProductPage.routeName,
                  arguments: AppStaticStrings.favoriteItems,
                );
              },
            ),
            ProfileActionItemWidget(
              img: notificationOutlineIcon,
              title: AppStaticStrings.notification,
              onTap: () {
                Get.toNamed(NotificationPage.routeName);
              },
            ),

            CustomText(
              text: AppStaticStrings.more,
              fontSize: getFontSizeDefault(),
              style: poppinsSemiBold,
            ),
            ProfileActionItemWidget(
              img: termsIcon,
              title: AppStaticStrings.termsAndCondition,
              onTap: () {
                Get.toNamed(
                  TermsPolicyHelpPage.routeName,
                  arguments: AppStaticStrings.termsAndCondition,
                );
              },
            ),
            ProfileActionItemWidget(
              img: privacyPolicyIcon,
              title: AppStaticStrings.privacyPolicy,
              onTap: () {
                Get.toNamed(
                  TermsPolicyHelpPage.routeName,
                  arguments: AppStaticStrings.privacyPolicy,
                );
              },
            ),
            ProfileActionItemWidget(
              img: helpIcon,
              title: AppStaticStrings.helpSupport,
              onTap: () {
                Get.toNamed(
                  TermsPolicyHelpPage.routeName,
                  arguments: AppStaticStrings.helpSupport,
                );
              },
            ),
            ProfileActionItemWidget(
              img: logoutIcon,
              title: AppStaticStrings.logOut,
              onTap: () {
                // Get.offAllNamed(LoginPage.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
