import 'package:get/get.dart';
import 'package:market_place/core/components/custom_appbar.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_static_strings.dart';

class TermsPolicyHelpPage extends StatelessWidget {
  static const String routeName = '/terms';
   TermsPolicyHelpPage({super.key});
final arg = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomDefaultAppbar(title: arg),

    );
  }
}
