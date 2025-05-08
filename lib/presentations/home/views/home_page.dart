import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_place/core/components/custom_textfield.dart';
import 'package:market_place/core/constants/app_static_strings.dart';
import 'package:market_place/core/constants/padding_constant.dart';
import 'package:market_place/presentations/home/controller/home_controller.dart';
import 'package:market_place/presentations/home/loading/category_circle_loading.dart';
import 'package:market_place/presentations/home/views/category_page.dart';
import 'package:market_place/presentations/home/views/search_page.dart';

import '../widgets/category_card_item_widget.dart';
import '../widgets/product_card_item_widget.dart';
import '../widgets/view_all_row_widget.dart';

class HomePage extends StatelessWidget {
  static const String routeName = "/home";
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: padding12,
        child: Column(
          spacing: 8.h,
          children: [
            GestureDetector(
              onTap: () {
                Get.toNamed(SearchPage.routeName);
              },
              child: CustomTextField(
                isEnable: false,
                prefixIcon: Icon(CupertinoIcons.search, color: Colors.black),
              ),
            ),
            ViewAllRow(
              title: AppStaticStrings.productCategories.tr,
              onPressed: () {
                Get.toNamed(CategoryPage.routeName);
              },
            ),
            Obx(() {
              return HomeController.to.isLoadingCategory.value

                  ? CategoryCircleLoading()
                  : Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    spacing: 8.w,
                    runSpacing: 8.w,

                    children: List.generate(
                      HomeController.to.catList.length > 8
                          ? 8
                          : HomeController.to.catList.length,
                      (index) => CategoryCardItemWidget(
                        categoryModel: HomeController.to.catList[index],
                      ),
                    ),
                  );
            }),
            ViewAllRow(
              title: AppStaticStrings.recentlyAdded.tr,
              onPressed: () {},
            ),
            ProductGridWidget(),
          ],
        ),
      ),
    );
  }
}
