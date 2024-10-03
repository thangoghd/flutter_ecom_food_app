import 'package:flutter_ecom_food_app/pages/address/add_address_page.dart';
import 'package:flutter_ecom_food_app/pages/auth/sign_in.dart';
import 'package:flutter_ecom_food_app/pages/auth/sign_up.dart';
import 'package:flutter_ecom_food_app/pages/cart/cart_page.dart';
import 'package:flutter_ecom_food_app/pages/food/popular_food_detail.dart';
import 'package:flutter_ecom_food_app/pages/food/recommended_food_detailed.dart';
import 'package:flutter_ecom_food_app/pages/home/home_page.dart';
import 'package:flutter_ecom_food_app/splash/splash_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommmendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String signInPage = "/sign-in";
  static const String signUpPage = "/sign-up";
  static const String addAddressPage = "/add-address";

  static String getSplashPage() => splashPage;
  static String getInitial() => initial;
  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page) =>
      '$recommmendedFood?pageId=$pageId&page=$page';
  static String getCartPage() => cartPage;
  static String getSignInPage() => signInPage;
  static String getSignUpPage() => signUpPage;
  static String getAddAddressPage() => addAddressPage;
  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => const SplashScreen()),
    GetPage(name: initial, page: () => const HomePage()),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommmendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return RecommendedFoodDetail(
            pageId: int.parse(pageId!),
            page: page!,
          );
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cartPage,
        page: () {
          return const CartPage();
        },
        transition: Transition.fadeIn),
    GetPage(
        name: signInPage,
        page: () => const SignInPage(),
        transition: Transition.fadeIn),
    GetPage(
        name: signUpPage,
        page: () => const SignUpPage(),
        transition: Transition.fadeIn),
    GetPage(
      name: addAddressPage,
      page: () => const AddAddressPage(),
      transition: Transition.fadeIn,
    )
  ];
}
