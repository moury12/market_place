import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_place/core/components/custom_appbar.dart';
import 'package:market_place/core/constants/app_static_strings.dart';
import 'package:market_place/core/constants/custom_space.dart';
import 'package:market_place/core/constants/padding_constant.dart';
import 'package:market_place/presentations/home/controller/home_controller.dart';
import 'package:market_place/presentations/home/loading/category_grid_loading.dart';

import '../../../core/components/custom_refresh_indicator.dart';
import '../../../core/components/custom_textfield.dart';
import '../../../core/constants/pagination_loading_widget.dart';
import '../widgets/category_card_item_widget.dart';

class CategoryPage extends StatefulWidget {
  static const String routeName = "/cat_list";
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(
          () {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          HomeController.to.getCategoryListRequest(loadMore: true);
        }
      },
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomDefaultAppbar(title: AppStaticStrings.productCategories.tr),
      body: CustomRefreshIndicatorWidget(
        onRefresh: () {
          return HomeController.to.getCategoryListRequest();
        },
        child: SingleChildScrollView(
          controller: scrollController,
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: padding12.copyWith(top: 0),
            child: Column(
              children: [
                // CustomTextField(
                //   textEditingController: HomeController.to.searchCatField,
                //   prefixIcon: Icon(CupertinoIcons.search, color: Colors.black),
                //   onChanged: (p0) {
                //     HomeController.to.getCategoryListRequest();
                //   },
                // ),
                // space8H,
                Obx(
               () {
                    return HomeController.to.isLoadingCategory.value?
                        CategoryGridLoading(): Wrap(
                      spacing: 8.w,
                      runSpacing: 8.w,

                      children: List.generate(
                        HomeController.to.catList.length,
                        (index) => CategoryDetailsCardItemWidget(
                          categoryModel: HomeController.to.catList[index],
                        ),
                      ),
                    );
                  }
                ),
                Obx(
                      () {
                    return HomeController.to.isLoadingMore.value
                        ? PaginationLoadingWidget()
                        : SizedBox.shrink();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
