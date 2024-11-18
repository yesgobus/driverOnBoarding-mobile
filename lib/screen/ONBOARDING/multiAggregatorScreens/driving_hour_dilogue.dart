import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:driver_onboarding/controller/userDetailsController/user_detail_controller.dart';
import 'package:driver_onboarding/utils/constant/png_asset_constant.dart';
import 'package:driver_onboarding/widget/buttons/button.dart';
import 'package:driver_onboarding/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import '../../../utils/appcolors/app_colors.dart';
import '../../../widget/textwidget/text_widget.dart';

Future showDrivingHourPopup({
  required BuildContext context,
  required Function() onTap,
}) async {
  UserDetailsController userDetailsController = Get.find();
  GlobalKey<FormState> formkey = GlobalKey();

  return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: AppColors.whiteColor,
            shadowColor: AppColors.whiteColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            contentPadding: const EdgeInsets.all(12),
            content: Form(
              key: formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  TextWidget(
                    text: "Driving Hour Limitations ",
                    textSize: 16,
                    align: TextAlign.center,
                    color: AppColors.blackColor,
                    maxLine: 2,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Image.asset(PngAssetPath.drivingHrsImg, height: 100),
                  const SizedBox(
                    height: 12,
                  ),
                  MyCustomTextField.textField(
                      hintText: "Per day driving limitations",
                      valText: "Enter Limitation",readonly: true,
                      controller: userDetailsController.perDayLimitController),
                  const SizedBox(
                    height: 8,
                  ),
                  MyCustomTextField.textField(
                      hintText: "How many hour’s you want to drive",textInputType: TextInputType.number,
                      valText: "Enter Hours",
                      controller: userDetailsController.howManyHoursController),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: AppButton.outlineButton(
                              height: 35,
                              onButtonPressed: () {
                                Get.back();
                              },
                              title: "Back")),
                      SizedBox(width: 12),
                      Expanded(
                          child: AppButton.primaryButton(
                              height: 35,
                              onButtonPressed: () {
                                if (formkey.currentState!.validate()) {
                                  onTap();
                                }
                              },
                              title: "Next")),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ));
}
