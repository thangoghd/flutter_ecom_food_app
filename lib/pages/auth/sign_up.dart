import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecom_food_app/base/custom_loader.dart';
import 'package:flutter_ecom_food_app/controllers/auth_controller.dart';
import 'package:flutter_ecom_food_app/models/signup_body_model.dart';
import 'package:flutter_ecom_food_app/pages/auth/sign_in.dart';
import 'package:flutter_ecom_food_app/routes/route_helper.dart';
import 'package:flutter_ecom_food_app/units/colors.dart';
import 'package:flutter_ecom_food_app/units/dimensions.dart';
import 'package:flutter_ecom_food_app/widgets/big_text.dart';
import 'package:flutter_ecom_food_app/widgets/signup_textfield.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter_ecom_food_app/base/show_custom_message.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpMethod = [
      "google_logo.png",
      "facebook_logo.png",
      "apple_logo.png"
    ];

    void register(AuthController authController) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();

      if (email.isEmpty) {
        showErrorSnackBar("Email is required!");
      } else if (!GetUtils.isEmail(email)) {
        showErrorSnackBar("Email is invalid!");
      } else if (password.isEmpty) {
        showErrorSnackBar("Password is required!");
      } else if (password.length < 6) {
        showErrorSnackBar("Password must be at least 6 characters!");
      } else if (name.isEmpty) {
        showErrorSnackBar("Name is required!");
      } else if (phone.isEmpty) {
        showErrorSnackBar("Phone is required!");
      } else {
        SignUpBodyModel signUpBodyModel = SignUpBodyModel(
            name: name, phone: phone, email: email, password: password);
        authController.registration(signUpBodyModel).then((response) {
          if (response.isSuccess) {
            showRedirectSnackBar("Registration successful!", 2,
                title: "Success, redirecting to login page in 2 seconds");
            Future.delayed(Duration(seconds: 2), () {
              Get.toNamed(RouteHelper.getInitial());
            });
          } else {
            showErrorSnackBar(response.message);
          }
        });
      }
    }

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (currentFocus.focusedChild != null &&
            !currentFocus.hasPrimaryFocus) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: GetBuilder<AuthController>(builder: (authController) {
          return !authController.isLoading
              ? SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: Dimensions.screenHeight * 0.075),
                      Container(
                          child: Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: Dimensions.height20 * 3,
                          backgroundImage:
                              AssetImage("assets/images/user/avatar_1.png"),
                        ),
                      )),
                      SizedBox(height: Dimensions.height20),
                      SignUpTextField(
                          textEditingController: emailController,
                          hintText: "Email",
                          icon: Icons.email,
                          keyboardType: TextInputType.emailAddress),
                      SizedBox(height: Dimensions.height20),
                      SignUpTextField(
                          textEditingController: passwordController,
                          hintText: "Password",
                          icon: Icons.lock,
                          isPassword: true,
                          keyboardType: TextInputType.text),
                      SizedBox(height: Dimensions.height20),
                      SignUpTextField(
                          textEditingController: nameController,
                          hintText: "Name",
                          icon: Icons.person,
                          keyboardType: TextInputType.name),
                      SizedBox(height: Dimensions.height20),
                      SignUpTextField(
                          textEditingController: phoneController,
                          hintText: "Phone",
                          icon: Icons.phone,
                          keyboardType: TextInputType.phone),
                      SizedBox(height: Dimensions.height20),
                      GestureDetector(
                        onTap: () {
                          register(authController);
                        },
                        child: Container(
                          width: Dimensions.screenWidth / 2,
                          height: Dimensions.screenHeight / 13,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: AppColors.mainColor,
                          ),
                          child: Center(
                              child: BigText(
                                  text: "Sign Up",
                                  size: Dimensions.font16 * 2,
                                  color: Colors.white)),
                        ),
                      ),
                      SizedBox(height: Dimensions.height20),
                      RichText(
                          text: TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.back(),
                        text: "Already have an account?",
                        style: TextStyle(
                            color: AppColors.mainBlackColor,
                            fontSize: Dimensions.font16,
                            fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(
                              text: " Login",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.back(),
                              style: TextStyle(
                                  color: AppColors.mainColor,
                                  fontSize: Dimensions.font16,
                                  fontWeight: FontWeight.bold)),
                        ],
                      )),
                      SizedBox(height: Dimensions.height20),
                      RichText(
                          text: TextSpan(
                        text: "Sign in using one of the following methods",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font12,
                        ),
                      )),
                      Wrap(
                        children: List.generate(
                          Platform.isIOS ? 3 : 2,
                          (index) => Padding(
                            padding: EdgeInsets.all(Dimensions.width10),
                            child: CircleAvatar(
                              radius: Dimensions.height30,
                              backgroundImage: AssetImage(
                                  "assets/images/user/" + signUpMethod[index]),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : Center(child: const CustomLoader());
        }),
      ),
    );
  }
}
