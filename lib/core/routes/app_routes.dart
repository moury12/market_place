import 'package:get/get.dart';
import 'package:market_place/core/bindings/bindings.dart' show NavigationBinding;

import '../../presentations/navigation/views/navigation_page.dart';
// import 'package:market_place/core/bindings/bindings.dart';
// import 'package:market_place/presentations/auth/views/forget_pass_page.dart';
// import 'package:market_place/presentations/auth/views/login_page.dart';
// import 'package:market_place/presentations/auth/views/otp_page.dart';
// import 'package:market_place/presentations/auth/views/set_new_password_page.dart';
// import 'package:market_place/presentations/auth/views/signup_page.dart';
// import 'package:market_place/presentations/home/views/category_list_page.dart';
// import 'package:market_place/presentations/home/views/product_list_page.dart';
// import 'package:market_place/presentations/navigation/views/navigation_page.dart';
// import 'package:market_place/presentations/product/views/deliver_address_page.dart';
// import 'package:market_place/presentations/product/views/edit_address_page.dart';
// import 'package:market_place/presentations/product/views/payment_page.dart';
// import 'package:market_place/presentations/product/views/pickup_address_page.dart';
// import 'package:market_place/presentations/product/views/product_details_page.dart';
// import 'package:market_place/presentations/profile/views/profile_page.dart';
// import 'package:market_place/presentations/settings/views/change_pass_page.dart';
// import 'package:market_place/presentations/settings/views/feedback_page.dart';
// import 'package:market_place/presentations/settings/views/privacy_terms_page.dart';
// import 'package:market_place/presentations/settings/views/settings_page.dart';
// import 'package:market_place/presentations/splash/views/splash_page.dart';

class AppRoutes {
  static route() => [
        // GetPage(name: SplashPage.routeName, page: () => SplashPage(), binding: SplashBinding()),
        // GetPage(name: LoginPage.routeName, page: () => LoginPage(), binding: AuthBinding()),
        // GetPage(name: SignupPage.routeName, page: () => SignupPage(), binding: AuthBinding()),
        // GetPage(name: ForgetPassPage.routeName, page: () => ForgetPassPage(), binding: AuthBinding()),
        // GetPage(name: OtpPage.routeName, page: () => OtpPage(), binding: AuthBinding()),
        // GetPage(name: SetNewPasswordPage.routeName, page: () => SetNewPasswordPage(), binding: AuthBinding()),
        GetPage(name: NavigationPage.routeName, page: () => NavigationPage(), binding: NavigationBinding()),
        // GetPage(name: ProfilePage.routeName, page: () => ProfilePage(), binding: ProfileBinding()),
        // GetPage(name: SettingPage.routeName, page: () => SettingPage(), binding: SettingsBinding()),
        // GetPage(name: FeedbackPage.routeName, page: () => FeedbackPage(), binding: SettingsBinding()),
        // GetPage(name: ChangePassPage.routeName, page: () => ChangePassPage(), binding: SettingsBinding()),
        // GetPage(name: PrivacyTermsPage.routeName, page: () => PrivacyTermsPage(), binding: SettingsBinding()),
        // GetPage(name: CategoryListPage.routeName, page: () => CategoryListPage(), binding: HomeBinding()),
        // GetPage(name: ProductListPage.routeName, page: () => ProductListPage(), binding: HomeBinding()),
        // GetPage(name: ProductDetailsPage.routeName, page: () => ProductDetailsPage(), binding: ProductBinding()),
        // GetPage(name: EditAddressPage.routeName, page: () => EditAddressPage(), binding: ProductBinding()),
        // GetPage(name: PaymentScreen.routeName, page: () => PaymentScreen(), binding: ProductBinding()),
        // GetPage(name: PickupAddressPage.routeName, page: () => PickupAddressPage(), binding: ProductBinding()),
        // GetPage(name: DeliverAddressPage.routeName, page: () => DeliverAddressPage(), binding: ProductBinding()),
      ];
}
