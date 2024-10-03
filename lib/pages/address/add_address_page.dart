import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_ecom_food_app/controllers/auth_controller.dart';
import 'package:flutter_ecom_food_app/controllers/location_controller.dart';
import 'package:flutter_ecom_food_app/controllers/user_controller.dart';
import 'package:flutter_ecom_food_app/data/repository/location_repo.dart';
import 'package:flutter_ecom_food_app/units/colors.dart';
import 'package:flutter_ecom_food_app/units/dimensions.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLogged = false;
  late bool _hasGoogleMapApi = false;
  CameraPosition _cameraPosition =
      const CameraPosition(target: LatLng(45.314141, -122.3242), zoom: 17);

  late LatLng _initialPosition = LatLng(45.314141, -122.3242);

  @override
  void initState() {
    super.initState();
    _isLogged = Get.find<AuthController>().userLoggedIn();
    if (_isLogged && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      _cameraPosition = CameraPosition(
          target: LatLng(
        double.parse(Get.find<LocationController>().getAddresses["latitude"]),
        double.parse(Get.find<LocationController>().getAddresses["langtitude"]),
      ));
      _initialPosition = LatLng(
        double.parse(Get.find<LocationController>().getAddresses["latitude"]),
        double.parse(Get.find<LocationController>().getAddresses["langtitude"]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Address"),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<LocationController>(builder: (locationController) {
        return Column(
          children: [
            Container(
              height: Dimensions.height100 * 1.5,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(
                  left: Dimensions.height10,
                  right: Dimensions.height10,
                  top: Dimensions.width10 / 2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20 / 4),
                  border: Border.all(
                      width: 2, color: Theme.of(context).primaryColor)),
              child: Stack(
                children: [
                  // Text(
                  //   "GoogleMap không khả dụng vì thiếu API key",
                  //   style: TextStyle(
                  //     color: Colors.red,
                  //     fontSize: Dimensions.font16,
                  //   ),
                  // ),
                  GoogleMap(
                    initialCameraPosition:
                        CameraPosition(target: _initialPosition, zoom: 17),
                    zoomControlsEnabled: false,
                    compassEnabled: false,
                    indoorViewEnabled: false,
                    mapToolbarEnabled: false,
                    onCameraIdle: () {
                      locationController.updatePosition(_cameraPosition, false);
                    },
                    onCameraMove: ((position) => _cameraPosition = position),
                    onMapCreated: (GoogleMapController controller) {
                      locationController.setMapController(controller);
                    },
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
