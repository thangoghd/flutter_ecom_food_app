import 'package:flutter/cupertino.dart';
import 'package:flutter_ecom_food_app/units/dimensions.dart';

class SmallText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double height;
  SmallText({
    Key? key,
    this.color = const Color(0xFFccc7c5),
    required this.text,
    this.size = 0,
    this.height = 1.2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Roboto',
        fontSize: size == 0 ? Dimensions.font12 : size,
        height: height,
        color: color,
      ),
    );
  }
}
