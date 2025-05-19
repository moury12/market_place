import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_place/core/components/custom_appbar.dart';
import 'package:market_place/core/components/custom_button.dart';
import 'package:market_place/core/components/custom_textfield.dart';
import 'package:market_place/core/constants/app_static_strings.dart';
import 'package:market_place/core/constants/color_constants.dart';
import 'package:market_place/core/constants/custom_space.dart';
import 'package:market_place/core/constants/padding_constant.dart';
import 'package:market_place/presentations/profile/controllers/account_information_controller.dart';
import 'package:market_place/presentations/profile/controllers/account_information_controller.dart';
import 'package:market_place/presentations/profile/controllers/account_information_controller.dart';
import 'package:market_place/presentations/profile/views/subscription_page.dart';

class MySubscriptionPage extends StatelessWidget {
  static const String routeName = "/my-subscription";
  const MySubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomDefaultAppbar(
        title: AppStaticStrings.subscriptionStatus.tr,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: padding12,
          child: Column(
            spacing: 8.h,
            children: [
              CustomTextField(
                textEditingController: TextEditingController(
                  text: AccountInformationController.to.packageModel.value.type,
                ),
                fillColor: AppColors.kWhiteColor,
                title: AppStaticStrings.subscriptionType.tr,
              ),
              CustomTextField(
                textEditingController: TextEditingController(
                  text: AccountInformationController.to.packageModel.value.type,
                ),
                fillColor: AppColors.kWhiteColor,
                title: AppStaticStrings.lastPurchaseDate.tr,
              ),
              CustomTextField(
                textEditingController: TextEditingController(
                  text: AccountInformationController.to.packageModel.value.type,
                ),
                fillColor: AppColors.kWhiteColor,
                title: AppStaticStrings.subscriptionExpiryDate.tr,
              ),
              space8H,

              CustomButton(
                onTap: () {},
                title: AppStaticStrings.renewSubscription.tr,
              ),
              CustomButton(
                fillColor: Colors.transparent,
                textColor: AppColors.kPrimaryColor,

                onTap: () {
                  Get.toNamed(SubscriptionPage.routeName);
                },
                title: AppStaticStrings.changeSubscription.tr,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
