import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_place/core/api-client/api_endpoints.dart';
import 'package:market_place/core/api-client/api_service.dart';
import 'package:market_place/core/utils/hive_boxes.dart' show Boxes;
import 'package:market_place/core/utils/variable.dart';

import '../../../core/helper/helper_function.dart';
import '../../home/model/category_subcategory_model.dart';

class SellController extends GetxController{
  static SellController get to => Get.find();
  RxList<String> imgList =<String>[].obs;
  RxBool  addProductInfo = false.obs;
  RxBool  addLocationInfo = false.obs;
  final selectedCategory = Rx<CategoryModel?>(null);
  var selectedSubCategory = Rx<SubCategoryModel?>(null);
  var selectedWilaya = Rx<CategoryModel?>(null);
  var selectedCity = Rx<CityModel?>(null);
  var selectedCondition= Rx<String?>(null);
  RxBool isLoadingUpdateProfile = false.obs;
  Rx<TextEditingController> nameController =
      TextEditingController().obs; Rx<TextEditingController> priceController =
      TextEditingController().obs;Rx<TextEditingController> descriptionController =
      TextEditingController().obs;

  ///------------------------------ add product method -------------------------///

  Future<void> updateProfileRequest() async {
    try {
      isLoadingUpdateProfile.value = true;
      ApiService().setAuthToken(Boxes.getUserData().get(tokenKey).toString());
      Map<String, String> fields = {
        'name': nameController.value.text,
        'description': descriptionController.value.text,
        "price": priceController.value.text,
        "category": selectedCategory.value!.sId.toString(),
        "sub_category": selectedCategory.value!.sId.toString(),
        "division": selectedCategory.value!.sId.toString(),
      };
      Map<String, dynamic> files = {};



      // Only add documents if there are any in the list
      if (imgList.isNotEmpty) {
        // Convert non-empty paths to File objects
        List<File> docFiles = [];
        for (String path in imgList) {
          if (path.isNotEmpty) {
            docFiles.add(File(path));
          }
        }

        // Only add to files map if we have valid files
        if (docFiles.isNotEmpty) {
          files['img'] = docFiles;
        }
      }
      final response = await ApiService()
          .multipartRequest(endpoint: productCreateEndPoint, method: 'POST', fields: fields, files: files);
      isLoadingUpdateProfile.value = false;
      if (response['success'] == true) {
        logger.d(response);
        showCustomSnackbar(
            title: 'Success',
            message: response['message'],
        );
        // Get.offAllNamed(NavigationPage.routeName);
        // getUserProfileRequest();
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
}