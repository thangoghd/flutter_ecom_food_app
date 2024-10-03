import 'package:flutter/material.dart';
import 'package:flutter_ecom_food_app/units/colors.dart';
import 'package:flutter_ecom_food_app/units/dimensions.dart';
import 'package:flutter_ecom_food_app/widgets/big_text.dart';
import 'package:flutter_ecom_food_app/widgets/icon_and_widget.dart';
import 'package:flutter_ecom_food_app/widgets/small_text.dart';

class AppColumn extends StatelessWidget {
  final String nameFood;

  const AppColumn({
    Key? key,
    required this.nameFood,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      BigText(
        text: nameFood,
        size: Dimensions.font26,
      ),
      SizedBox(
        height: Dimensions.height10,
      ),
      Row(
        children: [
          Wrap(
              children: List.generate(
                  5,
                  (index) => const Icon(
                        Icons.star,
                        color: AppColors.mainColor,
                        size: 15,
                      ))),
          const SizedBox(
            width: 10,
          ),
          SmallText(text: "5"),
          SizedBox(
            width: Dimensions.width10,
          ),
          SmallText(text: "1234"),
          SizedBox(width: Dimensions.width10),
          SmallText(text: "comments"),
        ],
      ),
      SizedBox(
        height: Dimensions.height20,
      ),
      const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconAndWidget(Icons.circle_sharp, "Normal", AppColors.iconColor1),
          IconAndWidget(Icons.place, "1.2 km", AppColors.iconColor2),
          IconAndWidget(
              Icons.access_alarm_rounded, "32 mins", AppColors.mainBlackColor),
        ],
      ),
    ]);
  }
}
