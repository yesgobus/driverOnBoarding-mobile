// ignore_for_file: prefer_const_constructors

import 'package:driver_onboarding/screen/landingScreen/landing_Screen.dart';
import 'package:driver_onboarding/utils/constant/app_var.dart';
import 'package:driver_onboarding/utils/constant/png_asset_constant.dart';
import 'package:driver_onboarding/utils/getStore/get_store.dart';
import 'package:driver_onboarding/utils/helper/helper.dart';
import 'package:driver_onboarding/widget/buttons/button.dart';
import 'package:driver_onboarding/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../utils/locationService/location_service.dart';
import '../homeScreen/home_screen.dart';

class PermissionLandingScreen extends StatefulWidget {
  const PermissionLandingScreen({super.key});

  @override
  State<PermissionLandingScreen> createState() =>
      _PermissionLandingScreenState();
}

class _PermissionLandingScreenState extends State<PermissionLandingScreen> {
  @override
  void initState() {
    print(GetStoreData.getStore.read('access_token'));
    _checkPermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              PngAssetPath.locationMapImg,
              height: 200,
            ),
            const TextWidget(
                text: "Please Turn On Your Location",
                textSize: 18,
                fontWeight: FontWeight.w500),
            sizedTextfield,
            const TextWidget(
              text:
                  "We need your location to provide accurate customer for ride based on where you are. This allows us to help finding nearest customer who request for driving. We respect your privacy and only use your location when necessary to enhance your experience. You can change your location settings at any time in your device’s settings",
              textSize: 13,
              maxLine: 10,
              align: TextAlign.center,
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(12),
        child: AppButton.primaryButton(
            borderRadius: 10,
            onButtonPressed: () async {
              if (_isPermissionGranted) {
                Helper.loader(context);
                try {
                  await getCurrentLocation();
                } finally {
                  Get.back();
                }
                Get.offAll(HomeScreen());
              } else {
                _checkPermissions();
              }
            },
            title:
                _isPermissionGranted == true ? "Continue" : "Yes , Turn It On"),
      ),
    );
  }

  bool _isPermissionGranted = false;

  Future<void> _checkPermissions() async {
    final status = await Permission.location.request();

    if (status.isGranted) {
      setState(() {
        _isPermissionGranted = true;
      });
    } else {
      setState(() {
        _isPermissionGranted = false;
      });

      if (status.isPermanentlyDenied) {
        // You can guide the user to settings to manually grant the permission
        openAppSettings();
      }
    }
  }
    //  PermissionStatus foregroundStatus =
    //     await Permission.locationWhenInUse.status;

    // if (foregroundStatus.isDenied ||
    //     foregroundStatus.isRestricted ||
    //     foregroundStatus.isPermanentlyDenied) {
    //   PermissionStatus newForegroundStatus =
    //       await Permission.locationWhenInUse.request();

    //   if (newForegroundStatus.isGranted) {
    //     _isPermissionGranted = true;
    //     setState(() {});
    //   } else if (newForegroundStatus.isPermanentlyDenied) {
    //     openAppSettings();
    //   }
    // } else if (foregroundStatus.isGranted) {
    //   _isPermissionGranted = true;
    //   setState(() {});
    // } else {
    //   openAppSettings();
    // }

  Future<void> _checkBackgroundPermission() async {
    PermissionStatus backgroundStatus = await Permission.locationAlways.status;

    if (backgroundStatus.isDenied ||
        backgroundStatus.isRestricted ||
        backgroundStatus.isPermanentlyDenied) {
      // Request background location permission
      PermissionStatus newBackgroundStatus =
          await Permission.locationAlways.request();

      if (newBackgroundStatus.isGranted) {
        setState(() {
          _isPermissionGranted = true;
        });
      } else {
        openAppSettings();
      }
    } else if (backgroundStatus.isGranted) {
      setState(() {
        _isPermissionGranted = true;
      });
    } else {
      openAppSettings();
    }
  }
}
