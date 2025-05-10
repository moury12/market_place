import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:market_place/core/components/custom_appbar.dart';
import 'package:market_place/core/utils/common_controller.dart';
import 'package:market_place/core/components/custom_button.dart';
import 'package:market_place/core/constants/app_static_strings.dart';
import 'package:market_place/core/constants/color_constants.dart';

import 'package:webview_flutter/webview_flutter.dart';


class PaymentScreen extends StatefulWidget {
  static const String routeName = '/payment';

  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    final commonController = CommonController.to;
    if (commonController.webController == null) {
      commonController.initializeWebViewController();
    }

    return Scaffold(
      appBar: CustomDefaultAppbar(title: AppStaticStrings.payment.tr,),
      body: SizedBox.expand(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: WebViewWidget(controller: commonController.webController!),
            ),
            Obx(
                  () => commonController.isLoading.value
                  ? const Center(
                child: DefaultProgressIndicator(
                  color: AppColors.kPrimaryColor,
                ),
              )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    CommonController.to.webController = null;
    CommonController.to.stripeUrl.value = '';
    // TODO: implement dispose
    super.dispose();
  }
}
