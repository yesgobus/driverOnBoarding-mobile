import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:driver_onboarding/utils/constant/png_asset_constant.dart';
import 'package:driver_onboarding/widget/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import '../../../utils/appcolors/app_colors.dart';
import '../../../widget/textwidget/text_widget.dart';

Future showDrivingWarningPopup({
  required BuildContext context,
  required Function() onTap,
}) async {
  return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: AppColors.whiteColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            contentPadding: const EdgeInsets.all(12),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 12,
                ),
                TextWidget(
                  text: "Cumulative Driving\nPeriod Warning ",
                  textSize: 16,
                  align: TextAlign.center,
                  color: AppColors.blackColor,
                  maxLine: 2,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(
                  height: 8,
                ),
                Image.asset(PngAssetPath.warningImg, height: 100),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38),
                      borderRadius: BorderRadius.circular(12)),
                  child:  TextWidget(
                    text:
                        "1. Lorem ipsum dolor sit amet consectetur. Lacus nisi faucibus nunc ac. Eu aliquam non sem pharetra quam mauris pulvinar. Eu purus lorem quam tempor pharetra risus vel nunc praesent. Ac blandit rhoncus massa quis.i.",
                    textSize: 12,color: AppColors.redColor,
                    maxLine: 10,
                  ),
                ),
                 const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: 100,
                  child: AppButton.primaryButton(
                      height: 35, onButtonPressed: onTap, title: "Next"),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ));
}