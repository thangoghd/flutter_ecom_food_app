import 'package:flutter/material.dart';
import 'package:flutter_ecom_food_app/units/dimensions.dart';
import 'package:flutter_ecom_food_app/widgets/small_text.dart';

class IconAndWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  const IconAndWidget(this.icon, this.text, this.iconColor, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: Dimensions.icon16,
        ),
        SizedBox(
          width: Dimensions.font20 / 5,
        ),
        SmallText(
          text: text,
        ),
      ],
    );
  }
}
