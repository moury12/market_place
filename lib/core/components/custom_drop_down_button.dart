import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_place/core/components/custom_button.dart';
import 'package:market_place/core/constants/app_static_strings.dart';

import '../constants/color_constants.dart';
import '../constants/custom_space.dart';
import '../constants/fontsize_constant.dart';
import '../constants/padding_constant.dart';
import '../constants/text_style_constant.dart';


class CustomDropdown<T> extends StatefulWidget {
  final String? title;
  final String? hintText;
  final Color? borderColor;
  final Color? iconColor;
  final Color? fillColor;
  final Color? hintColor;
  final bool? isRequired;
  final bool? isLoading;
  final double? radius;
  final T? selectedValue;
  final List<T>? items;
  final String Function(T)? displayText;// Dynamic list of items
  final ValueChanged<T?>? onChanged; // Callback for selected value

  const CustomDropdown({
    super.key,
    this.title,
    this.hintText,
    this.borderColor,
    this.fillColor,
    this.hintColor,
    this.radius,
    this.iconColor,
    this.items, // Pass dropdown items dynamically
    this.onChanged,
    this.selectedValue,
    this.isRequired = false, this.isLoading=false, this.displayText, // Selected value managed externally
  });

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  /// Local state for the selected value
  T? selectedValue;

  @override
  void initState() {
    super.initState();
    // Initialize local state with the provided selected value
    selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        widget.title != null
            ? Row(
                children: [
                  Text(
                    widget.title ?? '',
                    style: poppinsSemiBold.copyWith(
                      color: AppColors.kBlackColor,
                        fontSize: getFontSizeSemiSmall()),
                  ),
                  widget.isRequired == true
                      ? Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(
                            '*',
                            style: poppinsRegular.copyWith(
                                color: Colors.red,
                                fontSize: getFontSizeSemiSmall()),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              )
            : const SizedBox.shrink(),
        widget.title != null ? space8H : const SizedBox.shrink(),
        Container(
          padding: padding12H,
          decoration: BoxDecoration(
            color: widget.fillColor ?? AppColors.kWhiteColor,
            border: Border.all(
              width: .5
              ,
              color: widget.borderColor ?? AppColors.kExtraLightGreyTextColor,
            ),
            borderRadius: BorderRadius.circular(widget.radius ?? 6.r),
          ),
          child: DropdownButton<T>(
dropdownColor: AppColors.kWhiteColor,
            padding: EdgeInsets.zero,
            value: selectedValue, // Use local state here
            isExpanded: true,
            underline: const SizedBox(), // Removes the default underline
            style: poppinsMedium.copyWith(
              color: widget.hintColor ?? AppColors.kLightTextColor,
              fontWeight: FontWeight.w400,
              fontSize: getFontSizeSemiSmall(),
            ),
            hint: Text(
              widget.hintText ??AppStaticStrings.selectOne.tr ,
              style: poppinsMedium.copyWith(
                  color: widget.hintColor ?? AppColors.kLightTextColor,
                  fontWeight: FontWeight.w400,
                  fontSize: getFontSizeSemiSmall()),
            ),

            icon:widget.isLoading==true?
                SizedBox(   height: 12,
                  width: 12,
                  child: DefaultProgressIndicator(color: AppColors.kPrimaryColor,
                    strokeWidth: 2,
                  ),
                ): Icon(
              Icons.keyboard_arrow_down,
              color: widget.iconColor ?? AppColors.kBlackColor,
              size: 20.sp,
            ),
            items: (widget.items ?? []).map((e) {
              return DropdownMenuItem<T>(
                value: e,

                child: Text(
                    _getDisplayText(e),                    style: poppinsMedium.copyWith(
                        color: AppColors.kBlackColor,
                        fontWeight: FontWeight.w400,
                        fontSize: getFontSizeSemiSmall())),
              );
            }).toList(),
            onChanged: /* widget.onChanged ??*/
                (value) {
              setState(() {
                selectedValue = value; // Update local state
              });
              if (widget.onChanged != null) {
                widget.onChanged!(value); // Notify parent widget
              }
            },
          ),
        ),
      ],
    );
  }
  String _getDisplayText(T? item) {
    if (item == null) return '';
    // Use custom display text if provided, otherwise use toString()
    return widget.displayText?.call(item) ?? item.toString();
  }
}
