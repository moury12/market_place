import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_place/presentations/home/model/category_subcategory_model.dart';

import '../../../core/api-client/api_endpoints.dart';
import '../../../core/api-client/api_service.dart';
import '../../../core/helper/helper_function.dart';
import '../../../core/utils/hive_boxes.dart';
import '../../../core/utils/variable.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  RxBool showProducts = false.obs;
  final selectedCategory = Rx<CategoryModel?>(null);
  var selectedSubCategory = Rx<SubCategoryModel?>(null);
  var selectedWilaya = Rx<CategoryModel?>(null);
  var selectedCity = Rx<CityModel?>(null);
  var selectedCondition = Rx<String?>(null);
  var selectedSortBy = Rx<String?>(null);
  Rx<RangeValues> rangeValues = RangeValues(0, 500).obs;
  RxList<CategoryModel> catList = <CategoryModel>[].obs;
  RxList<CategoryModel> divisionList = <CategoryModel>[].obs;
  RxList<CityModel> cityList = <CityModel>[].obs;
  RxList<SubCategoryModel> subCatList = <SubCategoryModel>[].obs;
  TextEditingController searchCatField = TextEditingController();
  RxBool isLoadingCategory = false.obs;
  RxBool isLoadingDivision = false.obs;
  RxBool isLoadingCity = false.obs;
  RxBool isLoadingSubCategory = false.obs;
  @override
  void onInit() {
    getCategoryListRequest();
    getDivisionListRequest();
    super.onInit();
  }

  ///====================category pagination variable========================///

  final RxInt currentPage = 1.obs;
  final RxInt itemsPerPage = 100.obs;
  final RxInt totalCategoryPages = 5.obs;
  final RxBool isLoadingMore = false.obs;

  ///------------------------------ get category list method -------------------------///

  Future<void> getCategoryListRequest({bool loadMore = false}) async {
    try {
      if (loadMore && currentPage.value >= totalCategoryPages.value) {
        return;
      }

      if (loadMore) {
        currentPage.value++;
        isLoadingMore.value = true;
      } else {
        isLoadingCategory.value = true;
        currentPage.value = 1;
      }
      ApiService().setAuthToken(Boxes.getUserData().get(tokenKey).toString());

      final response = await ApiService().request(
        endpoint: catGetAllEndPoint,
        method: 'GET',
        queryParams: {
          'page': currentPage.value.toString(),
          'limit': itemsPerPage.value.toString(),
          'sort': 'updatedAt',
          'order': 'desc',
          'search': searchCatField.text,
        },
      );

      isLoadingCategory.value = false;
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
                .map((e) => CategoryModel.fromJson(e))
                .toList();

        if (loadMore) {
          catList.addAll(newCategories); // Append for load more
        } else {
          catList.value = newCategories; // Replace for refresh
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
      isLoadingCategory.value = false;
    }
  }

  ///------------------------------ get sub category list method -------------------------///

  Future<void> getSubCategoryListRequest({required String catId}) async {
    try {
      isLoadingSubCategory.value = true;
      ApiService().setAuthToken(Boxes.getUserData().get(tokenKey).toString());

      final response = await ApiService().request(
        endpoint: subCatGetEndPoint,
        queryParams: {'category_id': catId},
        method: 'GET',
      );
      isLoadingSubCategory.value = false;
      if (response['success'] == true) {
        logger.d(response);
        subCatList.value =
            (response['data'] as List)
                .map((e) => SubCategoryModel.fromJson(e))
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
      isLoadingSubCategory.value = false;
    }
  }

  ///------------------------------ get division list method -------------------------///

  Future<void> getDivisionListRequest() async {
    try {
      isLoadingDivision.value = true;
      ApiService().setAuthToken(Boxes.getUserData().get(tokenKey).toString());

      final response = await ApiService().request(
        endpoint: divisionGetEndPoint,

        method: 'GET',
      );
      isLoadingDivision.value = false;
      if (response['success'] == true) {
        logger.d(response);
        divisionList.value =
            (response['data'] as List)
                .map((e) => CategoryModel.fromJson(e))
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
      isLoadingDivision.value = false;
    }
  }

  ///------------------------------ get city list method -------------------------///

  Future<void> getCityListRequest({required String division}) async {
    try {
      isLoadingCity.value = true;
      ApiService().setAuthToken(Boxes.getUserData().get(tokenKey).toString());

      final response = await ApiService().request(
        endpoint: cityGetEndPoint,
        queryParams: {'division': division},
        method: 'GET',
      );
      isLoadingCity.value = false;
      if (response['success'] == true) {
        logger.d(response);
        cityList.value =
            (response['data'] as List)
                .map((e) => CityModel.fromJson(e))
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
      isLoadingCity.value = false;
    }
  }
}
