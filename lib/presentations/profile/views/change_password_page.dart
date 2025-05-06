import 'package:get/get.dart';
import 'package:market_place/core/components/custom_appbar.dart';
import 'package:market_place/core/components/custom_button.dart';
import 'package:market_place/core/components/custom_textfield.dart';
import 'package:market_place/core/constants/color_constants.dart';
import 'package:market_place/core/constants/custom_space.dart';
import 'package:market_place/core/constants/padding_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_static_strings.dart';

class ChangePasswordPage extends StatelessWidget {
  static const String routeName = '/change-pass';
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomDefaultAppbar(title: AppStaticStrings.changePassword.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: padding16,
          child: Column(
            spacing: 12.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              CustomTextField(
                fillColor: AppColors.kWhiteColor,
                title: AppStaticStrings.currentPass.tr,
                isPassword: true,
              ),
              CustomTextField(
                fillColor: AppColors.kWhiteColor,
                title: AppStaticStrings.newPass.tr,
                isPassword: true,
              ),
              CustomTextField(
                fillColor: AppColors.kWhiteColor,
                title: AppStaticStrings.confirmPassword.tr,
                isPassword: true,
              ),
              space8H,
              CustomButton(onTap: () {}, title: AppStaticStrings.save.tr),
            ],
          ),
        ),
      ),
    );
  }
}
