import 'package:market_place/core/constants/color_constants.dart';
import 'package:market_place/core/constants/custom_text.dart';
import 'package:market_place/core/constants/fontsize_constant.dart';
import 'package:market_place/core/constants/image_constants.dart';
import 'package:market_place/core/constants/padding_constant.dart';
import 'package:market_place/core/constants/text_style_constant.dart';
import 'package:market_place/core/utils/common_controller.dart';
import 'package:market_place/core/utils/variable.dart';
import 'package:market_place/presentations/my-listings/views/listing_product_page.dart';

import 'package:market_place/presentations/notification/views/notification_page.dart';
import 'package:market_place/presentations/profile/views/account_settings_page.dart';
import 'package:market_place/presentations/profile/views/term_policy_help_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/components/custom_checkbox_widget.dart';
import '../../../core/constants/app_static_strings.dart';
import '../../auth/views/login_page.dart';
import '../widgets/profile_action_item_widget.dart';
import '../widgets/profile_info_widget.dart';

class ProfilePage extends StatelessWidget {
  static const String routeName = '/profile';
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: padding12.copyWith(top: 0),
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
                child: ProfileInfoDetailsWidget(),
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
              img: languageIcon,
              title: AppStaticStrings.language,
              onTap: () {
               showDialog(context: context, builder: (context) => AlertDialog(
                 content: Obx(() {
                   return Column(
                     mainAxisSize: MainAxisSize.min,
                     children: languageList.map((lang) {
                       return CheckboxListTile(

                         value: CommonController.to.selectedLanguageCode.value == lang.code,
                         title: CustomText(text:lang.name,style: poppinsMedium,),
                         onChanged: (_) {
                           CommonController.to.selectedLanguageCode.value = lang.code;
                           Get.back(); // Close dialog after selecting
                         },
                       );
                     }).toList(),
                   );
                 }),
               ),);
              },
            ), ProfileActionItemWidget(
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
                Get.offAllNamed(LoginPage.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}

