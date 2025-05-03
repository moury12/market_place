import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  static HomeController get to => Get.find();
  RxBool showProducts = false.obs;
  var selectedCategory= Rx<String?>(null);
  var selectedSubCategory= Rx<String?>(null);
  var selectedWilaya  = Rx<String?>(null);
  var selectedCity= Rx<String?>(null);
  var selectedCondition= Rx<String?>(null);
  var selectedSortBy= Rx<String?>(null);
  Rx<RangeValues> rangeValues =  RangeValues(0, 500).obs;
}