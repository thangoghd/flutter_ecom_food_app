import 'package:flutter/material.dart';
import 'package:flutter_ecom_food_app/units/dimensions.dart';
import 'package:flutter_ecom_food_app/widgets/app_icon.dart';
import 'package:flutter_ecom_food_app/widgets/big_text.dart';

class AccountBar extends StatelessWidget {
  final AppIcon appIcon;
  final BigText bigText;
  const AccountBar({super.key, required this.appIcon, required this.bigText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height15, bottom: Dimensions.height15),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Dimensions.width10,),
          bigText,
        ],
      ),
    );
  }
}