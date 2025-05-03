import 'package:get/get.dart';
import 'package:market_place/core/utils/common_controller.dart' show CommonController;
import 'package:market_place/presentations/navigation/controller/navigation_controller.dart';
import 'package:market_place/presentations/notification/controller/notification_controller.dart';

import '../../presentations/home/controller/home_controller.dart';
import '../../presentations/my-listings/controller/listings_controller.dart';
// import 'package:market_place/presentations/auth/controllers/auth_controller.dart';
// import 'package:market_place/presentations/cart/controllers/cart_controller.dart';
// import 'package:market_place/presentations/navigation/controllers/home_controller.dart';
// import 'package:market_place/presentations/product/controllers/product_controller.dart';
// import 'package:market_place/presentations/profile/controllers/profile_controller.dart';
// import 'package:market_place/presentations/settings/controllers/settings_controller.dart';
// import 'package:market_place/presentations/splash/controllers/common_controller.dart';
// import 'package:market_place/presentations/splash/controllers/splash_controller.dart';
//
// import '../../presentations/home/controllers/home_controller.dart';

// class SplashBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.put(SplashController());
//   }
// }
//
class CommonBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CommonController(), permanent: true);

  }
}
//
// class ProductBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.put(ProductController());
//   }
// }
//
// class AuthBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.put(AuthController());
//   }
// }
//
class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NavigationController());
    // Get.lazyPut(()=>CartController());
  }
}class ListingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ListingsController());
    // Get.lazyPut(()=>CartController());
  }
}
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
//
// class ProfileBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.put(ProfileController());
//   }
// }
//
class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NotificationController());
  }
}
