import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:market_place/presentations/profile/model/profile_model.dart';

import '../../../core/api-client/api_endpoints.dart';
import '../../../core/api-client/api_service.dart';
import '../../../core/constants/app_static_strings.dart';
import '../../../core/helper/helper_function.dart';
import '../../../core/utils/hive_boxes.dart';
import '../../../core/utils/variable.dart';

class AccountInformationController extends GetxController{
  static AccountInformationController get to => Get.find();
RxString profileImgPath ="".obs;
  var tabContent = <Widget>[].obs;
  RxBool isLoadingProfile = false.obs;
  RxBool isLoadingUpdateProfile = false.obs;
  ///=====================add dynmic name ====================///
  Rx<TextEditingController> nameController =
      TextEditingController().obs;

  ///=====================add dynmic email ====================///
  Rx<TextEditingController> emailController =
      TextEditingController()
          .obs;

  ///=====================add dynmic contactNumber ====================///
  Rx<TextEditingController> contactNumberController =
      TextEditingController().obs;
  Rx<ProfileModel> userModel = ProfileModel().obs;
  @override
  void onInit() {
    getUserProfileRequest();
    super.onInit();
  }
  ///------------------------------ get User profile method -------------------------///

  Future<void> getUserProfileRequest() async {
    try {
      isLoadingProfile.value = true;
      ApiService().setAuthToken(Boxes.getUserData().get(tokenKey).toString());

      final response = await ApiService()
          .request(endpoint: getProfileEndPoint, method: 'GET');
      isLoadingProfile.value = false;
      if (response['success'] == true) {
        logger.d(response);
        userModel.value = ProfileModel.fromJson(response['data']);
        reinitializeProfileControllers();
      } else if (response['message'] == AppStaticStrings.noInternet) {
        showCustomSnackbar(
          title: 'Failed',
          message: response['message'],
          type: SnackBarType.failed,
          noInternet: true,
          retryTap: () {
            getUserProfileRequest();
          },
        );
      } else {
        logger.e(response);
        showCustomSnackbar(
            title: 'Failed',
            message: response['message'],
            type: SnackBarType.failed);
      }
    } catch (e) {
      logger.e(e.toString());
      isLoadingProfile.value = false;
    }
  }
  ///------------------------------ update profile method -------------------------///

  Future<void> updateProfileRequest() async {
    try {
      isLoadingUpdateProfile.value = true;
      ApiService().setAuthToken(Boxes.getUserData().get(tokenKey).toString());
      Map<String, String> fields = {
        'name': nameController.value.text,
        'phone': contactNumberController.value.text,

      };
      Map<String, dynamic> files = {};
      if (profileImgPath.value.isNotEmpty) {
        files['img'] = File(profileImgPath.value);
      }

      final response = await ApiService()
          .multipartRequest(endpoint: updateProfileEndPoint, method: 'PATCH', fields: fields, files: files);
      isLoadingUpdateProfile.value = false;
      if (response['success'] == true) {
        logger.d(response);
        Get.back();
        // Get.offAllNamed(NavigationPage.routeName);
        getUserProfileRequest();
      } else {
        logger.e(response);
        showCustomSnackbar(
            title: 'Failed',
            message: response['message'],
            type: SnackBarType.failed);
      }
    } catch (e) {
      logger.e(e.toString());
      isLoadingUpdateProfile.value = false;
    }
  }
  reinitializeProfileControllers() {
    nameController.value.text = userModel.value.name ?? 'n/a';

    ///=====================add dynmic email ====================///
    emailController.value.text = userModel.value.email ?? 'n/a';

    ///=====================add dynmic contactNumber ====================///
    contactNumberController.value.text = userModel.value.phone ?? 'n/a';


  }
}