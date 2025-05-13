import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_place/core/constants/app_static_strings.dart';
import 'package:market_place/presentations/auth/controller/auth_controller.dart';
import 'package:market_place/presentations/auth/widgets/auth_title_widget.dart';

import '../../../core/components/custom_loading_widget.dart';
import '../../../core/components/tab-bar/dynamic_tab_widget.dart';
import '../../../core/constants/padding_constant.dart';
import '../../../core/utils/enum.dart';

class SubscriptionPage extends StatelessWidget {
  static const String routeName = "/subscription";
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = AuthController.to;
    // for (var package in controller.packageList) {
    //   controller.tabContent.add(
    //     SubscriptionPlanWidget(
    //       package: package,
    //     ),
    //   );
    // }
    //
    // // Fallback if no packages (shouldn't happen if API works)
    // if (controller.packageList.isEmpty) {
    //   controller.tabContent.addAll([
    //     SubscriptionPlanWidget(
    //       package: PackageModel(),
    //     ), // Monthly fallback
    //     SubscriptionPlanWidget(
    //       package: PackageModel(),
    //     ), // Yearly fallback
    //   ]);
    //   controller.tabLabels.value = [
    //     AppStaticStrings.monthly,
    //     AppStaticStrings.yearly,
    //   ];
    // }

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
              AuthSubTextWidget(
                text: AppStaticStrings.subscriptionDescription.tr,
              ),
              Obx(() {
                return AuthController.to.loadingProcess.value ==
                        AuthProcess.packageGet
                    ? CustomLoadingWidget(
                      height: ScreenUtil().screenHeight,
                      size: 30.sp,
                      width: ScreenUtil().screenWidth,
                    )
                    : DynamicTabWidget(
                      tabs: AuthController.to.tabLabels,
                      tabContent: AuthController.to.tabContent,
                      function: (p0) {},
                    );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
