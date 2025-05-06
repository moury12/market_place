import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:market_place/core/components/custom_button_tap.dart';
import 'package:market_place/core/components/filter_drawer_widget.dart';
import 'package:market_place/core/constants/app_static_strings.dart';
import 'package:market_place/core/constants/color_constants.dart';
import 'package:market_place/core/constants/custom_text.dart';
import 'package:market_place/core/constants/text_style_constant.dart';
import 'package:market_place/presentations/home/controller/home_controller.dart';
import 'package:market_place/presentations/home/widgets/product_card_item_widget.dart';
import 'package:market_place/presentations/home/widgets/view_all_row_widget.dart';

import '../../../core/components/custom_textfield.dart';
import '../../../core/constants/image_constants.dart';
import '../../../core/constants/padding_constant.dart';

class SearchPage extends StatelessWidget {
  static const String routeName = "/search";
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: FilterDrawerWidget(),
      body: Column(
        children: [
          Padding(
            padding: padding12.copyWith(
              top: MediaQuery.of(context).viewPadding.top,
              bottom: 0,
            ),
            child: Row(
              spacing: 8.w,
              children: [
                ButtonTapWidget(
                  shape: CircleBorder(),

                  onTap: () {
                    Get.back();
                  },
                  child: SvgPicture.asset(backIcon),
                ),
                Expanded(
                  child: CustomTextField(
                    prefixIcon: Icon(
                      CupertinoIcons.search,
                      color: Colors.black,
                    ),
                  ),
                ),
                Builder(
                  builder: (context) {
                    return ButtonTapWidget(


                      onTap: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                      child: SvgPicture.asset(filterIcon),
                    );
                  }
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: padding12.copyWith(top: 6),
                child: Obx(
                  () {
                    return Column(
                      spacing: 8.h,
                      children: [
                        !HomeController.to.showProducts.value
                            ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 6.h,
                              children: [
                                ViewAllRow(
                                  title: AppStaticStrings.searchHistory.tr,
                                  onPressed: () {},
                                  buttonText: AppStaticStrings.clearAll.tr,
                                ),
                                Wrap(
                                  spacing: 8.w,
                                  runSpacing: 8.w,
                                  // alignment: WrapAlignment.spaceBetween,
                                  children: List.generate(7, (index) {
                                    return ButtonTapWidget(
                                      onTap: () {
                                        HomeController.to.showProducts.value = true;
                                      },
                                      child: GreenAccentContainerWidget(
                                        radius: 4.r,
                                        child: Padding(
                                          padding: padding4,
                                          child: CustomText(
                                            text: "Women's",
                                            style: poppinsRegular,
                                            fontSize: 10.sp,
                                            color: AppColors.kPrimaryColor,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            )
                            : SizedBox.shrink(),
                        HomeController.to.showProducts.value
                            ? ProductGridWidget()
                            : SizedBox.shrink(),
                      ],
                    );
                  }
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
