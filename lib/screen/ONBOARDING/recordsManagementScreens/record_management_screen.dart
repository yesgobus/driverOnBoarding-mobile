import 'dart:convert';
import 'dart:developer';

import 'package:driver_onboarding/screen/ONBOARDING/contactUsScreen/contact_us_screen.dart';
import 'package:driver_onboarding/screen/ONBOARDING/recordsManagementScreens/records_archive_dilogue.dart';
import 'package:driver_onboarding/screen/ONBOARDING/uploadWidget/upload_field.dart';
import 'package:driver_onboarding/utils/constant/app_var.dart';
import 'package:driver_onboarding/widget/appbar/appbar.dart';
import 'package:driver_onboarding/widget/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../controller/userDetailsController/user_detail_controller.dart';
import '../../../widget/tickWidget/tickWidget.dart';

class RecordsManagementScreen extends StatefulWidget {
  const RecordsManagementScreen({super.key});

  @override
  State<RecordsManagementScreen> createState() =>
      _RecordsManagementScreenState();
}

class _RecordsManagementScreenState extends State<RecordsManagementScreen> {
  UserDetailsController userDetailsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HelperAppBar.appbarHelper(
          title: "Records Management", hideBack: true),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: uploadWidget(
                    title:
                        "Document Upload Section (for vehicle-related records)",
                    onTap: (val) {
                      userDetailsController.docUploadSessionImg = val;
                      setState(() {});
                    }),  ),
                    if (userDetailsController.docUploadSessionImg != "") tickWidget()
                  ],
                ),
                sizedTextfield,
               Row(
                  children: [
                    Expanded(
                      child:  uploadWidget(
                    title: "License",
                    onTap: (val) {
                      userDetailsController.licenseImg = val;
                      setState(() {});
                    }),  ),
                    if (userDetailsController.licenseImg != "") tickWidget()
                  ],
                ),
                // sizedTextfield,
                // uploadWidget(title: "Real-Time Updates", onTap: (val) {}),
                // sizedTextfield,
                // uploadWidget(title: "Compliance Status", onTap: (val) {}),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14, bottom: 14, top: 8),
        child: AppButton.primaryButton(
            onButtonPressed: () {
              showRecordArchivePopup(
                  context: context,
                  onTap: () {
                    userDetailsController.recordsMngtPost(context);
                    
                  });
            },
            title: "Next"),
      ),
    );
  }
}
 // Image.memory(
 //   base64Decode(img),
 //   height: 100,
 // ),