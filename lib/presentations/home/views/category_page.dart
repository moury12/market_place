import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_place/core/components/custom_appbar.dart';
import 'package:market_place/core/constants/app_static_strings.dart';
import 'package:market_place/core/constants/padding_constant.dart';

import '../widgets/category_card_item_widget.dart';


class CategoryPage extends StatelessWidget {
  static const String routeName = "/cat_list";
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomDefaultAppbar(title: AppStaticStrings.productCategories.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: padding12,
          child: Wrap(
            spacing: 8.w,
            runSpacing: 8.w,
            // alignment: WrapAlignment.center,

            // crossAxisAlignment: WrapCrossAlignment.center,
            // alignment: WrapAlignment.spaceBetween,
            // runAlignment: WrapAlignment.spaceBetween,
            children: List.generate(
              4,
              (index) => CategoryDetailsCardItemWidget(),
            ),
          ),
        ),
      ),
    );
  }
}

