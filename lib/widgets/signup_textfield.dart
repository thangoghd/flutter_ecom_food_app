import 'package:flutter/material.dart';
import 'package:flutter_ecom_food_app/units/colors.dart';
import 'package:flutter_ecom_food_app/units/dimensions.dart';
class SignUpTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final IconData icon;
  final bool isPassword;
  final TextInputType keyboardType;

  const SignUpTextField({
    super.key,
    required this.textEditingController,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
    required this.keyboardType,
  });

  @override
  State<SignUpTextField> createState() => _SignUpTextFieldState();
}

class _SignUpTextFieldState extends State<SignUpTextField> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: Dimensions.width20, right: Dimensions.width20),
      child: TextFormField(
        controller: widget.textEditingController,
        obscureText: widget.isPassword && _obscureText,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle:
              TextStyle(color: AppColors.mainBlackColor.withOpacity(0.5)),
          prefixIcon: Icon(
            widget.icon,
            color: AppColors.mainBlackColor.withOpacity(0.5),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 160, 160, 160), width: 1.0),
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: _togglePasswordVisibility,
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.mainBlackColor.withOpacity(0.5),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
