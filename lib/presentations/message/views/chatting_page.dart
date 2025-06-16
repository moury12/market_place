import 'dart:io';

import 'package:flutter/cupertino.dart';
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
import '../../../core/components/custom_textfield.dart';
import '../../../core/constants/color_constants.dart';
import '../../../core/constants/padding_constant.dart';
import '../controllers/message_controller.dart';
import '../model/conversation_model.dart';
import '../widgets/chat_message_card_item_widget.dart';

class ChattingPage extends StatefulWidget {
  static const String routeName = '/chatting';

  const ChattingPage({super.key});

  @override
  State<ChattingPage> createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {
  ScrollController messageScrollController = ScrollController();
  final args = Get.arguments as Map<String, dynamic>;
  String conversationId = "";
  Users? receiverUser;
  bool isFirstLoad = true;

  @override
  void initState() {
    super.initState();
    conversationId = args["conversation_id"];
    receiverUser = args["receive_user"];

    // Setup scroll controller to detect when we reach the top
    messageScrollController.addListener(() {
      if (messageScrollController.position.pixels ==
          messageScrollController.position.maxScrollExtent) {
        MessageController.to.getMessageListRequest(
          conversationId: conversationId,
          loadMore: true,
        );
      }
    });

    // Initial message load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialMessages();
    });
  }

  void _loadInitialMessages() async {
    await MessageController.to.getMessageListRequest(
      conversationId: conversationId.toString(),
    );

    // Scroll to bottom after initial load
    _scrollToBottom();
  }

  void _scrollToBottom() {
    if (messageScrollController.hasClients) {
      messageScrollController.animateTo(
        messageScrollController
            .position
            .minScrollExtent, // ⬅️ bottom in reverse:true
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: CustomDefaultAppbar(title: receiverUser?.name ?? 'Chat'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User profile info at the top
          MessageController.to.messageList.isNotEmpty?SizedBox.shrink(): _buildReceiverProfile(),
          Obx(() {
            return MessageController.to.isLoadingMoreMessages.value
                ? PaginationLoadingWidget()
                : SizedBox.shrink();
          }),
          // Messages list (expanded to take available space)
          Expanded(
            child: Obx(() {
              // Check if messages are loaded
              if (MessageController.to.messageList.isNotEmpty && isFirstLoad) {
                // Scroll to bottom on first load
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _scrollToBottom();
                  isFirstLoad = false;
                });
              }

              return ListView.builder(
                controller: messageScrollController,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                // Reverse the list to show newest at bottom
                reverse: true,
                itemCount: MessageController.to.messageList.length,
                itemBuilder: (context, index) {
                  final message = MessageController.to.messageList[index];
                  return ChatMessageCardItemWidget(
                    message: message,
                    receiverUser: receiverUser!,
                  );
                },
              );
            }),
          ),

          // Image preview section
         Obx(() {
            return  MessageController.to.img.value.isNotEmpty
                ?  Stack(
              children: [
                Padding(
                  padding: padding8.copyWith(bottom: 0),
                  child: Image.file(
                    height: 100.w,
                    width: 100.w,
                    fit: BoxFit.cover,
                    File(MessageController.to.img.toString()),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: IconButton(
                    onPressed: () {
                      MessageController.to.img.value = "";
                    },
                    icon: Icon(
                      CupertinoIcons.multiply_circle_fill,
                      color: AppColors.kRedColor,
                    ),
                  ),
                ),
              ],
            ) : SizedBox.shrink();
          }),


          // Message input section
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildReceiverProfile() {
    return Center(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomNetworkImage(
            imageUrl: "${ApiService().baseUrl}/${receiverUser!.img}",
            height: 75.w,
            width: 75.w,
            boxShape: BoxShape.circle,
          ),
          space4H,
          CustomText(
            text: receiverUser!.name ?? "Jane Cooper",
            style: poppinsSemiBold,
            fontSize: getFontSizeDefault(),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: padding8,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              pickImages(
                allowMultiple: false,
                singleImagePath: MessageController.to.img,
              );
            },
            icon: SvgPicture.asset(imgIcon),
          ),
          Expanded(
            child: CustomTextField(
              hintText: AppStaticStrings.typeMessage.tr,
              textEditingController: MessageController.to.messageController,
              borderColor: AppColors.kPrimaryColor,
              fillColor: AppColors.kWhiteColor,
              borderRadius: 16.r,
              contentPadding: EdgeInsets.zero,
            ),
          ),
          Obx(() {
            return MessageController.to.isLoadingCreateMessage.value
                ? PaginationLoadingWidget()
                : IconButton(
              onPressed: () {
                if (MessageController
                    .to
                    .messageController
                    .text
                    .isNotEmpty ||
                    MessageController.to.img.isNotEmpty) {
                  MessageController.to
                      .createMessageRequest(conversationId: conversationId)
                      .then((_) {
                    // After sending message, scroll to bottom
                    _scrollToBottom();
                  });
                }
              },
              icon: SvgPicture.asset(sendMessageIcon),
            );
          }),
        ],
      ),
    );
  }

  @override
  void dispose() {
    messageScrollController.dispose();
    super.dispose();
  }
}
