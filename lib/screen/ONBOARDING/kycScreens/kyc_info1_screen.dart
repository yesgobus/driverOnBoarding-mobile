
import 'package:driver_onboarding/utils/appcolors/app_colors.dart';
import 'package:driver_onboarding/utils/constant/png_asset_constant.dart';
import 'package:driver_onboarding/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widget/buttons/button.dart';
import 'kyc_info2_screen.dart';

class KYCInfo1Screen extends StatefulWidget {
  const KYCInfo1Screen({super.key});

  @override
  State<KYCInfo1Screen> createState() => _KYCInfo1ScreenState();
}

class _KYCInfo1ScreenState extends State<KYCInfo1Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              PngAssetPath.kycImg,
            ),
            SizedBox(height: 12),
            TextWidget(
                text: "Easy way to complete the\nKYC",
                align: TextAlign.center,
                color: AppColors.black65,
                textSize: 16)
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14, bottom: 14, top: 8),
        child: AppButton.primaryButton(
            onButtonPressed: () {
              Get.to(const KYCInfo2Screen());
            },
            title: "Next"),
      ),
    );
  }
}
