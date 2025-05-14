import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:market_place/presentations/message/model/conversation_model.dart';
import 'package:market_place/presentations/navigation/controller/navigation_controller.dart';
import 'package:market_place/presentations/navigation/views/navigation_page.dart';
import 'package:market_place/presentations/profile/controllers/account_information_controller.dart';

import '../../../core/api-client/api_endpoints.dart';
import '../../../core/api-client/api_service.dart';
import '../../../core/helper/helper_function.dart';
import '../../../core/utils/hive_boxes.dart';
import '../../../core/utils/variable.dart';
import '../model/chat_message_model.dart';
import '../model/message_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MessageController extends GetxController {
  final messages = <ChatMessage>[].obs;
  RxList<String> imgList = <String>[].obs;

  static MessageController get to => Get.find();
  RxBool isLoadingCreateConversation = false.obs;
  RxBool isLoadingCreateMessage = false.obs;
  RxBool isLoadingConversation = false.obs;
  RxBool isLoadingMessage = false.obs;
  var tabContent = <Widget>[].obs;
  RxList<ConversationModel> conversationList = <ConversationModel>[].obs;
  RxList<MessageModel> messageList = <MessageModel>[].obs;
  Rx<Users> receiverUser = Users().obs;
  TextEditingController messageController = TextEditingController();
  late IO.Socket socket;

  @override
  void onInit() {
    super.onInit();
    // if (AccountInformationController.to.userModel.value.sId != null &&
    //     AccountInformationController.to.userModel.value.sId!.isNotEmpty) {
      socket = IO.io(
        '${ApiService().baseUrl}?user_id=${AccountInformationController.to.userModel.value.sId}',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build(),
      );

      socket.connect();

      socket.onConnect((_) {
        logger.d('✅ Socket connected');
        socket.emit('msg', 'test');
      });

      socket.onConnectError((data) {
        logger.e('❌ Socket connect error: $data');
      });

      socket.onError((data) {
        logger.e('❌ Socket error: $data');
      });

      socket.onDisconnect((_) {
        logger.e('🔌 Socket disconnected');
      });


  // }
    getConversationListRequest();
  }

  ///------------------------------ get conversation list method -------------------------///

  Future<void> getConversationListRequest() async {
    try {
      isLoadingConversation.value = true;
      ApiService().setAuthToken(Boxes.getUserData().get(tokenKey).toString());

      final response = await ApiService().request(
        endpoint: conversationListEndPoint,

        method: 'GET',
      );
      isLoadingConversation.value = false;
      if (response['success'] == true) {
        logger.d(response);
        conversationList.value =
            (response['data'] as List)
                .map((e) => ConversationModel.fromJson(e))
                .toList();
      } else {
        logger.e(response);
        showCustomSnackbar(
          title: 'Failed',
          message: response['message'],
          type: SnackBarType.failed,
        );
      }
    } catch (e) {
      logger.e(e.toString());
      isLoadingConversation.value = false;
    }
  }

  ///------------------------------ get message list method -------------------------///

  Future<void> getMessageListRequest({required String conversationId}) async {
    try {
      isLoadingMessage.value = true;
      ApiService().setAuthToken(Boxes.getUserData().get(tokenKey).toString());

      final response = await ApiService().request(
        endpoint: messageListEndPoint,
        queryParams: {"conversation_id": conversationId},
        method: 'GET',
      );
      isLoadingMessage.value = false;
      if (response['success'] == true) {
        logger.d(response);
        messageList.value =
            (response['data'] as List)
                .map((e) => MessageModel.fromJson(e))
                .toList();
      } else {
        logger.e(response);
        showCustomSnackbar(
          title: 'Failed',
          message: response['message'],
          type: SnackBarType.failed,
        );
      }
    } catch (e) {
      logger.e(e.toString());
      isLoadingMessage.value = false;
    }
  }

  ///------------------------------  create conversation method -------------------------///

  Future<void> createConversationRequest({required String userId}) async {
    try {
      isLoadingCreateConversation.value = true;
      final response = await ApiService().request(
        endpoint: conversationCreateEndPoint,
        method: 'POST',
        body: {"user": userId},
      );

      if (response['success'] == true) {
        logger.d(response);

        showCustomSnackbar(title: 'Success', message: response['message']);
        await getConversationListRequest();
        NavigationController.to.selectedNavIndex.value = 3;
        isLoadingCreateConversation.value = false;
        Get.toNamed(NavigationPage.routeName);
      } else {
        logger.e(response);

        NavigationController.to.selectedNavIndex.value = 3;
        Get.toNamed(NavigationPage.routeName);
      }
    } catch (e) {
      isLoadingCreateConversation.value = false;
      logger.e(e.toString());
    }
  }

  ///------------------------------  create Message method -------------------------///

  Future<void> createMessageRequest({required String conversationId}) async {
    try {
      isLoadingCreateMessage.value = true;

      ApiService().setAuthToken(Boxes.getUserData().get(tokenKey).toString());
      Map<String, String> fields = {
        'message': messageController.value.text,
        'conversation_id': conversationId,
      };
      Map<String, dynamic> files = {};
      if (imgList.isNotEmpty) {
        List<File> docFiles = [];
        for (String path in imgList) {
          if (path.isNotEmpty) {
            docFiles.add(File(path));
          }
        }
        if (docFiles.isNotEmpty) {
          files['img'] = docFiles;
        }
      }
      final response = await ApiService().multipartRequest(
        endpoint: messageCreateEndPoint,
        method: 'POST',

        fields: fields,
        files: files,
      );
      isLoadingCreateMessage.value = false;
      if (response['success'] == true) {
        logger.d(response);
        getMessageListRequest(conversationId: conversationId);
        imgList.clear();
        messageController.clear();
        showCustomSnackbar(title: 'Success', message: response['message']);
      } else {
        logger.e(response);
        showCustomSnackbar(
          title: 'Failed',
          message: response['message'],
          type: SnackBarType.failed,
        );
      }
    } catch (e) {
      logger.e(e.toString());
      isLoadingCreateMessage.value = false;
    }
  }
}
