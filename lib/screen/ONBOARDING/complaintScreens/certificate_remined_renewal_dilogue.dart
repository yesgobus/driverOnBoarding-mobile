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

Future showCertificateRenewRemindPopup({
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
                  text: "Fitness Certificate Renewal Reminder",
                  textSize: 16,
                  align: TextAlign.center,
                  color: AppColors.blackColor,
                  maxLine: 2,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(
                  height: 8,
                ),
                Image.asset(PngAssetPath.reminderImg, height: 100),
               
                 const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: 150,
                  child: AppButton.primaryButton(
                      height: 40, onButtonPressed: onTap, title: "Renewal now"),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ));
}
