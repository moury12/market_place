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
  RxString img = "".obs;

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

  ///====================conversation pagination variable========================///

  final RxInt currentPage = 1.obs;
  final RxInt itemsPerPage = 10.obs;
  final RxInt totalCategoryPages = 5.obs;
  final RxBool isLoadingMore = false.obs;

  ///===============================message pagination variable======================///
  RxInt messageCurrentPage = 1.obs;
  RxInt totalMessagePages = 1.obs;
  RxInt messageItemsPerPage = 10.obs;
  RxBool isLoadingMoreMessages = false.obs;



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

  ///------------------------------  get conversation list method -------------------------///

  Future<void> getConversationListRequest({bool loadMore = false}) async {
    try {
      if (loadMore && currentPage.value >= totalCategoryPages.value) {
        return;
      }

      if (loadMore) {
        currentPage.value++;
        isLoadingMore.value = true;
      } else {
        isLoadingConversation.value = true;
        currentPage.value = 1;
      }
      ApiService().setAuthToken(Boxes.getUserData().get(tokenKey).toString());

      final response = await ApiService().request(
        endpoint: conversationListEndPoint,
        method: 'GET',
        queryParams: {
          'page': currentPage.value.toString(),
          'limit': itemsPerPage.value.toString(),
          'sort': 'updatedAt',
          'order': 'desc',
        },
      );

      isLoadingConversation.value = false;
      isLoadingMore.value = false;
      if (response['success'] == true) {
        if (response['pagination'] != null) {
          currentPage.value = response['pagination']['currentPage'] ?? 1;
          totalCategoryPages.value =
              response['pagination']['totalPages'] ?? 1; // Add this line

          itemsPerPage.value = response['pagination']['itemsPerPage'] ?? 10;
        }
        final newCategories =
            (response['data'] as List)
                .map((e) => ConversationModel.fromJson(e))
                .toList();

        if (loadMore) {
          conversationList.addAll(newCategories); // Append for load more
        } else {
          conversationList.value = newCategories; // Replace for refresh
        }
        logger.d(response);
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

  Future<void> getMessageListRequest({
    required String conversationId,
    bool loadMore = false,
  }) async {
    try {
      if (loadMore && messageCurrentPage.value >= totalMessagePages.value) {
        return;
      }

      if (loadMore) {
        messageCurrentPage.value++;
        isLoadingMoreMessages.value = true;
      } else {
        messageCurrentPage.value = 1;
        isLoadingMessage.value = true;
      }

      ApiService().setAuthToken(Boxes.getUserData().get(tokenKey).toString());

      final response = await ApiService().request(
        endpoint: messageListEndPoint,
        queryParams: {
          "conversation_id": conversationId,
          "page": messageCurrentPage.value.toString(),
          "limit": messageItemsPerPage.value.toString(),
          "sort": "createdAt",
          "order": "desc", // or "asc" depending on your display order
        },
        method: 'GET',
      );

      isLoadingMessage.value = false;
      isLoadingMoreMessages.value = false;

      if (response['success'] == true) {
        logger.d(response);

        if (response['pagination'] != null) {
          messageCurrentPage.value = response['pagination']['currentPage'] ?? 1;
          totalMessagePages.value = response['pagination']['totalPages'] ?? 1;
          messageItemsPerPage.value = response['pagination']['itemsPerPage'] ?? 20;
        }

        final newMessages = (response['data'] as List)
            .map((e) => MessageModel.fromJson(e))
            .toList();

        if (loadMore) {
          messageList.addAll(newMessages); // append
        } else {
          messageList.value = newMessages; // reset
        }
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
      isLoadingMoreMessages.value = false;
    }
  }


  ///------------------------------  create conversation method -------------------------///

  Future<void> createConversationRequest({required String userId}) async {
    try {
      isLoadingCreateConversation.value = true;
      ApiService().setAuthToken(Boxes.getUserData().get(tokenKey).toString());

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

      if (img.value.isNotEmpty) {
        File imageFile = File(img.value);
        files['img'] = [imageFile]; // Send as a list even if single
      }

      final response = await ApiService().multipartRequest(
        endpoint: messageCreateEndPoint,
        method: 'POST',
        fields: fields,
        files: files,
      );

      messageController.clear();
      img.value = "";
      isLoadingCreateMessage.value = false;

      if (response['success'] == true) {
        logger.d(response);
        getMessageListRequest(conversationId: conversationId);
        // showCustomSnackbar(title: 'Success', message: response['message']);
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
