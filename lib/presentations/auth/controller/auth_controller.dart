import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:market_place/presentations/auth/model/package_model.dart';
import 'package:market_place/presentations/auth/views/subscription_page.dart';
import 'package:market_place/presentations/auth/views/verify_otp_page.dart';

import '../../../core/api-client/api_endpoints.dart';
import '../../../core/api-client/api_service.dart';
import '../../../core/constants/app_static_strings.dart';
import '../../../core/helper/helper_function.dart';
import '../../../core/utils/common_controller.dart';
import '../../../core/utils/enum.dart';
import '../../../core/utils/hive_boxes.dart';
import '../../../core/utils/variable.dart';
import '../../navigation/views/navigation_page.dart';
import '../views/login_page.dart';
import '../views/payment_page.dart';
import '../views/set_new_password_page.dart';
import '../widgets/subscription_plan_card_widget.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();
  @override
  void onInit() {
    reinitializeSignUpControllers();
    getPackagesRequest();
    ever(packageList, (_) => updateTabContent());

    super.onInit();
  }

  RxBool isRememberMe = false.obs;
  RxBool isLoadingSubscribe = false.obs;
  RxList<PackageModel> packageList = <PackageModel>[].obs;

  RxList<String> tabLabels =
      [AppStaticStrings.monthly, AppStaticStrings.yearly].obs;
  var tabContent = <Widget>[].obs;
  Rx<AuthProcess> loadingProcess = AuthProcess.none.obs;
  bool isLoading(AuthProcess process) => loadingProcess.value == process;
  bool get isAnyLoading => loadingProcess.value != AuthProcess.none;

  ///=============================controller for signUp ========================///

  Rx<TextEditingController> emailSignUpController = TextEditingController().obs;
  TextEditingController nameSignUpController = TextEditingController();
  TextEditingController phoneSignUpController = TextEditingController();
  Rx<TextEditingController> ageSignUpController = TextEditingController().obs;
  TextEditingController passSignUpController = TextEditingController();

  TextEditingController confirmPassSignUpController = TextEditingController();
  Rx<TextEditingController> emailForgetController = TextEditingController().obs;

  TextEditingController emailLoginController = TextEditingController();
  TextEditingController passLoginController = TextEditingController();

  TextEditingController passNewController = TextEditingController();

  TextEditingController confirmPassNewController = TextEditingController();

  ///------------------------------ sign up method -------------------------///
  Future<void> signUpRequest() async {
    try {
      // Set loading state for this specific process
      loadingProcess.value = AuthProcess.signUp;

      final response = await ApiService().request(
        endpoint: signupEndPoint,
        method: 'POST',
        body: {
          "name": nameSignUpController.text,
          "email": emailSignUpController.value.text,
          "phone": phoneSignUpController.value.text,
          "password": passSignUpController.text,
          "confirm_password": confirmPassSignUpController.text,
        },
        useAuth: false,
      );

      // Clear loading state
      loadingProcess.value = AuthProcess.none;

      if (response['success'] == true) {
        logger.d(response);
        showCustomSnackbar(title: 'Success', message: response['message']);
        Get.toNamed(VerifyOtpPage.routeName, arguments: verifyEmail);
      } else {
        logger.e(response);
        showCustomSnackbar(
          title: 'Failed',
          message: response['message'],
          type: SnackBarType.failed,
        );
      }
    } catch (e) {
      loadingProcess.value = AuthProcess.none;
      logger.e(e.toString());
    }
  }

  ///------------------------------ verify email method -------------------------///
  Future<void> verifyEmailRequest({
    required String email,
    required bool isAccVerify,
  }) async {
    try {
      loadingProcess.value = AuthProcess.activateAccount;

      final response = await ApiService().request(
        endpoint: verifyEmailEndPoint,
        useAuth: false,
        method: 'POST',
        body: {
          "email": email,
          "code": otpControllers.map((e) => e.value.text).join(),
        },
      );

      loadingProcess.value = AuthProcess.none;

      if (response['success'] == true) {
        logger.d(response);
        Boxes.getUserData().put(verifyTokenKey, response['data']['resetToken']);
        logger.d(
          Boxes.getUserData().put(
            verifyTokenKey,
            response['data']['resetToken'],
          ),
        );
        showCustomSnackbar(title: 'Success', message: response['message']);

        if (isAccVerify) {
          Get.offAllNamed(SubscriptionPage.routeName);
        } else {
          Get.toNamed(SetNewPasswordPage.routeName);
        }
      } else {
        logger.e(response);
        showCustomSnackbar(
          title: 'Failed',
          message: response['message'],
          type: SnackBarType.failed,
        );
      }
    } catch (e) {
      loadingProcess.value = AuthProcess.none;
      logger.e(e.toString());
    }
  }

  ///------------------------------ sign in method -------------------------///
  Future<void> signInRequest() async {
    try {
      loadingProcess.value = AuthProcess.login;

      final response = await ApiService().request(
        endpoint: signInEndPoint,
        method: 'POST',
        useAuth: false,
        body: {
          "email": AuthController.to.emailLoginController.text,
          "password": AuthController.to.passLoginController.text,
        },
      );

      loadingProcess.value = AuthProcess.none;

      if (response['success'] == true) {
        logger.d(response);
        showCustomSnackbar(title: 'Success', message: response['message']);
        Boxes.getUserData().put(tokenKey, response['token']);
        ApiService().setAuthToken(Boxes.getUserData().get(tokenKey).toString());
        Get.offAllNamed(NavigationPage.routeName);
      } else {
        logger.e(response);
        showCustomSnackbar(
          title: 'Failed',
          message: response['message'],
          type: SnackBarType.failed,
        );
      }
    } catch (e) {
      loadingProcess.value = AuthProcess.none;
      logger.e(e.toString());
    }
  }

  ///------------------------------ forget password method -------------------------///
  Future<void> forgetPasswordRequest({required String email}) async {
    try {
      loadingProcess.value = AuthProcess.forgetPassword;

      final response = await ApiService().request(
        endpoint: forgetPassEndPoint,
        method: 'POST',
        body: {"email": email},
      );

      loadingProcess.value = AuthProcess.none;

      if (response['success'] == true) {
        logger.d(response);
        showCustomSnackbar(title: 'Success', message: response['message']);
        Get.toNamed(VerifyOtpPage.routeName);
      } else {
        logger.e(response);
        showCustomSnackbar(
          title: 'Failed',
          message: response['message'],
          type: SnackBarType.failed,
        );
      }
    } catch (e) {
      loadingProcess.value = AuthProcess.none;
      logger.e(e.toString());
    }
  }

  ///------------------------------ reset password method -------------------------///
  Future<void> resetPasswordRequest() async {
    try {
      loadingProcess.value = AuthProcess.resetPassword;

      ApiService().setAuthToken(
        Boxes.getUserData().get(verifyTokenKey).toString(),
      );

      final response = await ApiService().request(
        endpoint: resetPasswordEndPoint,
        method: 'POST',
        body: {
          "confirm_password": confirmPassNewController.text,
          "password": passNewController.text,
        },
      );

      loadingProcess.value = AuthProcess.none;

      if (response['success'] == true) {
        logger.d(response);
        showCustomSnackbar(title: 'Success', message: response['message']);
        ApiService().clearAuthToken();
        Get.offAllNamed(LoginPage.routeName);
      } else {
        logger.e(response);
        showCustomSnackbar(
          title: 'Failed',
          message: response['message'],
          type: SnackBarType.failed,
        );
      }
    } catch (e) {
      loadingProcess.value = AuthProcess.none;
      logger.e(e.toString());
    }
  }

  ///-----------------------------get package list method------------------------------///

  Future<void> getPackagesRequest() async {
    try {
      loadingProcess.value = AuthProcess.packageGet;

      final response = await ApiService().request(
        endpoint: packageAllListEndPoint,
        method: 'GET',
      );

      loadingProcess.value = AuthProcess.none;

      if (response['success'] == true) {
        logger.d(response);
        packageList.value =
            (response['data'] as List)
                .map((e) => PackageModel.fromJson(e))
                .toList();
        if (packageList.isNotEmpty) {
          tabLabels.value =
              packageList.map((e) => e.type ?? "Unknown").toList();
        } else {
          tabLabels.value = [
            AppStaticStrings.monthly,
            AppStaticStrings.yearly,
          ]; // Fallback
        }
      } else {
        logger.e(response);
        showCustomSnackbar(
          title: 'Failed',
          message: response['message'],
          type: SnackBarType.failed,
        );
      }
    } catch (e) {
      loadingProcess.value = AuthProcess.none;
      logger.e(e.toString());
    }
  }

  ///------------------------------ subscribe now method -------------------------///

  Future<void> subscribeNowRequest({required String subscribeId}) async {
    try {
      isLoadingSubscribe.value = true;
      ApiService().setAuthToken(
        Boxes.getUserData().get(tokenKey) != null
            ? Boxes.getUserData().get(tokenKey).toString()
            : Boxes.getUserData().get(verifyTokenKey).toString(),
      );
      final response = await ApiService().request(
        endpoint: subscribeEndPoint,
        method: 'POST',
        useAuth: true,
        body: {"subscription_id": subscribeId},
      );

      isLoadingSubscribe.value = false;

      if (response['success'] == true) {
        logger.d(response);
        CommonController.to.stripeUrl.value = response["url"];
        Get.toNamed(PaymentScreen.routeName);
        showCustomSnackbar(title: 'Success', message: response['message']);
      } else {
        logger.e(response);
        showCustomSnackbar(
          title: 'Failed',
          message: response['message'],
          type: SnackBarType.failed,
        );
      }
    } catch (e) {
      isLoadingSubscribe.value = false;
      logger.e(e.toString());
    }
  }

  clearSignUpController() {
    emailSignUpController.value.clear();
    nameSignUpController.clear();
    passSignUpController.clear();
    confirmPassSignUpController.clear();
  }

  @override
  void onClose() {
    emailSignUpController.value.dispose();
    nameSignUpController.dispose();
    passSignUpController.dispose();
    confirmPassSignUpController.dispose();
    passNewController.dispose();
    confirmPassNewController.dispose();
    super.onClose();
  }

  reinitializeSignUpControllers() {
    if (kDebugMode) {
      emailSignUpController.value.text = 'kediwiw260@daupload.com';
      nameSignUpController.text = 'kediwiw260';
      phoneSignUpController.text = '01566026603';
      passSignUpController.text = '12345aA*';
      confirmPassSignUpController.text = '12345aA*';
      emailLoginController.text = 'calaga8422@bocapies.com';
      emailForgetController.value.text =
          'calaga8422@bocapies.com' /*'pihoner651@eligou.com'*/;
      passLoginController.text = '12345aA!';
      passNewController.text = '12345aA*';
      confirmPassNewController.text = '12345aA*';
    }
  }

  void updateTabContent() {
    tabContent.clear();
    for (var package in packageList) {
      tabContent.add(SubscriptionPlanWidget(package: package));
    }

    if (packageList.isEmpty) {
      tabContent.addAll([
        SubscriptionPlanWidget(package: PackageModel(type: 'monthly')),
        SubscriptionPlanWidget(package: PackageModel(type: 'yearly')),
      ]);
      tabLabels.value = [AppStaticStrings.monthly, AppStaticStrings.yearly];
    } else {
      tabLabels.value = packageList.map((p) => p.type ?? 'Unknown').toList();
    }
  }

  ///------------------------------- OTP section ------------------------------///
  final List<Rx<TextEditingController>> otpControllers = List.generate(
    6,
    (index) => TextEditingController().obs,
  );
  final List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());
  void onOtpChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < 5) {
        focusNodes[index + 1].requestFocus(); // Move to next field
      }
    } else if (index > 0) {
      focusNodes[index - 1]
          .requestFocus(); // Move to previous field on backspace
    }
  }

  bool checkOtpProvided() {
    for (var controller in otpControllers) {
      if (controller.value.text.isEmpty) {
        return false; // If any field is empty, return false
      }
    }
    return true; // All fields are filled
  }

  String getOtp() {
    return otpControllers.map((e) => e.value.text).join();
  }

  void clearOtp() {
    for (var controller in otpControllers) {
      controller.value.clear();
    }
    focusNodes[0].requestFocus();
  }
}
