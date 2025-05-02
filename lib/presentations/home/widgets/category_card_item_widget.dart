import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_place/core/components/custom_network_image.dart';
import 'package:market_place/core/constants/custom_text.dart';
import 'package:market_place/core/utils/variable.dart';
import 'package:market_place/core/constants/padding_constant.dart';

class CategoryCardItemWidget extends StatelessWidget {
  const CategoryCardItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomNetworkImage(
            imageUrl: imageUrl,
            boxShape: BoxShape.circle,
            height: 60.w,
            width: 60.w,
          ),
          CustomText(

              textAlign: TextAlign.center,
              text: "Health Products	", maxLines: 2),
        ],
      ),
    );
  }
}
class CategoryDetailsCardItemWidget extends StatelessWidget {
  const CategoryDetailsCardItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(width: .5, color: Colors.black),
      ),
      width: 110.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomNetworkImage(
            imageUrl: imageUrl,
            height: 150.w,
            borderRadius: BorderRadius.vertical(top: Radius.circular(4.r)),
          ),
          Padding(
            padding: padding6,
            child: CustomText(
              text: "Women's Fashion	",
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

