import 'package:flutter_ecom_food_app/data/api/api_client.dart';
import 'package:flutter_ecom_food_app/units/app_constants.dart';
import 'package:get/get.dart';

class DrinksProductRepo extends GetxService {
  final ApiClient apiClient;
  DrinksProductRepo({required this.apiClient});

  Future<Response> getDrinksProductList() async {
    return await apiClient.getData(AppConstants.DRINKS_PRODUCT_URI);
  }
}