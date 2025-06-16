import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_place/core/components/custom_appbar.dart';
import 'package:market_place/core/constants/app_static_strings.dart';
import 'package:market_place/core/constants/padding_constant.dart';
import 'package:market_place/core/constants/pagination_loading_widget.dart';
import 'package:market_place/presentations/home/widgets/product_card_item_widget.dart';
import 'package:market_place/presentations/home/widgets/view_all_row_widget.dart';
import 'package:market_place/presentations/product/widgets/seller_profile_widgets.dart';

import '../../../core/api-client/api_service.dart';
import '../../profile/widgets/profile_info_widget.dart';
import '../controller/product_controller.dart';

class SellerProfilePage extends StatefulWidget {
  static const String routeName = "/seller-profile";

  const SellerProfilePage({super.key});

  @override
  State<SellerProfilePage> createState() => _SellerProfilePageState();
}

class _SellerProfilePageState extends State<SellerProfilePage> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        ProductController.to.getProductListRequest(
          loadMore: true,
          userId: ProductController.to.productModel.value.userId.toString(),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomDefaultAppbar(title: AppStaticStrings.sellerProfile.tr),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: padding12.copyWith(top: 0),
          child: Obx(() {
            final product = ProductController.to.productModel.value;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8.h,
              children: [
                ProfileInfoDetailsWidget(
                  isEdit: false,
                  email: product.userEmail,
                  img: "${ApiService().baseUrl}/${product.userImg}",
                  name: product.userName,
                  phone: product.userPhone,
                ),
                CallAndChatButtons(
                  number: product.userPhone.toString(),
                  userID: product.userId.toString(),
                ),
                ViewAllRow(
                  title: AppStaticStrings.moreFromThisSeller.tr,
                  onPressed: () {},
                ),
                ProductGridWidget(

                  productList: ProductController.to.productList,
                  isLoading: ProductController.to.isLoadingProduct.value,
                ),
          ProductController.to.isProductLoadingMore.value
                    ? PaginationLoadingWidget()
                    : SizedBox.shrink(),
              ],
            );
          }),
        ),
      ),
    );
  }
}
