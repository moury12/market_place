import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:market_place/core/constants/image_constants.dart';
import 'package:market_place/core/constants/padding_constant.dart';
import 'package:market_place/presentations/auth/views/login_page.dart';
import 'package:market_place/presentations/auth/views/verify_email_page.dart';

import '../../../core/components/custom_button.dart';
import '../../../core/components/custom_text_button.dart';
import '../../../core/components/custom_textfield.dart';
import '../../../core/constants/app_static_strings.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/constants/custom_space.dart';
import '../../../core/constants/custom_text.dart';
import '../../../core/constants/fontsize_constant.dart';
import '../../../core/constants/text_style_constant.dart';
import '../widgets/auth_title_widget.dart';
class SignUpPage extends StatelessWidget {
  static const String routeName ="/sign-up";
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: padding12.copyWith(top: MediaQuery.of(context).viewPadding.top+16),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              spacing: 8.h,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AuthTitleTextWidget(title: AppStaticStrings.createYourAccount.tr),
                AuthSubTextWidget(text: AppStaticStrings.signUpToGetStarted.tr),
                CustomTextField(
                    fillColor: Colors.transparent,
                    title: AppStaticStrings.fullName.tr),
                CustomTextField(
                    fillColor: Colors.transparent,
                    title: AppStaticStrings.email.tr),
                CustomTextField(
                  fillColor: Colors.transparent,

                  title: AppStaticStrings.phoneNumber.tr,
                  keyboardType: TextInputType.number,
                ),
          
                CustomTextField(
                    fillColor: Colors.transparent,
                    title: AppStaticStrings.password.tr, isPassword: true),
                CustomTextField(
                  fillColor: Colors.transparent,

                  title: AppStaticStrings.confirmPassword.tr,
                  isPassword: true,
                ),
                SvgPicture.asset(orImg, width: ScreenUtil().screenWidth),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: AppStaticStrings.alreadyHaveAccount.tr,
                      style: poppinsRegular,
                    ),
                    CustomTextButton(
                      onPressed: () {
                        Get.toNamed(LoginPage.routeName);
                      },
                      title: AppStaticStrings.signIn.tr,
                      fontSize: getFontSizeSemiSmall(),
                      textColor: AppColors.kPrimaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                CustomButton(onTap: () {
                  Get.toNamed(VerifyEmailPage.routeName);
                }, title: AppStaticStrings.createAccount.tr),
                space12H,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
