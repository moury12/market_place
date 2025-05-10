import 'package:get/get.dart';

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
}