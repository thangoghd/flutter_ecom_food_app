import 'package:flutter_ecom_food_app/controllers/auth_controller.dart';
import 'package:flutter_ecom_food_app/controllers/cart_controller.dart';
import 'package:flutter_ecom_food_app/controllers/location_controller.dart';
import 'package:flutter_ecom_food_app/controllers/popular_product_controller.dart';
import 'package:flutter_ecom_food_app/controllers/recommended_product_controller.dart';
import 'package:flutter_ecom_food_app/controllers/user_controller.dart';
import 'package:flutter_ecom_food_app/data/api/api_client.dart';
import 'package:flutter_ecom_food_app/data/repository/auth_repo.dart';
import 'package:flutter_ecom_food_app/data/repository/cart_repo.dart';
import 'package:flutter_ecom_food_app/data/repository/location_repo.dart';
import 'package:flutter_ecom_food_app/data/repository/popular_product_repo.dart';
import 'package:flutter_ecom_food_app/data/repository/recommended_product_repo.dart';
import 'package:flutter_ecom_food_app/data/repository/user_repo.dart';
import 'package:flutter_ecom_food_app/units/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

  // Api client
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));
  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  // Repoes
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  Get.lazyPut(
      () => LocationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  // Controllers
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo: Get.find()));
}
