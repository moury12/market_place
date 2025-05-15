import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:market_place/core/components/custom_appbar.dart';
import 'package:market_place/core/components/custom_network_image.dart';
import 'package:market_place/core/components/custom_refresh_indicator.dart';
import 'package:market_place/core/constants/app_static_strings.dart';
import 'package:market_place/core/constants/custom_space.dart';
import 'package:market_place/core/constants/custom_text.dart';
import 'package:market_place/core/constants/fontsize_constant.dart';
import 'package:market_place/core/constants/image_constants.dart';
import 'package:market_place/core/constants/pagination_loading_widget.dart';
import 'package:market_place/core/constants/text_style_constant.dart';
import 'package:market_place/core/helper/helper_function.dart';
import 'package:market_place/presentations/product/widgets/image_list_widget.dart';

import '../../../core/api-client/api_service.dart';
import '../../../core/components/custom_loading_widget.dart';
import '../../../core/components/custom_textfield.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/constants/padding_constant.dart';
import '../controllers/message_controller.dart';
import '../model/conversation_model.dart';
import '../widgets/chat_message_card_item_widget.dart';

class ChattingPage extends StatelessWidget {
  static const String routeName = '/chatting';

  ChattingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final String conversationId = args["conversation_id"];
    final Users receiverUser = args["receive_user"];

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomDefaultAppbar(title: 'Alex Wheeler'),
      body: CustomRefreshIndicatorWidget(
        onRefresh: () async {
          MessageController.to.getMessageListRequest(
            conversationId: conversationId.toString(),
          );
        },

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Obx(() {
                  return /*!MessageController.to.isLoadingMessage.value?
                  CustomLoadingWidget(
                    height: ScreenUtil().screenHeight,
                    size: 30.sp,
                    width: ScreenUtil().screenWidth,
                  )
                      :*/ Column(
                    children: [
                      CustomNetworkImage(
                        imageUrl: "${ApiService().baseUrl}/${receiverUser.img}",
                        height: 75.w,
                        width: 75.w,
                        boxShape: BoxShape.circle,
                      ),
                      space4H,
                      CustomText(
                        text: receiverUser.name ?? "Jane Cooper",
                        style: poppinsSemiBold,
                        fontSize: getFontSizeDefault(),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        // primary: false,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        itemCount: MessageController.to.messageList.length,
                        itemBuilder: (context, index) {
                          final message =
                              MessageController.to.messageList[index];

                          return ChatMessageCardItemWidget(
                            message: message,
                            receiverUser: receiverUser,
                          );
                        },
                      ),
                    ],
                  );
                }),
              ),
            ),
            Padding(
              padding: padding8.copyWith(bottom: 0),
              child: ListOfImages(
                images: MessageController.to.imgList,
                size: 50.w,
                isNetworkImage: false,
              ),
            ),
            Padding(
              padding: padding8,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      pickImages(
                        allowMultiple: true,
                        uploadImages: MessageController.to.imgList,
                      );
                    },
                    icon: SvgPicture.asset(imgIcon),
                  ),
                  Expanded(
                    child: CustomTextField(
                      hintText: AppStaticStrings.typeMessage.tr,
                      textEditingController:
                          MessageController.to.messageController,
                      borderColor: AppColors.kPrimaryColor,
                      fillColor: AppColors.kWhiteColor,
                      borderRadius: 16.r,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  Obx(() {
                        return  MessageController.to.isLoadingCreateMessage.value
                            ? PaginationLoadingWidget()  : IconButton(
                          onPressed: () {
                            if (MessageController
                                .to
                                .messageController
                                .text
                                .isNotEmpty ||
                                MessageController.to.imgList.isNotEmpty) {
                              MessageController.to.createMessageRequest(
                                conversationId: conversationId,
                              );
                            }
                          },
                          icon: SvgPicture.asset(sendMessageIcon),
                        );
                      })
                    ,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
