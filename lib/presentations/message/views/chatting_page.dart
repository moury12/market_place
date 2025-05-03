import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:market_place/core/components/custom_appbar.dart';
import 'package:market_place/core/components/custom_network_image.dart';
import 'package:market_place/core/constants/custom_space.dart';
import 'package:market_place/core/constants/custom_text.dart';
import 'package:market_place/core/constants/fontsize_constant.dart';
import 'package:market_place/core/constants/image_constants.dart';
import 'package:market_place/core/constants/text_style_constant.dart';
import 'package:market_place/core/utils/variable.dart';

import '../../../core/components/custom_textfield.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/constants/padding_constant.dart';
import '../controllers/message_controller.dart';
import '../widgets/chat_message_card_item_widget.dart';

class ChattingPage extends StatelessWidget {
  static const String routeName = '/chatting';
  const ChattingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomDefaultAppbar(title: 'Alex Wheeler'),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomNetworkImage(
                    imageUrl: dummyProfileImage,
                    height: 75.w,
                    width: 75.w,
                    boxShape: BoxShape.circle,
                  ),
                  space4H,
                  CustomText(
                    text: "Jane Cooper",
                    style: poppinsSemiBold,
                    fontSize: getFontSizeDefault(),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    // primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    itemCount: MessageController.to.messages.length,
                    itemBuilder: (context, index) {
                      final message = MessageController.to.messages[index];
                      final isDriverMessage = message.isFromDriver;
                      return ChatMessageCardItemWidget(
                        isDriverMessage: isDriverMessage,
                        message: message,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: padding8,
            child: Row(
              children: [
                IconButton(onPressed: () {}, icon: SvgPicture.asset(imgIcon)),
                Expanded(
                  child: CustomTextField(
                    hintText: 'Type message...',

                    borderColor: AppColors.kPrimaryColor,
                    fillColor: AppColors.kWhiteColor,
                    borderRadius: 16.r,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(sendMessageIcon),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
