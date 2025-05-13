import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_place/core/api-client/api_endpoints.dart';
import 'package:market_place/core/api-client/api_service.dart';
import 'package:market_place/core/utils/hive_boxes.dart' show Boxes;
import 'package:market_place/core/utils/variable.dart';
import 'package:market_place/presentations/home/controller/home_controller.dart';

import '../../../core/helper/helper_function.dart';
import '../../home/model/category_subcategory_model.dart';
import '../../home/model/product_model.dart';
import '../../navigation/controller/navigation_controller.dart';

class SellController extends GetxController {
  static SellController get to => Get.find();
  RxList<String> imgList = <String>[].obs;
  RxBool addProductInfo = false.obs;
  RxBool addLocationInfo = false.obs;
  final selectedCategory = Rx<CategoryModel?>(null);
  var selectedSubCategory = Rx<SubCategoryModel?>(null);
  var selectedWilaya = Rx<CategoryModel?>(null);
  var selectedCity = Rx<CityModel?>(null);
  var selectedCondition = Rx<String?>(null);
  RxBool isLoadingAddProduct = false.obs;
  RxBool isEditMode = false.obs;
  var product = Rx<ProductDetailsModel?>(null);

  @override
  void onInit() {
    reinitializeController();
    super.onInit();
  }

  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> priceController = TextEditingController().obs;
  Rx<TextEditingController> descriptionController = TextEditingController().obs;

  ///------------------------------ add product method -------------------------///

  Future<void> addProductRequest() async {
    try {
      isLoadingAddProduct.value = true;

      ApiService().setAuthToken(Boxes.getUserData().get(tokenKey).toString());
      Map<String, String> fields = {
        'name': nameController.value.text,
        'description': descriptionController.value.text,
        "price": priceController.value.text,
        "category": selectedCategory.value!.sId.toString(),
        "sub_category": selectedCategory.value!.sId.toString(),
        "division": selectedCategory.value!.sId.toString(),
        "condition": selectedCondition.value!.toUpperCase().toString(),
        "city": selectedCity.value!.sId.toString(),
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
        endpoint: productCreateEndPoint,
        method: 'POST',

        fields: fields,
        files: files,
      );
      isLoadingAddProduct.value = false;
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
      isLoadingAddProduct.value = false;
    }
  }

  reinitializeController() {
    nameController.value.text =
        isEditMode.value
            ? product.value!.name.toString()
            : kDebugMode
            ? "Test Product"
            : "";
    priceController.value.text =
        isEditMode.value
            ? product.value!.price.toString()
            : kDebugMode
            ? "100"
            : "";
    descriptionController.value.text =
        isEditMode.value
            ? product.value!.description.toString()
            : kDebugMode
            ? dummyDesc
            : "";
  }

  // Future<void> _setInitiaDropdown() async {
  //   await _setInitialCategory();
  //   await _setInitialSubCategory();
  //   await _setInitialLocation();
  // }
  //
  // Future<void> _setInitialCategory() async {
  //   if (isEditMode.value && product.value != null && product.value!.categoryId != null) {
  //     if (HomeController.to.catList.isEmpty) {
  //       await HomeController.to.getCategoryListRequest();
  //     }
  //
  //     selectedCategory.value = HomeController.to.catList.firstWhereOrNull(
  //             (element) => element.sId == product.value!.categoryId
  //     );
  //   } else {
  //     selectedCategory.value = null;
  //   }
  // }
  //
  // Future<void> _setInitialSubCategory() async {
  //   if (isEditMode.value &&
  //       product.value != null &&
  //       product.value!.subCategoryName != null &&
  //       selectedCategory.value != null) {
  //
  //     if (HomeController.to.subCatList.isEmpty) {
  //       await HomeController.to.getSubCategoryListRequest(
  //           catId: selectedCategory.value!.sId.toString()
  //       );
  //     }
  //
  //     selectedSubCategory.value = HomeController.to.subCatList.firstWhereOrNull(
  //             (element) => element.name == product.value!.subCategoryName
  //     );
  //   } else {
  //     selectedSubCategory.value = null;
  //   }
  // }
  // Future<void> _setInitialLocation() async {
  //   if (isEditMode.value && product.value != null) {
  //     await _setInitialWilaya();
  //     await _setInitialCity();
  //   } else {
  //     selectedWilaya.value = null;
  //     selectedCity.value = null;
  //   }
  // }
  //
  // Future<void> _setInitialWilaya() async {
  //   if (product.value!.wilayaId != null) {
  //     if (HomeController.to.divisionList.isEmpty) {
  //       await HomeController.to.getDivisionListRequest();
  //     }
  //
  //     selectedWilaya.value = HomeController.to.divisionList.firstWhereOrNull(
  //             (element) => element.sId == product.value!.wilayaId
  //     );
  //   }
  // }
  //
  // Future<void> _setInitialCity() async {
  //   if (product.value!. != null && selectedWilaya.value != null) {
  //     if (HomeController.to.cityList.isEmpty) {
  //       await HomeController.to.getCityListRequest(
  //           division: selectedWilaya.value!.sId.toString()
  //       );
  //     }
  //
  //     selectedCity.value = HomeController.to.cityList.firstWhereOrNull(
  //             (element) => element.sId == product.value!.cityId
  //     );
  //   }
  // }
}
