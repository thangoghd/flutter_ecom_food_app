import 'dart:io';
import 'package:flutter/foundation.dart';

class AppConstants {
  static const String APP_NAME = "SVGFood";
  static const int APP_VERSION = 1;

  static String get BASE_URL {
    if (Platform.isMacOS || (Platform.isIOS && !kReleaseMode)) {
      return "http://127.0.0.1:80";
    } else {
      return "http://192.168.137.1:80";
    }
  }

  //auth
  static const String REGISTRATION_URI = '/api/v1/auth/register';
  static const String LOGIN_URI = '/api/v1/auth/login';
  static const String FORGOT_PASSWORD_URI = '/api/v1/auth/forgot-password';
  static const String CHANGE_PASSWORD_URI = '/api/v1/auth/change-password';
  static const String USER_INFO_URI = '/api/v1/customer/info';

  //user info
  static const String USER_EMAIL = 'user_email';
  static const String USER_PASSWORD = 'user_password';

  //product
  static const String POPULAR_PRODUCT_URI = '/api/v1/products/popular';
  static const String RECOMENDED_PRODUCT_URI = '/api/v1/products/recommended';
  static const String DRINKS_PRODUCT_URI = '/api/v1/products/drinks';
  static const String UPLOAD_URL = '/uploads/';

  //shared preferences
  static const String TOKEN = "";
  static const String CART_LIST = "Cart-list";
  static const String CART_HISTORY_LIST = "cart-history-list";
}
