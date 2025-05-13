import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:market_place/core/components/custom_button_tap.dart';
import 'package:market_place/core/constants/color_constants.dart';
import 'package:market_place/core/constants/custom_text.dart';
import 'package:market_place/core/constants/fontsize_constant.dart';
import 'package:market_place/core/constants/padding_constant.dart';
import 'package:market_place/core/constants/text_style_constant.dart';
import 'package:market_place/presentations/auth/views/login_page.dart';
import 'package:market_place/presentations/auth/views/subscription_page.dart';
import 'package:market_place/presentations/notification/views/notification_page.dart';

import '../../../core/components/custom_appbar.dart';
import '../../../core/constants/app_static_strings.dart';
import '../../../core/utils/variable.dart';
import '../controller/navigation_controller.dart';

class NavigationPage extends StatelessWidget {
  static const String routeName = "/nav";

  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> appbarTitle = [
      AppStaticStrings.myListings.tr,
      AppStaticStrings.addNewListing.tr,
      AppStaticStrings.messages.tr,
      AppStaticStrings.profile.tr,
    ];
    List<String> labels = [
      AppStaticStrings.home.tr,
      AppStaticStrings.myListings.tr,
      AppStaticStrings.sellNow.tr,
      AppStaticStrings.messages.tr,
      AppStaticStrings.profile.tr,
    ];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Obx(() {
          return NavigationController.to.selectedNavIndex.value == 0
              ? Builder(
                builder: (context) {
                  return CustomHomeAppbar(
                    onActionTap: () {
                      if (NavigationController.to.isLoggedIn) {
                        Get.toNamed(NotificationPage.routeName);
                      } else {
                        Get.toNamed(LoginPage.routeName);
                      }
                    },
                  );
                },
              )
              : CustomDefaultAppbar(
                leading: IconButton(
                  onPressed: () {
                    NavigationController.to.selectedNavIndex.value = 0;
                  },
                  icon: Icon(Icons.arrow_back_rounded),
                ),
                title:
                    appbarTitle[NavigationController.to.selectedNavIndex.value -
                        1],
              );
        }),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return IndexedStack(
                index: NavigationController.to.selectedNavIndex.value,
                children: NavigationController.to.getPages(),
              );
            }),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: padding6H,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(radiusCommon),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .2),
                blurRadius: 20.r,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:
                List.generate(
                  NavigationController.to.icons.length,
                  (index) => Expanded(
                    // Add Expanded to distribute space evenly
                    child: ButtonTapWidget(
                      onTap: () {
                        logger.d(NavigationController.to.isSubscribed);
                        if (!NavigationController
                            .to
                            .isLoggedIn /*&&NavigationController.to.selectedNavIndex.value!=0*/ ) {
                          Get.toNamed(LoginPage.routeName);
                        } else if ((index ==
                                    1 ||
                                index ==
                                    2) &&
                            NavigationController.to.isSubscribed==false) {
                          Get.toNamed(SubscriptionPage.routeName);
                        } else {
                          NavigationController.to.selectedNavIndex.value =
                              index;
                        }
                      },
                      child: Padding(
                        padding: padding6V,
                        child: Obx(() {
                          bool isSelected =
                              NavigationController.to.selectedNavIndex.value ==
                              index;
                          return Column(
                            mainAxisSize:
                                MainAxisSize
                                    .min, // Use min to prevent column from expanding
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (isSelected)
                                AnimatedContainer(
                                  duration: const Duration(microseconds: 10),
                                  curve: Curves.linear,

                                  transform: Matrix4.translationValues(
                                    0,
                                    -20,
                                    0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,

                                    // border: Border.all(
                                    //   width: 6.w,
                                    //   color: AppColors.kWhiteColor,
                                    // ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.kPrimaryColor
                                            .withValues(alpha: .2),
                                        blurRadius: 4.r,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  padding: padding6,
                                  child: Container(
                                    padding: padding12,
                                    // transform: Matrix4.translationValues(0, -20, 0),
                                    decoration: BoxDecoration(
                                      color:
                                          isSelected
                                              ? Colors.green
                                              : Colors.transparent,
                                      shape: BoxShape.circle,

                                      // border: Border.all(
                                      //   width: 6.w,
                                      //   color: AppColors.kWhiteColor,
                                      // ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.kPrimaryColor
                                              .withValues(alpha: .2),
                                          blurRadius: 4.r,
                                          offset: Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: SvgPicture.asset(
                                      NavigationController.to.icons[index],
                                      colorFilter: ColorFilter.mode(
                                        isSelected
                                            ? Colors.white
                                            : Colors.black,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                )
                              else
                                SvgPicture.asset(
                                  NavigationController.to.icons[index],
                                  colorFilter: ColorFilter.mode(
                                    Colors.black,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              if (!isSelected)
                                Padding(
                                  padding: EdgeInsets.only(top: 4.w),
                                  child: CustomText(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: getFontSizeSmall(),
                                    style: poppinsMedium,
                                    text: labels[index],
                                  ),
                                ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                ).toList(),
          ),
        ),
      ),
    );
  }
}
