import 'package:get/get.dart';

import '../../../core/api-client/api_endpoints.dart';
import '../../../core/api-client/api_service.dart';
import '../../../core/helper/helper_function.dart';
import '../../../core/utils/variable.dart';
import '../../home/model/product_model.dart';

class ProductController extends GetxController {
  static ProductController get to => Get.find();
  RxBool isLoadingProductDetails = false.obs;
  Rx<ProductDetailsModel> productModel = ProductDetailsModel().obs;
  RxList<ProductModel> relatedProductList = <ProductModel>[].obs;
  RxInt selectedImageIndex = 0.obs;

  ///------------------------------ get Product Details method -------------------------///

  Future<void> getProductDetailsRequest({required String productID}) async {
    try {
      isLoadingProductDetails.value = true;

      final response = await ApiService().request(
        endpoint: '$productDetailsEndPoint$productID',
        method: 'GET',
      );
      if (response['success'] == true) {
        logger.d(response);
        productModel.value = ProductDetailsModel.fromJson(response['data']);
        relatedProductList.value =
            (response['related_product'] as List)
                .map((e) => ProductModel.fromJson(e))
                .toList();
        // initializeBannerImages();

        isLoadingProductDetails.value = false;
      } else {
        logger.e(response);
        showCustomSnackbar(
          title: 'Failed',
          message: response['message'],
          type: SnackBarType.failed,
        );
        isLoadingProductDetails.value = false;
      }
    } catch (e) {
      logger.e(e.toString());
      isLoadingProductDetails.value = false;
    }
  }

  ///---------------------------fav method----------------------------///

  Future<bool> favProductRequest({String? parentId}) async {
    final response = await ApiService().request(
      method: 'POST',

      endpoint: "$productFavEndPoint$parentId",
    );

    logger.d(response);
    if (response['success'] == true) {
      showCustomSnackbar(title: "Success", message: response['message']);
      return true;
    } else {
      showCustomSnackbar(
        title: 'Failed',
        message: response['message'],
        type: SnackBarType.failed,
      );
      return false;
    }
  }
}
