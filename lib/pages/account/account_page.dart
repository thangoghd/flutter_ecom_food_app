import 'package:flutter/material.dart';
import 'package:flutter_ecom_food_app/base/custom_loader.dart';
import 'package:flutter_ecom_food_app/controllers/auth_controller.dart';
import 'package:flutter_ecom_food_app/controllers/cart_controller.dart';
import 'package:flutter_ecom_food_app/controllers/user_controller.dart';
import 'package:flutter_ecom_food_app/routes/route_helper.dart';
import 'package:flutter_ecom_food_app/units/colors.dart';
import 'package:flutter_ecom_food_app/units/dimensions.dart';
import 'package:flutter_ecom_food_app/widgets/account_bar.dart';
import 'package:flutter_ecom_food_app/widgets/app_icon.dart';
import 'package:flutter_ecom_food_app/widgets/big_text.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
      appBar: AppBar(
        title: BigText(text: "Profile", color: Colors.white),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<UserController>(builder: (userController) {
        return _userLoggedIn
            ? (userController.isLoading
                ? Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(top: Dimensions.height20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          AppIcon(
                              icon: Icons.person,
                              iconColor: Colors.white,
                              backgroundColor: AppColors.mainColor,
                              iconSize: Dimensions.height20 * 5,
                              size: Dimensions.height15 * 10),
                          SizedBox(
                            height: Dimensions.height20,
                          ),
                          AccountBar(
                            appIcon: AppIcon(
                                icon: Icons.person,
                                iconColor: Colors.white,
                                backgroundColor: AppColors.mainColor,
                                iconSize: Dimensions.height30,
                                size: Dimensions.height45),
                            bigText: BigText(
                              text: userController.userModel.name,
                              color: Colors.black,
                              size: Dimensions.font20,
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.height20,
                          ),
                          AccountBar(
                            appIcon: AppIcon(
                                icon: Icons.phone,
                                iconColor: Colors.white,
                                backgroundColor: Colors.yellow,
                                iconSize: Dimensions.height30,
                                size: Dimensions.height45),
                            bigText: BigText(
                              text: userController.userModel.phone,
                              color: Colors.black,
                              size: Dimensions.font20,
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.height20,
                          ),
                          AccountBar(
                            appIcon: AppIcon(
                                icon: Icons.email,
                                iconColor: Colors.white,
                                backgroundColor: Colors.red,
                                iconSize: Dimensions.height30,
                                size: Dimensions.height45),
                            bigText: BigText(
                              text: userController.userModel.email,
                              color: Colors.black,
                              size: Dimensions.font20,
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.height20,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (Get.find<AuthController>().userLoggedIn()) {
                                Get.toNamed(RouteHelper.getAddAddressPage());
                              }
                            },
                            child: AccountBar(
                              appIcon: AppIcon(
                                  icon: Icons.location_on,
                                  iconColor: Colors.white,
                                  backgroundColor: Colors.blue,
                                  iconSize: Dimensions.height30,
                                  size: Dimensions.height45),
                              bigText: BigText(
                                text: "My Addresses",
                                color: Colors.black,
                                size: Dimensions.font20,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Dimensions.height20,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (Get.find<AuthController>().userLoggedIn()) {
                                Get.dialog(
                                  AlertDialog(
                                    title: const Text('Confirm logout'),
                                    content: const Text(
                                        'Are you sure you want to logout?'),
                                    actions: [
                                      TextButton(
                                        child: const Text('No'),
                                        onPressed: () => Get.back(),
                                      ),
                                      TextButton(
                                        child: const Text('Yes'),
                                        onPressed: () {
                                          Get.back();
                                          Get.find<AuthController>().logout();
                                          Get.find<CartController>().clear();
                                          Get.find<CartController>()
                                              .clearCartHistory();
                                          Get.offAllNamed(
                                              RouteHelper.getInitial());
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            child: AccountBar(
                              appIcon: AppIcon(
                                  icon: Icons.logout,
                                  iconColor: Colors.white,
                                  backgroundColor: AppColors.mainColor,
                                  iconSize: Dimensions.height30,
                                  size: Dimensions.height45),
                              bigText: BigText(
                                text: "Logout",
                                color: Colors.black,
                                size: Dimensions.font20,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : const Center(child: CustomLoader()))
            : const Center(
                child: Text('User not logged in'),
              );
      }),
    );
  }
}
