import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_place/core/api-client/api_service.dart';
import 'package:market_place/presentations/message/controllers/message_controller.dart';
import 'package:market_place/presentations/profile/controllers/account_information_controller.dart';

import '../../../core/components/custom_button_tap.dart';
import '../../../core/components/custom_network_image.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/constants/custom_text.dart';
import '../../../core/constants/fontsize_constant.dart';
import '../../../core/constants/padding_constant.dart';
import '../../../core/constants/text_style_constant.dart';
import '../../../core/utils/variable.dart';
import '../model/conversation_model.dart';
import '../views/chatting_page.dart';

class MessageCardItemWidget extends StatelessWidget {
  final ConversationModel conversation;
  final Users receiverUser; // ✅ Add this

  const MessageCardItemWidget({super.key, required this.conversation, required this.receiverUser});

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        color: AppColors.kWhiteColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.kBlackColor.withValues(alpha: .1),
            blurRadius: 12.r,
          ),
        ],
      ),
      child: ButtonTapWidget(
        radius: 16.r,
        onTap: () async {
          logger.d(
            'new-message::${conversation.sId}-${AccountInformationController.to.userModel.value.sId}',
          );
          MessageController.to.messageList.clear();
          MessageController.to.socket.on(
            'new-message::${conversation.sId}-${AccountInformationController.to.userModel.value.sId}',
            (data) {
              MessageController.to.getMessageListRequest(
                conversationId: conversation.sId.toString(),
              );
            },
          );
          //  MessageController.to.getMessageListRequest(
          //   conversationId: conversation.sId.toString(),
          // );
          Get.toNamed(
            ChattingPage.routeName,
            arguments: {"conversation_id":conversation.sId.toString(),
            "receive_user":receiverUser},
          );
        },
        child: Padding(
          padding: padding12,
          child:  Row(
              spacing: 12.w,
              children: [
                CustomNetworkImage(
                  imageUrl:
                      "${ApiService().baseUrl}/${receiverUser.img}",
                  boxShape: BoxShape.circle,
                  height: 50.w,
                  width: 50.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///=============================dynamic user name =============================///
                      CustomText(
                        text:
                            receiverUser.name ??
                            'User Name',
                        style: poppinsSemiBold,
                      ),

                      ///=============================dynamic message =============================///
                      CustomText(
                        text: 'New message',
                        style: poppinsRegular,
                        fontSize: getFontSizeSmall(),
                      ),
                    ],
                  ),
                ),

              ],
            )
        ),
      ),
    );
  }
}
