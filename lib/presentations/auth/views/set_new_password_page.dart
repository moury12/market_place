import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_place/core/constants/padding_constant.dart';
import 'package:market_place/presentations/auth/views/login_page.dart';
import 'package:market_place/presentations/auth/views/verify_otp_page.dart';

import '../../../core/components/custom_button.dart';
import '../../../core/components/custom_textfield.dart';
import '../../../core/constants/app_static_strings.dart';
import '../../../core/constants/custom_space.dart';
import '../widgets/auth_title_widget.dart';
class SetNewPasswordPage extends StatelessWidget {
  static const String routeName = "/set-new-pass";
  const SetNewPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: padding12.copyWith(top: MediaQuery.of(context).viewPadding.top+16),
        child: Center(
          child: Column(
            spacing: 8.h,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AuthTitleTextWidget(title: AppStaticStrings.resetYourPassword.tr),
              AuthSubTextWidget(text: AppStaticStrings.createAnewPassword.tr),
              space6H,
              CustomTextField(
                  fillColor: Colors.transparent,
                  title: AppStaticStrings.newPassword.tr, isPassword: true),
              CustomTextField(
                fillColor: Colors.transparent,

                title: AppStaticStrings.confirmNewPassword.tr,
                isPassword: true,
              ),
              space4H,
              CustomButton(
                onTap: () {
                  Get.offAllNamed(LoginPage.routeName);
                },
                title: AppStaticStrings.confirm.tr,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
