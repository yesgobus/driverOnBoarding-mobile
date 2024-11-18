import 'package:driver_onboarding/screen/APPLICATIONS/homeScreen/home_screen.dart';
import 'package:driver_onboarding/screen/ONBOARDING/loginScreens/login_page.dart';
import 'package:driver_onboarding/utils/appcolors/app_colors.dart';
import 'package:driver_onboarding/utils/constant/png_asset_constant.dart';
import 'package:driver_onboarding/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widget/buttons/button.dart';
import '../../APPLICATIONS/permmissionScreen/permission_screen.dart';
import '../backgroundVerificationScreens/background_verification.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({super.key});

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Center(
            child: Card(
          elevation: 8,
          color: AppColors.whiteColor,
          surfaceTintColor: AppColors.whiteColor,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const TextWidget(
                    text: "Confirmation",
                    textSize: 22,
                    fontWeight: FontWeight.w500),
                const SizedBox(height: 12),
                Image.asset(
                  PngAssetPath.verifyImg,
                  height: 180,
                ),
                const SizedBox(height: 12),
                const TextWidget(
                    text: "Your documents are under verification",
                    textSize: 16,
                    align: TextAlign.center,
                    maxLine: 2,
                    fontWeight: FontWeight.w500),
              ],
            ),
          ),
        )),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14, bottom: 14, top: 8),
        child: AppButton.primaryButton(
            onButtonPressed: () {
              Get.to(const PermissionLandingScreen());
              // Get.to(const BackgroundVerificationScreen());
            },
            title: "Next"),
      ),
    );
  }
}
