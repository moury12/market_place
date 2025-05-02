import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_place/core/components/custom_textfield.dart';
import 'package:market_place/core/constants/app_static_strings.dart';
import 'package:market_place/core/constants/padding_constant.dart';

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
            CustomTextField(
              prefixIcon: Icon(CupertinoIcons.search, color: Colors.black),
            ),
            ViewAllRow(
              title: AppStaticStrings.productCategories,
              onPressed: () {},
            ),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              spacing: 8.w,
              runSpacing: 8.w,

              children: List.generate(8, (index) => CategoryCardItemWidget()),
            ),
            ViewAllRow(title: AppStaticStrings.recentlyAdded, onPressed: () {}),
            GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 10,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                crossAxisSpacing: 8.w,
                mainAxisSpacing: 12.w,
                mainAxisExtent: 265.w,
                // childAspectRatio: .5,
                maxCrossAxisExtent: 210.w,
              ),
              itemBuilder:
                  (context, index) => ProductCardItemWidget(),
            ),
          ],
        ),
      ),
    );
  }
}


