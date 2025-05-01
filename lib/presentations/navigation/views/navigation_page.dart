import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:market_place/core/components/custom_button_tap.dart';
import 'package:market_place/core/constants/color_constants.dart';
import 'package:market_place/core/constants/padding_constant.dart';

import '../controller/navigation_controller.dart';

class NavigationPage extends StatelessWidget {
  static const String routeName = "/nav";

  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NavigationControllerMain.to.screens[NavigationControllerMain.to.selectedNavIndex.value],
      bottomNavigationBar: Container(
        padding: padding14.copyWith(bottom: 6.h),
        height: 80.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusCommon)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .1),
              blurRadius: 20.r,
              // offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            NavigationControllerMain.to.icons.length,
            (index) => GestureDetector(
              onTap: () {
                NavigationControllerMain.to.selectedNavIndex.value = index;
              },
              child: Obx(() {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    NavigationControllerMain.to.selectedNavIndex.value == index
                        ? AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      transform: Matrix4.translationValues(0, NavigationControllerMain.to.selectedNavIndex.value == index ? -30 : 0, 0),

                      padding: padding6,
                          decoration: BoxDecoration(
                           color: AppColors.kWhiteColor,
                            shape: BoxShape.circle,

                          ),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            padding: padding12,
                            // transform: Matrix4.translationValues(0, NavigationControllerMain.to.selectedNavIndex.value == index ? -30 : 0, 0),
                            decoration: BoxDecoration(
                              color: NavigationControllerMain.to.selectedNavIndex.value == index ? Colors.green : Colors.transparent,
                              shape: BoxShape.circle,
                              /* border: Border.all(width: 6.w,color: AppColors.kWhiteColor),*/ boxShadow: [
                                BoxShadow(color: AppColors.kPrimaryAccentColor, blurRadius: 4.r,offset: Offset(0, 4)),
                              ],
                            ),
                            child: SvgPicture.asset(
                              NavigationControllerMain.to.icons[index],
                              colorFilter: ColorFilter.mode(
                                NavigationControllerMain.to.selectedNavIndex.value == index ? Colors.white : Colors.black,
                                BlendMode.srcIn,
                              ),
                              // height: 24.w,
                              // width: 24.w,
                            ),
                          ),
                        )
                        : SvgPicture.asset(
                          NavigationControllerMain.to.icons[index],
                          colorFilter: ColorFilter.mode(
                            NavigationControllerMain.to.selectedNavIndex.value == index ? Colors.white : Colors.black,
                            BlendMode.srcIn,
                          ),
                          // height: 24.w,
                          // width: 24.w,
                        ),
                    NavigationControllerMain.to.selectedNavIndex.value == index
                        ? SizedBox.shrink()
                        : Text(
                          NavigationControllerMain.to.labels[index],
                          style: TextStyle(
                            color: NavigationControllerMain.to.selectedNavIndex.value == index ? Colors.transparent : Colors.black54,
                            fontSize: 12,
                            fontWeight: NavigationControllerMain.to.selectedNavIndex.value == index ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
