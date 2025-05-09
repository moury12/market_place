import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:market_place/core/api-client/api_service.dart';
import 'package:market_place/core/components/custom_appbar.dart';
import 'package:market_place/core/components/custom_button.dart';
import 'package:market_place/core/components/custom_button_tap.dart';
import 'package:market_place/core/components/custom_network_image.dart';
import 'package:market_place/core/constants/app_static_strings.dart';
import 'package:market_place/core/constants/color_constants.dart';
import 'package:market_place/core/constants/custom_space.dart';
import 'package:market_place/core/constants/custom_text.dart';
import 'package:market_place/core/constants/fontsize_constant.dart';
import 'package:market_place/core/constants/image_constants.dart';
import 'package:market_place/core/constants/padding_constant.dart';
import 'package:market_place/core/constants/text_style_constant.dart';
import 'package:market_place/core/utils/variable.dart';
import 'package:market_place/presentations/home/widgets/view_all_row_widget.dart';
import 'package:market_place/presentations/product/controller/product_controller.dart';
import 'package:market_place/presentations/product/views/seller_profile_page.dart';

import '../../../core/components/custom_loading_widget.dart';
import '../../home/widgets/product_card_item_widget.dart';
import '../widgets/manage_option_widget.dart';
import '../widgets/product_details_card_widget.dart';
import '../widgets/seller_profile_widgets.dart';

class ProductDetailsPage extends StatelessWidget {
  static const String routeName = "/product-details";
  ProductDetailsPage({super.key});
  final fromSeller = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomDefaultAppbar(
        title: fromSeller ?  AppStaticStrings.manageProduct.tr: "",
        action: [
          fromSeller
              ? SizedBox.shrink()
              : ButtonTapWidget(
            onTap: () async{
             bool isFav= await ProductController.to.favProductRequest(parentId: ProductController.to.productModel.value.sId);
              if(isFav){
                ProductController.to.productModel.update((val) {
                  // if (val != null) {
                  //   val. = !(val. ?? false);
                  //   int likes = int.tryParse(val.numOfLikes ?? "0") ?? 0;
                  //   likes = (val. ?? false) ? likes + 1 : likes - 1;
                  //   val.numOfLikes = likes.toString();
                  // }
                },);
              }
            },
                child: Padding(
                  padding: padding8,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset(backgroundCircleIcon),
                      SvgPicture.asset(favOutlineIcon),
                    ],
                  ),
                ),
              ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: padding12.copyWith(top: 0),
          child: Obx(

            () {
              final product = ProductController.to.productModel.value;
              return ProductController.to.isLoadingProductDetails.value?
              CustomLoadingWidget(
                height: ScreenUtil().screenHeight,
                size: 30.sp,
                width:ScreenUtil().screenWidth,
              ): Column(
                spacing: 4.h,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  CustomNetworkImage(

                    radius: 2.r,
                    imageUrl: "${ApiService().baseUrl}/${product.img?[ProductController.to.selectedImageIndex.value]
                    }",
                    height: 250.w,
                  ),
                  space8H,
                  product.img!=null?  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      spacing: 8.w,
                      children: List.generate(
                        product.img!.length,
                        (index) => ButtonTapWidget(
                          onTap: () {
                            ProductController.to.selectedImageIndex.value=index;
                          },
                          child: CustomNetworkImage(
                            radius: 2.r,
                            imageUrl:"${ApiService().baseUrl}/${product.img?[index]}",
                            height: 50.w,
                            width: 50.w,
                          ),
                        ),
                      ),
                    ),
                  ):SizedBox.shrink(),
                  space8H,
                  CustomText(
                    text:product.name?? "Product Name..",
                    style: poppinsSemiBold,
                    fontSize: getFontSizeDefault(),
                  ),
                  CustomText(
                    text: "UM  ${product.price}",
                    style: poppinsSemiBold,
                    fontSize: getFontSizeDefault(),
                  ),

                  fromSeller
                      ? SizedBox.shrink()
                      : Padding(
                        padding: padding8V,
                        child: Column(
                          spacing: 8.h,
                          children: [
                            CallAndChatButtons(number: product.userPhone??"013230443", userID: product.userId.toString(),),

                            ///----------------------- seller info ------------------------///
                            Row(
                              spacing: 8.h,
                              children: [
                                CustomNetworkImage(
                                  imageUrl: "${ApiService().baseUrl}/${product.userImg}",
                                  height: 40.w,
                                  width: 40.w,
                                  boxShape: BoxShape.circle,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    spacing: 4.h,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomText(text:product.userName?? "Seller Name"),
                                      CustomText(
                                        text:product.userEmail?? "Marvin@gmail.com",
                                        fontSize: getFontSizeSmall(),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: CustomButton(
                                    onTap: () {
                                      Get.toNamed(SellerProfilePage.routeName);
                                    },
                                    title: AppStaticStrings.viewProfile.tr,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                  CustomText(
                    text: AppStaticStrings.productDetails.tr,
                    style: poppinsSemiBold,
                    fontSize: getFontSizeDefault(),
                  ),
                  space8H,

                  ProductDetailsCardWidget(
                    title: AppStaticStrings.category.tr,
                    value: product.categoryName??"",
                  ),
                  ProductDetailsCardWidget(
                    title: AppStaticStrings.subCategory.tr,
                    value:  product.subCategoryName??"Jewelary",
                  ),
                  ProductDetailsCardWidget(
                    title:AppStaticStrings.condition.tr,
                    value: product.condition??"Jewelary",
                  ),
                  CustomText(text: AppStaticStrings.productDescription.tr),
                  space8H,
                  CustomText(text: product.description??"", fontSize: getFontSizeSmall()),
                  space8H,
                  fromSeller
                      ? Column(
                    spacing: 8.h,
                        children: [
                          ManageOptionWidget(
                            title: AppStaticStrings.editListingInfo.tr,
                            color: AppColors.kPrimaryColor,
                            icon: editIcon,
                            action: () {},
                          ),
                          ManageOptionWidget(
                            title: AppStaticStrings.markAsSold.tr,
                            color: AppColors.kPrimaryColor,
                            icon: markSoldIcon,
                            action: () {},
                          ),
                          ManageOptionWidget(
                            title: AppStaticStrings.archiveListings.tr,
                            color: AppColors.kYellowColor,
                            icon: archiveListingsIcon,
                            action: () {},
                          ),
                          ManageOptionWidget(
                            title: AppStaticStrings.deletePermanently.tr,
                            color: AppColors.kRedColor,
                            icon: deleteIcon,
                            action: () {},
                          ),
                        ],
                      )
                      : ViewAllRow(title: AppStaticStrings.relatedProduct.tr, onPressed: () {}),
                  fromSeller ? SizedBox.shrink() :
                  ProductGridWidget(productList: ProductController.to.relatedProductList,isLoading: ProductController.to.isLoadingProductDetails.value,),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}

