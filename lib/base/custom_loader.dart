import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ecom_food_app/controllers/auth_controller.dart';
import 'package:flutter_ecom_food_app/units/colors.dart';
import 'package:flutter_ecom_food_app/units/dimensions.dart';
import 'package:get/get.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    print("CustomLoader" + Get.find<AuthController>().isLoading.toString());
    return Container(
      height: Dimensions.screenHeight * 0.1,
      width: Dimensions.screenHeight * 0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius15),
        color: AppColors.mainColor,
      ),
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }
}
