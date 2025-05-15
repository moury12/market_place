import 'package:market_place/core/components/custom_network_image.dart';
import 'package:market_place/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_place/core/constants/custom_text.dart';
import 'package:market_place/presentations/message/model/message_model.dart';
import 'package:market_place/presentations/profile/controllers/account_information_controller.dart';

import '../../../core/api-client/api_service.dart';
import '../model/conversation_model.dart';

class ChatMessageCardItemWidget extends StatelessWidget {
  const ChatMessageCardItemWidget({super.key, required this.message,
    required this.receiverUser});

  final MessageModel message;
  final Users receiverUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24),
      child:
         Row(
          mainAxisAlignment:
              message.sender != receiverUser.sId
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Driver avatar (only for driver messages)
            if (message.sender != receiverUser.sId)
              CustomNetworkImage(
                imageUrl:
                    "${ApiService().baseUrl}/${AccountInformationController.to.userModel.value.img}",
                height: 50.w,
                boxShape: BoxShape.circle,
                width: 50.w,
              ),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    message.sender !=
                            receiverUser.sId
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.end,
                children: [
                  // Message container
                  Container(
                    margin: EdgeInsets.only(
                      left:
                          message.sender !=
                                  receiverUser.sId
                              ? 8
                              : 0,
                      right:
                          message.sender !=
                                  receiverUser.sId
                              ? 0
                              : 8,
                    ),
                    constraints: BoxConstraints(maxWidth: Get.width * 0.7),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.kPrimaryAccentColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: message.message.toString(),
                          style: TextStyle(
                            color: AppColors.kBlackColor,
                            fontSize: 15,
                          ),
                        ),
                        message.img != null && message.img!.isNotEmpty
                            ? CustomNetworkImage(
                          height: 120,

                               fit: BoxFit.contain,
                              imageUrl:
                                  "${ApiService().baseUrl}/${message.img}",
                            )
                            : SizedBox.shrink(),
                      ],
                    ),
                  ),

                  // Timestamp
                  Padding(
                    padding: EdgeInsets.only(
                      top: 4,
                      left:
                          message.sender !=
                                  receiverUser.sId
                              ? 8
                              : 0,
                      right:
                          message.sender !=
                                  receiverUser.sId
                              ? 0
                              : 8,
                    ),
                    child: Text(
                      message.createdAt.toString(),
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ),
                ],
              ),
            ),

            // User avatar (only for user messages)
            if (message.sender == receiverUser.sId)
              CustomNetworkImage(
                imageUrl:
                    "${ApiService().baseUrl}/${receiverUser.img}",
                height: 50.w,
                boxShape: BoxShape.circle,
                width: 50.w,
              ),
          ],
        )

    );
  }
}
