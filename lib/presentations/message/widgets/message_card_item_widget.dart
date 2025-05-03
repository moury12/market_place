import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/components/custom_button_tap.dart';
import '../../../core/components/custom_network_image.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/constants/custom_text.dart';
import '../../../core/constants/fontsize_constant.dart';
import '../../../core/constants/padding_constant.dart';
import '../../../core/constants/text_style_constant.dart';
import '../../../core/utils/variable.dart';
import '../views/chatting_page.dart';
class MessageCardItemWidget extends StatelessWidget {
  final bool? isRead;
  const MessageCardItemWidget({super.key, this.isRead = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isRead == false ? AppColors.kPrimaryAccentColor : AppColors.kWhiteColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [BoxShadow(color: AppColors.kBlackColor.withValues(alpha: .1),blurRadius: 12.r)],
      ),
      child: ButtonTapWidget(
        radius: 16.r,
        onTap: () {
Get.toNamed(ChattingPage.routeName);
        },
        child: Padding(
          padding: padding12,
          child: Row(
            spacing: 12.w,
            children: [
              CustomNetworkImage(
                imageUrl: dummyProfileImage,
                boxShape: BoxShape.circle,
                height: 50.w,
                width: 50.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///=============================dynamic user name =============================///
                    CustomText(text: 'Alex Wheeler', style: poppinsSemiBold),



                    ///=============================dynamic message =============================///
                    CustomText(
                      text: 'Hello! Im available to pick you up. Ill be th..',
                      style: poppinsRegular,
                      fontSize: getFontSizeSmall(),
                    ),
                  ],
                ),
              ),
              CustomText(
                text: '09/27/24',
                style: poppinsRegular,
                color: AppColors.kExtraLightGreyTextColor,
                fontSize: getFontSizeSmall(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
