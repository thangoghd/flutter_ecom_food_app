import 'package:flutter_ecom_food_app/data/repository/drinks_product_repo.dart';
import 'package:flutter_ecom_food_app/models/product_model.dart';
import 'package:get/get.dart';

class DrinksProductController extends GetxController {
  final DrinksProductRepo drinksProductRepo;
  DrinksProductController({required this.drinksProductRepo});
  List<dynamic> _drinksProductList = [];
  List<dynamic> get drinksProductList => _drinksProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getDrinksProductList() async {
    Response response = await drinksProductRepo.getDrinksProductList();
    if (response.statusCode == 200) {
      _drinksProductList = [];
      _drinksProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    }
    else{}
  }
}