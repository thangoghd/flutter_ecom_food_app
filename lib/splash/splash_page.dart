import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ecom_food_app/controllers/popular_product_controller.dart';
import 'package:flutter_ecom_food_app/controllers/recommended_product_controller.dart';
import 'package:flutter_ecom_food_app/routes/route_helper.dart';
import 'package:flutter_ecom_food_app/units/dimensions.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResources() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }
  
  @override
  void initState() {
    super.initState();
    _loadResources();
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacementNamed(context, RouteHelper.getInitial())
    );
    controller.addListener(() {
      setState(() {
        
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(child: Image.asset("assets/images/logo1.png", width: Dimensions.splashImg,))),
        ]
      )
    );
  }
}
