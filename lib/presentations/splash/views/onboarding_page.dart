import 'package:flutter/material.dart';
import 'package:market_place/core/components/custom_text_button.dart';

import '../../../core/utils/variable.dart';
import '../controller/splash_controller.dart';
import '../widgets/onboarding_item_content_widget.dart';

class OnboardingPage extends StatelessWidget {
  static const String routeName = "/onboarding";
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [CustomTextButton(title: 'Skip',onPressed: () {

        },)],
      ),
      body: PageView.builder(
        controller: SplashController.to.pageController!.value,
        onPageChanged: (value) {

          SplashController.to.currentIndex.value=value;
        },
        itemCount: onboardingData.length,
        itemBuilder: (context, index) {
          return OnboardingItemContentWidget(
            onboardingModel: onboardingData[index],
          );
        },
      ),
    );
  }
}
