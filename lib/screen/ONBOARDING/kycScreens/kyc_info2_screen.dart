import 'package:driver_onboarding/screen/ONBOARDING/kycScreens/complete_kyc_screen.dart';
import 'package:driver_onboarding/utils/appcolors/app_colors.dart';
import 'package:driver_onboarding/utils/constant/png_asset_constant.dart';
import 'package:driver_onboarding/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widget/buttons/button.dart';

class KYCInfo2Screen extends StatefulWidget {
  const KYCInfo2Screen({super.key});

  @override
  State<KYCInfo2Screen> createState() => _KYCInfo2ScreenState();
}

class _KYCInfo2ScreenState extends State<KYCInfo2Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppColors.whiteColor,
      appBar: AppBar(backgroundColor: AppColors.whiteColor,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              PngAssetPath.docImg,
            ),
            SizedBox(height: 12),
            TextWidget(text: "Submit the documentation and\ncomplete your KYC",align: TextAlign.center, color: AppColors.black65, textSize: 16)
          ],
        ),
      ),
      bottomNavigationBar:  Padding(
        padding: const EdgeInsets.only(left: 14, right: 14, bottom: 14, top: 8),
        child: AppButton.primaryButton(
            onButtonPressed: () {
              Get.to(const CompleteKYCScreen());
            },
            title: "Next"),
      ),
    );
  }
}
