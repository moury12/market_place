import 'package:flutter_svg/flutter_svg.dart';
import 'package:market_place/core/components/custom_button_tap.dart';
import 'package:market_place/core/components/custom_network_image.dart';
import 'package:market_place/core/constants/color_constants.dart';
import 'package:market_place/core/constants/custom_text.dart';
import 'package:market_place/core/constants/image_constants.dart';
import 'package:market_place/core/constants/padding_constant.dart';
import 'package:market_place/core/constants/text_style_constant.dart';
import 'package:market_place/core/utils/variable.dart';
import 'package:market_place/presentations/home/widgets/product_card_item_widget.dart';

import 'package:market_place/presentations/profile/views/edit_profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_static_strings.dart';
class ProfileInfoDetailsWidget extends StatelessWidget {
  final bool isEdit;
  const ProfileInfoDetailsWidget({
    super.key,  this.isEdit = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12.w,
      children: [
        CustomNetworkImage(
          imageUrl: dummyProfileImage,
          height: 80.w,
          width: 80.w,
        ),
        Expanded(
          child: Column(
            spacing: 4.w,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              CustomText(
                text: "Ely Mohammed",
                style: poppinsMedium,
              ),
              Row(
                spacing: 4.w,
                children: [
                  SvgPicture.asset(mainIcon),
                  Expanded(
                    child: CustomText(
                      text: "Marvin@gmail.com",
                      style: poppinsRegular,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 4.w,
                children: [
                  SvgPicture.asset(
                    callIcon,
                    colorFilter: ColorFilter.mode(
                      AppColors.kPrimaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  Expanded(
                    child: CustomText(
                      text: "(555) 123-4567",
                      style: poppinsRegular,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        isEdit?   ButtonTapWidget(
          onTap: () {
            Get.toNamed(EditProfilePage.routeName);
          },
          child: GreenAccentContainerWidget(
            radius: 4.r,
            child: Padding(
              padding: padding2,
              child: Row(
                spacing: 4.w,
                children: [
                  SvgPicture.asset(
                    editIcon,
                    colorFilter: ColorFilter.mode(
                      AppColors.kPrimaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  CustomText(
                    text: AppStaticStrings.editProfile,
                    style: poppinsRegular,
                    color: AppColors.kPrimaryColor,
                    fontSize: 10.sp,
                  ),
                ],
              ),
            ),
          ),
        ):SizedBox.shrink(),
      ],
    );
  }
}
