import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_place/core/constants/padding_constant.dart';
import 'package:market_place/presentations/auth/views/verify_otp_page.dart';
import 'package:market_place/presentations/profile/views/change_password_page.dart';

import '../../../core/components/custom_button.dart';
import '../../../core/components/custom_otp_field.dart';
import '../../../core/components/custom_textfield.dart';
import '../../../core/constants/app_static_strings.dart';
import '../../../core/constants/custom_space.dart';
import '../widgets/auth_title_widget.dart';
class VerifyOtpPage extends StatelessWidget {
  static const String routeName ="/otp";
  const VerifyOtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:Padding(
        padding: padding12.copyWith(top: MediaQuery.of(context).viewPadding.top+16),
        child: Center(
          child: Column(
            spacing: 8.h,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AuthTitleTextWidget(title: AppStaticStrings.sixDigitCode),
              AuthSubTextWidget(text: AppStaticStrings.enterCodeSent),
              space6H,
              OtpTextField(),
              space4H,
              CustomButton(
                onTap: () {
                  Get.toNamed(ChangePasswordPage.routeName);
                },
                title: AppStaticStrings.confirm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
