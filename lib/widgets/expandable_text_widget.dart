import 'package:flutter/material.dart';
import 'package:flutter_ecom_food_app/units/colors.dart';
import 'package:flutter_ecom_food_app/units/dimensions.dart';
import 'package:flutter_ecom_food_app/widgets/small_text.dart';

class ExpandbleTextWidget extends StatefulWidget {
  final String text;
  const ExpandbleTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandbleTextWidget> createState() => _ExpandbleTextWidgetState();
}

class _ExpandbleTextWidgetState extends State<ExpandbleTextWidget> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText = true;

  double textHeight = Dimensions.screenHeight / 5.63;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SmallText(size: Dimensions.font16, text: firstHalf)
          : Column(
              children: [
                SmallText(
                  height: 1.8,
                  color: AppColors.paraColor,
                  size: Dimensions.font16,
                  text: hiddenText
                      ? ("$firstHalf...")
                      : (firstHalf + secondHalf),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(children: [
                    SmallText(
                      text: hiddenText ? "Show more" : "Show less",
                      color: AppColors.mainColor,
                    ),
                    Icon(
                      hiddenText ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                      color: AppColors.mainColor,
                    ),
                  ]),
                )
              ],
            ),
    );
  }
}
