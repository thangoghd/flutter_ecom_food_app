import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecom_food_app/base/show_custom_message.dart';
import 'package:flutter_ecom_food_app/controllers/auth_controller.dart';
import 'package:flutter_ecom_food_app/pages/auth/sign_up.dart';
import 'package:flutter_ecom_food_app/routes/route_helper.dart';
import 'package:flutter_ecom_food_app/units/colors.dart';
import 'package:flutter_ecom_food_app/units/dimensions.dart';
import 'package:flutter_ecom_food_app/widgets/big_text.dart';
import 'package:flutter_ecom_food_app/widgets/signup_textfield.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var signUpMethod = [
      "google_logo.png",
      "facebook_logo.png",
      "apple_logo.png"
    ];

    void login(AuthController authController) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty) {
        showErrorSnackBar("Email is required!");
      } else if (!GetUtils.isEmail(email)) {
        showErrorSnackBar("Email is invalid!");
      } else if (password.isEmpty) {
        showErrorSnackBar("Password is required!");
      } else if (password.length < 6) {
        showErrorSnackBar("Password must be at least 6 characters!");
      } else {
        authController.login(email, password).then((response) {
          if (response.isSuccess) {
            showRedirectSnackBar("Login successful!", 2,
                title: "Success, redirecting to home page in 2 seconds");
            Future.delayed(Duration(seconds: 2), () {
              Get.offAllNamed(RouteHelper.getInitial());
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
        body: GetBuilder<AuthController>(
          builder: (authController) {
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
                                AssetImage("assets/images/logo1.png"),
                          ),
                        )),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(
                              left: Dimensions.width20,
                              right: Dimensions.width20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello",
                                style: TextStyle(
                                    fontSize: Dimensions.font20 * 2,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Sign into your account",
                                style: TextStyle(
                                  fontSize: Dimensions.font20,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ),
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
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: Dimensions.height20),
                        Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(right: Dimensions.width20),
                          child: RichText(
                              text: TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.back(),
                            text: "Forgot your password?",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.font16,
                            ),
                          )),
                        ),
                        SizedBox(height: Dimensions.height30),
                        GestureDetector(
                          onTap: () => login(authController),
                          child: Container(
                            width: Dimensions.screenWidth / 2,
                            height: Dimensions.screenHeight / 13,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: AppColors.mainColor,
                            ),
                            child: Center(
                                child: BigText(
                                    text: "Sign In",
                                    size: Dimensions.font16 * 2,
                                    color: Colors.white)),
                          ),
                        ),
                        SizedBox(height: Dimensions.height20),
                        RichText(
                            text: TextSpan(
                          text: "Sign up using one of the following methods",
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
                                    "assets/images/user/" +
                                        signUpMethod[index]),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: Dimensions.height30),
                        RichText(
                            text: TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.to(() => SignUpPage(),
                                transition: Transition.rightToLeft),
                          text: "Don't have an account?",
                          style: TextStyle(
                              color: AppColors.mainBlackColor,
                              fontSize: Dimensions.font16,
                              fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                                text: " Sign Up",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () =>
                                      Get.toNamed(RouteHelper.getSignUpPage()),
                                style: TextStyle(
                                    color: AppColors.mainColor,
                                    fontSize: Dimensions.font16,
                                    fontWeight: FontWeight.bold)),
                          ],
                        )),
                      ],
                    ),
                  )
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
