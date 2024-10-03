import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecom_food_app/base/no_data_page.dart';
import 'package:flutter_ecom_food_app/controllers/cart_controller.dart';
import 'package:flutter_ecom_food_app/models/cart_model.dart';
import 'package:flutter_ecom_food_app/routes/route_helper.dart';
import 'package:flutter_ecom_food_app/units/app_constants.dart';
import 'package:flutter_ecom_food_app/units/colors.dart';
import 'package:flutter_ecom_food_app/units/dimensions.dart';
import 'package:flutter_ecom_food_app/widgets/app_icon.dart';
import 'package:flutter_ecom_food_app/widgets/big_text.dart';
import 'package:flutter_ecom_food_app/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({super.key});

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsPerOrder = Map();
    for(int i = 0; i < getCartHistoryList.length; i++)
    {
      if(cartItemsPerOrder.containsKey(getCartHistoryList[i].time))
      {
        cartItemsPerOrder.update(getCartHistoryList[i].time!, (value) => ++value);
      }
      else cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
    }

    List<int> cartItemsPerOrderToList(){
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartPerOrderTimeToList(){
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List itemsPerOrder = cartItemsPerOrderToList();
    print(itemsPerOrder);
    var listCounter = 0;
    Widget timeWidget(int index)
    {
      var outputDate = DateTime.now().toString();
      if(index < getCartHistoryList.length){
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFomat = DateFormat("HH:mm a dd-MM-yyyy");
        outputDate = outputFomat.format(inputDate);
      }
      return Text(outputDate);

    }
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Dimensions.height50 * 2,
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimensions.height45, left: Dimensions.width10, right: Dimensions.width10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BigText(text: "Check out's History", color: Colors.white,),
                AppIcon(icon: Icons.shopping_cart_outlined, iconColor: AppColors.mainColor,)
            ],),
          ),
          GetBuilder<CartController>(builder: (cartController) {
            return cartController.getCartHistoryList().isNotEmpty ? Expanded(
            child: Container(
              margin: EdgeInsets.only(top: Dimensions.height20, left: Dimensions.height20, right: Dimensions.height20),
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView(
                  children: [
                    for(int i = 0; i < itemsPerOrder.length; i++)
                      Container(
                        margin: EdgeInsets.only(bottom: Dimensions.height20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          timeWidget(listCounter),
                            SizedBox(height: Dimensions.height10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Wrap(
                                  direction: Axis.horizontal,
                                  children: List.generate(itemsPerOrder[i], (index){
                                    if(listCounter < getCartHistoryList.length)
                                    {
                                      listCounter++;
                                    }
                                    return index <= 1 ? Container(
                                      height: Dimensions.height100,
                                      width: Dimensions.height100,
                                      margin: EdgeInsets.only(right: Dimensions.width10 / 2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(Dimensions.radius15 / 2),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(AppConstants.BASE_URL+AppConstants.UPLOAD_URL+getCartHistoryList[listCounter - 1].img!)
                                        ),
                                      )
                                    ) : Container();
                                  }
                                  )
                                ),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SmallText(text: "Total"),
                                      BigText(text: itemsPerOrder[i].toString() + " items", color: AppColors.titleColor,),
                                      GestureDetector(
                                        onTap: () {
                                          var orderTime = cartPerOrderTimeToList();
                                          Map<int, CartModel> moreOrder = {};
                                          for(int j = 0; j < getCartHistoryList.length; j++)
                                          {
                                            if(getCartHistoryList[j].time == orderTime[i])
                                            {
                                              moreOrder.putIfAbsent(getCartHistoryList[j].id!, () => 
                                              CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j]))));
                                            }
                                          }
                                          Get.find<CartController>().setItems = moreOrder;
                                          Get.find<CartController>().addToCartList();
                                          Get.toNamed(RouteHelper.getCartPage());
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: Dimensions.height10, vertical: Dimensions.height10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(Dimensions.radius15 / 3),
                                            border: Border.all(width: 1, color: AppColors.mainColor),
                                          ),
                                          child: SmallText(text: "One more", color: AppColors.mainColor,),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )  
                  ],
                ),
              ),
            ),
          ) : Container(
            height: MediaQuery.of(context).size.height / 1.5,
            child: const Center(
              child: NoDataPage(text: "There is no bill history", imgPath: "assets/images/not_found/empty_box.png"),
            )
          );
          }),
        ],
      ),
    );
  }
}