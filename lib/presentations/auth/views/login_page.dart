import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:market_place/core/constants/image_constants.dart';
import 'package:market_place/core/constants/padding_constant.dart';
import 'package:market_place/presentations/auth/controller/auth_controller.dart' show AuthController;
import 'package:market_place/presentations/auth/views/signup_page.dart';
import 'package:market_place/presentations/auth/views/verify_email_page.dart';

import '../../../core/components/custom_button.dart';
import '../../../core/components/custom_checkbox_widget.dart';
import '../../../core/components/custom_text_button.dart';
import '../../../core/components/custom_textfield.dart';
import '../../../core/constants/app_static_strings.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/constants/custom_space.dart';
import '../../../core/constants/custom_text.dart';
import '../../../core/constants/fontsize_constant.dart';
import '../../../core/constants/text_style_constant.dart';
import '../../navigation/views/navigation_page.dart';
import '../widgets/auth_title_widget.dart';

class LoginPage extends StatelessWidget {
  static const String routeName ="/login";
  const LoginPage({super.key});

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
                AuthTitleTextWidget(title: AppStaticStrings.welcomeBack),
                AuthSubTextWidget(text: AppStaticStrings.logInToContinue),
                space12H,
                CustomTextField(
                  fillColor: Colors.transparent,
                  title: AppStaticStrings.email,),
                CustomTextField(
                    fillColor: Colors.transparent,
                    title: AppStaticStrings.password, isPassword: true),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          CustomCheckBoxWidget(
                            isChecked: AuthController.to.isRememberMe,
                          ),
                          Expanded(
                            child: CustomText(
                              text: AppStaticStrings.rememberMe,
                              // fontSize: getFontSizeSmall(),
                            ),
                          ),
                        ],
                      ),
                    ),

                    CustomTextButton(title: AppStaticStrings.forgetPassword,onPressed: () {
                      Get.toNamed(VerifyEmailPage.routeName);
                    },),
                  ],
                ),
                SvgPicture.asset(orImg, width: ScreenUtil().screenWidth),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: AppStaticStrings.dontHaveAccount,
                      style: poppinsRegular,
                    ),
                    CustomTextButton(
                      onPressed: () {
                        Get.toNamed(SignUpPage.routeName);
                      },
                      title: AppStaticStrings.signUp,
                      fontSize: getFontSizeSemiSmall(),
                      textColor: AppColors.kPrimaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                CustomButton(onTap: () {
                  Get.offAllNamed(NavigationPage.routeName);
                }, title: AppStaticStrings.signIn),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
