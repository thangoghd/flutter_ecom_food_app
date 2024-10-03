import 'package:flutter/material.dart';
import 'package:flutter_ecom_food_app/controllers/cart_controller.dart';
import 'package:flutter_ecom_food_app/data/repository/popular_product_repo.dart';
import 'package:flutter_ecom_food_app/units/colors.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';
import '../models/product_model.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  late CartController _cart;
  

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems + quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {}
  }



  void setQuantity(bool isIncrement) {
    if(isIncrement == true){
      _quantity = checkQuantity(_quantity + 1);
      print("number of items $_quantity");
    }
    else{
      _quantity = checkQuantity(_quantity - 1);
      print("decrement $_quantity");
    }
    update();
  }

  int checkQuantity(int quantity){
    if(_inCartItems + quantity < 0) { 
      Get.snackbar("Item count", "You can't reduce more !", backgroundColor: AppColors.mainColor, colorText: Colors.white);
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    }
    else if(_inCartItems + quantity > 20){
      Get.snackbar("Item count","You can't add more !"	, backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 20;
    }
    else return quantity;
  }

  void initProduct(ProductModel product, CartController cart)
  {
    _quantity = 0;
    _inCartItems = cart.getQuantity(product);
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product);

    // print("Exist or not: $exist");
    if(exist) {
      _inCartItems = _cart.getQuantity(product);
    }
    // print("The quantity in the cart is $_inCartItems");
  }

  void addItem(ProductModel product) {// if (_quantity > 0) {
      _cart.addItem(product, _quantity);
      _quantity = 0;
      _inCartItems=_cart.getQuantity(product);
      _cart.items.forEach((key, value) {
        print("Id: ${value.id}, quantity: ${value.quantity}");
      });
    update();
  }

  int get totalItems{
    return _cart.totalItems;
  }

  List<CartModel> get Items{
    return _cart.getItems;
  }

}
