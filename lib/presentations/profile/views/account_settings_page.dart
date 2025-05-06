import 'package:market_place/core/constants/app_static_strings.dart' ;
import 'package:market_place/core/constants/image_constants.dart';
import 'package:market_place/core/constants/padding_constant.dart';
import 'package:market_place/presentations/profile/views/change_password_page.dart';
import 'package:market_place/presentations/profile/widgets/profile_action_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/components/custom_appbar.dart';

class AccountSettingsPage extends StatelessWidget {
  static const String routeName = '/acc-settings';
  const AccountSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomDefaultAppbar(title: AppStaticStrings.accountSetting.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: padding12,
          child: Column(
            spacing: 12.h,
            children: [

              ProfileActionItemWidget(
                img: chngPassIcon,
                title: AppStaticStrings.changePassword.tr,
                onTap: () => Get.toNamed(ChangePasswordPage.routeName),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
