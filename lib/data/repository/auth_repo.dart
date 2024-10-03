import 'package:flutter_ecom_food_app/data/api/api_client.dart';
import 'package:flutter_ecom_food_app/models/signup_body_model.dart';
import 'package:flutter_ecom_food_app/units/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> registration(SignUpBodyModel signUpBodyModel) async {
    return await apiClient.postData(
        AppConstants.REGISTRATION_URI, signUpBodyModel.toJson());
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "None user token";
  }

  Future<Response> login(String email, String password) async {
    return await apiClient.postData(AppConstants.LOGIN_URI, {
      'email': email,
      'password': password,
    });
  }

  Future<void> saveUserEmailAndPassword(String email, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.USER_EMAIL, email);
      await sharedPreferences.setString(AppConstants.USER_PASSWORD, password);
    } catch (e) {
      throw Exception('Error saving user email and password: $e');
    }
  }

  bool userLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  /// Remove all stored data and reset the api client.
  ///
  /// This is used when the user logs out of the application.
  ///
  /// Returns true if the data was successfully removed.
  Future<bool> logout() async {
    await sharedPreferences.remove(AppConstants.TOKEN);
    await sharedPreferences.remove(AppConstants.USER_EMAIL);
    await sharedPreferences.remove(AppConstants.USER_PASSWORD);
    apiClient.token = "";
    apiClient.updateHeader("");
    return true;
  }
}
