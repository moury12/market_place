import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:market_place/core/components/custom_appbar.dart';
import 'package:market_place/core/components/custom_button.dart';
import 'package:market_place/core/components/custom_network_image.dart';
import 'package:market_place/core/constants/app_static_strings.dart';
import 'package:market_place/core/constants/color_constants.dart';
import 'package:market_place/core/constants/custom_space.dart';
import 'package:market_place/core/constants/image_constants.dart';
import 'package:market_place/core/constants/padding_constant.dart';
import 'package:market_place/core/utils/variable.dart';

import '../../../core/components/custom_textfield.dart';

class EditProfilePage extends StatelessWidget {
  static const String routeName = "/edit-profile";
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomDefaultAppbar(title: AppStaticStrings.editProfile),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: padding12,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 12.h,
              children: [
                Stack(
                  children: [
                    CustomNetworkImage(
                      imageUrl: dummyProfileImage,
                      boxShape: BoxShape.circle,
                      height: 150.w,
                      width: 150.w,
                    ),

                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.kPrimaryAccentColor,
                      ),
                        padding: padding4,
                        child: SvgPicture.asset(
                          cameraIcon,
                          height: 20.w,
                          colorFilter: ColorFilter.mode(
                            AppColors.kPrimaryColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                CustomTextField(
                  fillColor: AppColors.kWhiteColor,
                  title: AppStaticStrings.name,

                ),CustomTextField(
                  fillColor: AppColors.kWhiteColor,
                  title: AppStaticStrings.email,

                ),CustomTextField(
                  fillColor: AppColors.kWhiteColor,
                  title: AppStaticStrings.contactNumber,

                ),
                space8H,
                CustomButton(onTap: () {
                  
                },title: AppStaticStrings.update,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
