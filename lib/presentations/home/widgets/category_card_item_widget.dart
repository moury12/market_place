import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:market_place/core/components/custom_network_image.dart';
import 'package:market_place/core/constants/custom_text.dart';
import 'package:market_place/core/utils/variable.dart';

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
