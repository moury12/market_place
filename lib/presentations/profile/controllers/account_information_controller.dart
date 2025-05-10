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
import '../../home/model/product_model.dart';

class AccountInformationController extends GetxController{
  static AccountInformationController get to => Get.find();
RxString profileImgPath ="".obs;
  var tabContent = <Widget>[].obs;
  RxBool isLoadingProfile = false.obs;
  RxBool isLoadingUpdateProfile = false.obs;
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();
  RxBool isLoadingChangePass = false.obs;
  RxBool isLoadingPolicy = false.obs;
  RxList<ProductModel> favProductList = <ProductModel>[].obs;

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

  ///====================product pagination variable========================///

  final RxInt currentFavProductPage = 1.obs;
  final RxInt itemsFavProductPerPage = 10.obs;
  final RxInt totalFavProductPages = 5.obs;
  final RxBool isFavProductLoadingMore = false.obs;
  RxBool isLoadingFavProduct = false.obs;

  @override
  void onInit() {
    getUserProfileRequest();
    getFavProductListRequest();
    reinitializeProfileControllers();
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
        Boxes.getUserData().put(subscribed, userModel.value.isSubscribed);
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
        profileImgPath.value="";
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

  ///------------------------------ get product list method -------------------------///

  Future<void> getFavProductListRequest({bool loadMore = false}) async {
    try {
      // Don't load more if we've reached the last page
      if (loadMore && currentFavProductPage.value >= totalFavProductPages.value) {
        return;
      }

      if (loadMore) {
        isFavProductLoadingMore.value = true;
        currentFavProductPage.value++;
        // Don't increment page here - we'll do it after successful response
      } else {
        isLoadingFavProduct.value = true;
        currentFavProductPage.value = 1;
      }

      ApiService().setAuthToken(Boxes.getUserData().get(tokenKey).toString());
      final response = await ApiService().request(
        endpoint: favoriteProductEndPoint,
        method: 'GET',

        queryParams:  {
          'page': currentFavProductPage.value.toString(),
          'limit': itemsFavProductPerPage.value.toString(),


        },
      );

      isLoadingFavProduct.value = false;
      isFavProductLoadingMore.value = false;

      if (response['success'] == true) {
        if (response['pagination'] != null) {
          currentFavProductPage.value = response['pagination']['currentPage'] ?? 1;
          totalFavProductPages.value =
              response['pagination']['totalPages'] ?? 1; // Add this line
          itemsFavProductPerPage.value =
              response['pagination']['itemsPerPage'] ?? 10;
        }

        final newProducts =
        (response['data'] as List)
            .map((e) => ProductModel.fromJson(e))
            .toList();

        if (loadMore) {
          // Only increment page after successful load

          favProductList.addAll(newProducts);
        } else {
          favProductList.value = newProducts;
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
      isLoadingFavProduct.value = false;
      isFavProductLoadingMore.value = false;
    }
  }
  ///------------------------------ change pass method -------------------------///

  Future<void> changePassRequest() async {
    try {
      isLoadingChangePass.value = true;
      final response = await ApiService().request(endpoint: changePassEndPoint, method: 'POST', body: {
        "confirm_password": confirmPasswordController.text,
        "password": newPasswordController.text,
        "old_password": currentPasswordController.text
      });
      isLoadingChangePass.value = false;
      if (response['success'] == true) {
        showCustomSnackbar(
          title: 'Success',
          message: response['message'],
        );
        clearControllers();

        logger.d(response);
        // Get.back();
      } else {
        logger.e(response);
        showCustomSnackbar(title: 'Failed', message: response['message'], type: SnackBarType.failed);
      }
    } catch (e) {
      isLoadingChangePass.value = false;

      logger.e(e.toString());
    }
  }
  reinitializeProfileControllers() {
    nameController.value.text = userModel.value.name ?? 'n/a';

    ///=====================add dynmic email ====================///
    emailController.value.text = userModel.value.email ?? 'n/a';

    ///=====================add dynmic contactNumber ====================///
    contactNumberController.value.text = userModel.value.phone ?? 'n/a';


  }

  clearControllers() {
    confirmPasswordController.clear();
    newPasswordController.clear();
    currentPasswordController.clear();
  }
}