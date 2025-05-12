import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_place/presentations/profile/controllers/account_information_controller.dart';

import '../../../core/api-client/api_endpoints.dart';
import '../../../core/api-client/api_service.dart';
import '../../../core/helper/helper_function.dart';
import '../../../core/utils/enum.dart';
import '../../../core/utils/hive_boxes.dart';
import '../../../core/utils/variable.dart';
import '../../home/model/product_model.dart';

class ListingsController extends GetxController {
  static ListingsController get to => Get.find();
  // @override
  // void onInit() {
  //   getProductListRequest();
  //   super.onInit();
  // }
  RxBool isLoadingProduct = false.obs;
  RxBool isLoadingPage = false.obs;
  Rx<Status> productStats = Status.pending.obs;

  RxList<ProductModel> productList = <ProductModel>[].obs;

  ///=======================search controller============================///

  Rx<TextEditingController> searchController = TextEditingController().obs;

  ///====================product pagination variable========================///

  final RxInt currentProductPage = 1.obs;
  final RxInt itemsProductPerPage = 10.obs;
  final RxInt totalProductPages = 5.obs;
  final RxBool isProductLoadingMore = false.obs;

  ///------------------------------ get product list method -------------------------///

  Future<void> getProductListRequest({bool loadMore = false}) async {
    try {
      // Don't load more if we've reached the last page
      if (loadMore && currentProductPage.value >= totalProductPages.value) {
        return;
      }

      if (loadMore) {
        isProductLoadingMore.value = true;
        currentProductPage.value++;
        // Don't increment page here - we'll do it after successful response
      } else {
        isLoadingProduct.value = true;
        currentProductPage.value = 1;
      }

      ApiService().setAuthToken(Boxes.getUserData().get(tokenKey).toString());
      final response = await ApiService().request(
        endpoint: productGetAllEndPoint,
        method: 'GET',
        // useAuth: false,
        queryParams: {
          'page': currentProductPage.value.toString(),
          'limit': itemsProductPerPage.value.toString(),
          'search': searchController.value.text,
          'order': 'desc',
          'status': productStats.value.name.toUpperCase(),          'user':
              AccountInformationController.to.userModel.value.sId.toString(),
        },
      );

      isLoadingProduct.value = false;
      isProductLoadingMore.value = false;

      if (response['success'] == true) {
        if (response['pagination'] != null) {
          currentProductPage.value = response['pagination']['currentPage'] ?? 1;
          totalProductPages.value =
              response['pagination']['totalPages'] ?? 1; // Add this line
          itemsProductPerPage.value =
              response['pagination']['itemsPerPage'] ?? 10;
        }

        final newProducts =
            (response['data'] as List)
                .map((e) => ProductModel.fromJson(e))
                .toList();

        if (loadMore) {
          // Only increment page after successful load

          productList.addAll(newProducts);
        } else {
          productList.value = newProducts;
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
      isLoadingProduct.value = false;
      isProductLoadingMore.value = false;
    }
  }
}
