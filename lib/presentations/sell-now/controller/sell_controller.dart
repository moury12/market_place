import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_place/core/api-client/api_endpoints.dart';
import 'package:market_place/core/api-client/api_service.dart';
import 'package:market_place/core/utils/hive_boxes.dart' show Boxes;
import 'package:market_place/core/utils/variable.dart';
import 'package:market_place/presentations/navigation/views/navigation_page.dart';

import '../../../core/helper/helper_function.dart';
import '../../home/controller/home_controller.dart';
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
  RxList<String> editImgList = <String>[].obs;
  RxList<String> removeImgList = <String>[].obs;
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

  Future<void> reinitializeController() async {
    nameController.value.text =
    isEditMode.value && product.value != null
        ? product.value!.name.toString()
        : kDebugMode
        ? "Test Product"
        : "";
    priceController.value.text =
    isEditMode.value && product.value != null
        ? product.value!.price.toString()
        : kDebugMode
        ? "100"
        : "";
    descriptionController.value.text =
    isEditMode.value && product.value != null
        ? product.value!.description.toString()
        : kDebugMode
        ? dummyDesc
        : "";  selectedCondition.value =
    isEditMode.value && product.value != null
        ? product.value!.condition.toString()
        : null;

    final productCategory = product.value?.categories;

      if (productCategory != null) {
        selectedCategory.value =
        isEditMode.value && product.value != null
            ? product.value!.categories
            : null;
        await HomeController.to.getSubCategoryListRequest(catId: productCategory.sId!);
        HomeController.to.subCatList.refresh();
        selectedSubCategory.value =
        isEditMode.value && product.value != null
            ? product.value!.subCategories
            : null;

      }




    final productDivision = product.value?.divisions;
    if (productDivision != null) {
      selectedWilaya.value =
      isEditMode.value && product.value != null
          ? product.value!.divisions
          : null;
      await HomeController.to.getCityListRequest(division:productDivision.sId.toString());
      HomeController.to.cityList.refresh();
      selectedCity.value =
      isEditMode.value && product.value != null
          ? product.value!.cities
          : null;

    }

    // Images
    if (isEditMode.value && product.value != null) {
      editImgList.assignAll(
        product.value!.img!
            .map((e) => "${ApiService().baseUrl}/${e.toString()}")
            .toList(),
      );
    }
  }

  editProduct({required ProductDetailsModel productDetails}) async{
    isEditMode.value = true;
    product.value = productDetails;
  await  reinitializeController();
    NavigationController.to.selectedNavIndex.value = 2;
    Get.toNamed(NavigationPage.routeName);
  }
}
