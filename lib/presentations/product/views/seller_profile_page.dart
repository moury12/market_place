import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:market_place/core/components/custom_appbar.dart';
import 'package:market_place/core/constants/app_static_strings.dart';
import 'package:market_place/core/constants/padding_constant.dart';
import 'package:market_place/presentations/home/widgets/product_card_item_widget.dart';
import 'package:market_place/presentations/home/widgets/view_all_row_widget.dart';
import 'package:market_place/presentations/product/widgets/seller_profile_widgets.dart';

import '../../profile/widgets/profile_info_widget.dart';

class SellerProfilePage extends StatelessWidget {
  static const String routeName = "/seller-profile";
  const SellerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomDefaultAppbar(title: AppStaticStrings.sellerProfile.tr,),
      body: SingleChildScrollView(
        child: Padding(
          padding: padding12.copyWith(top: 0),
          child: Column(spacing: 8.h,
            children: [
              ProfileInfoDetailsWidget(isEdit: false,),
              CallAndChatButtons(),
              ViewAllRow(title:AppStaticStrings.moreFromThisSeller.tr, onPressed: () {

              },),
              ProductGridWidget()
            ],
          ),
        ),
      ),
    );
  }
}
