import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/appcolors/app_colors.dart';
import '../../../widget/textwidget/text_widget.dart';
import 'uploaad_dilogue.dart';

Widget uploadWidget({required String title, required Function(String base64) onTap}) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: AppColors.blackColor.withOpacity(0.7), width: 1.5)),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: TextWidget(text: title,maxLine: 2, fontWeight: FontWeight.w500, textSize: 14)),
        SizedBox(width: 8),
        InkWell(
          onTap: () {
            showUploadPopup(
                context: Get.context!,
                onTap: (val) {
                  onTap(val);

                  Get.back();
                },
                title: title);
          },
          child: Card(
            margin: EdgeInsets.zero,
            color: AppColors.primaryColor,
            surfaceTintColor: AppColors.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextWidget(
                text: "Upload",
                textSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.whiteColor,
              ),
            ),
          ),
        )
      ],
    ),
  );
}
