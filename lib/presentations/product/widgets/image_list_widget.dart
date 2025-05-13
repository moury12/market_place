import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_place/core/api-client/api_service.dart';
import 'package:market_place/core/components/custom_network_image.dart';
import 'package:market_place/core/constants/color_constants.dart';
import 'package:market_place/core/helper/helper_function.dart';

class ListOfImages extends StatelessWidget {
  final RxList<String> images;

  const ListOfImages({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.sp),
      child: Obx(() {
        return images.isEmpty
            ? SizedBox.shrink()
            : Wrap(
              spacing: 8.w,
              runSpacing: 8.w,
              children: List.generate(images.length, (index) {
                final img = images[index];
                return Stack(
                  children: [
                    img.contains(ApiService().baseUrl)
                        ? CustomNetworkImage(
                          imageUrl: img,
                          height: 110.w,
                          width: 110.w,
                        )
                        : Image.file(
                          File(img),
                          height: 110.w,
                          width: 110.w,
                          fit: BoxFit.cover,
                        ),
                    Positioned(
                      top: -10,
                      right: -10,

                      child: IconButton(
                        onPressed: () {
                          removeImage(uploadImages: images, imagePath: img);
                        },
                        icon: Icon(
                          CupertinoIcons.multiply_circle_fill,
                          size: 20,
                          color: AppColors.kPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                );
              }),
            );
      }),
    );
  }
}
