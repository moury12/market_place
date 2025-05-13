import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:market_place/core/components/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:market_place/presentations/profile/controllers/account_information_controller.dart';

import '../../../core/constants/fontsize_constant.dart';
import '../../../core/constants/pagination_loading_widget.dart';
import '../../../core/constants/text_style_constant.dart';

class TermsPolicyHelpPage extends StatelessWidget {
  static const String routeName = '/terms';
  TermsPolicyHelpPage({super.key});
  final arg = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomDefaultAppbar(title: arg),
      body: Obx(() {
        return AccountInformationController.to.isLoadingPolicy.value
            ? PaginationLoadingWidget()
            : HtmlWidget(
              arg != null && arg == 'terms'
                  ? '''${AccountInformationController.to.termsModel.value.desc}
'''
                  : '''${AccountInformationController.to.policyModel.value.desc}
''',
              textStyle: poppinsRegular.copyWith(
                fontSize: getFontSizeDefault(),
              ),
            );
      }),
    );
  }
}
