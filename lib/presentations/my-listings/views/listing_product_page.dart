import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_place/core/components/custom_appbar.dart';
import 'package:market_place/core/constants/padding_constant.dart';
import 'package:market_place/presentations/home/widgets/product_card_item_widget.dart';

class ListingProductPage extends StatelessWidget {
  static const String routeName ="/listing-product";
   ListingProductPage({super.key});
final arg = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomDefaultAppbar(title: arg.toString(),),
      body: SingleChildScrollView(

        child: Padding(
          padding: padding12,
          child: Column(
            children: [
              // ProductGridWidget(fromSeller: true,),
            ],
          ),
        ),
      ),
    );
  }
}
