import 'package:get/get.dart';

class SellController extends GetxController{
  static SellController get to => Get.find();
  RxList<String> imgList =<String>[].obs;
  RxBool  addProductInfo = false.obs;
  var selectedCategory= Rx<String?>(null);
  var selectedSubCategory= Rx<String?>(null);
  var selectedWilaya  = Rx<String?>(null);
  var selectedCity= Rx<String?>(null);
  var selectedCondition= Rx<String?>(null);
}