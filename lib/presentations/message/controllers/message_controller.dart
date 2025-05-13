import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:market_place/presentations/navigation/controller/navigation_controller.dart';
import 'package:market_place/presentations/navigation/views/navigation_page.dart';

import '../../../core/api-client/api_endpoints.dart';
import '../../../core/api-client/api_service.dart';
import '../../../core/helper/helper_function.dart';
import '../../../core/utils/hive_boxes.dart';
import '../../../core/utils/variable.dart';
import '../model/chat_message_model.dart';

class MessageController extends GetxController {
  final messages = <ChatMessage>[].obs;
  RxList<String> imgList = <String>[].obs;

  static MessageController get to => Get.find();
  RxBool isLoadingCreateConversation = false.obs;
  RxBool isLoadingCreateMessage = false.obs;
  var tabContent = <Widget>[].obs;
  TextEditingController messageController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    // Add static message examples
    messages.addAll([
      ChatMessage(
        content: "Hello! I'm available to pick you up. I'll be there in about",
        time: "02:15 PM",
        isFromDriver: true,
      ),
      ChatMessage(
        content: "Thankyou Sir" * 10,
        time: "02:20 PM",
        isFromDriver: false,
      ),
      ChatMessage(
        content:
            "I've arrived at Location. Look for a Red Car with the license plate XXXX.",
        time: "02:35 PM",
        isFromDriver: true,
      ),
      ChatMessage(
        content: "Great! I'll be there in a minute.",
        time: "02:36 PM",
        isFromDriver: false,
      ),
    ]);
  }

  ///------------------------------  create conversation method -------------------------///

  Future<void> createConversationRequest({required String userId}) async {
    try {
      isLoadingCreateConversation.value = true;
      final response = await ApiService().request(
        endpoint: "$conversationCreateEndPoint$userId",
        method: 'POST',
        body: {"user": userId},
      );
      isLoadingCreateConversation.value = false;
      if (response['success'] == true) {
        logger.d(response);

        showCustomSnackbar(title: 'Success', message: response['message']);
        NavigationController.to.selectedNavIndex.value = 3;
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
