import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_place/core/constants/app_static_strings.dart';
import 'package:market_place/presentations/auth/controller/auth_controller.dart';
import 'package:market_place/presentations/auth/widgets/auth_title_widget.dart';

import '../../../core/components/tab-bar/dynamic_tab_widget.dart';
import '../../../core/constants/padding_constant.dart';
import '../widgets/subscription_plan_card_widget.dart';

class SubscriptionPage extends StatelessWidget {
  static const String routeName = "/subscription";
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController.to.tabContent.add(
      SubscriptionPlanWidget(),
    );AuthController.to.tabContent.add(
      SubscriptionPlanWidget(isYear: true,),
    );
    return Scaffold(
      body: Padding(
        padding: padding12.copyWith(
          top: MediaQuery.of(context).viewPadding.top + 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            spacing: 8.h,
            children: [
              AuthTitleTextWidget(
                title: AppStaticStrings.chooseSubscriptionPlan.tr,
              ),
              AuthSubTextWidget(text: AppStaticStrings.subscriptionDescription.tr),
              DynamicTabWidget(
                tabs: AuthController.to.tabLabels,
                tabContent: AuthController.to.tabContent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

