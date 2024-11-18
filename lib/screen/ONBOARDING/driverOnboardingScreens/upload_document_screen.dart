
import 'package:driver_onboarding/screen/ONBOARDING/uploadWidget/upload_field.dart';
import 'package:driver_onboarding/utils/constant/app_var.dart';
import 'package:driver_onboarding/widget/appbar/appbar.dart';
import 'package:driver_onboarding/widget/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/userDetailsController/user_detail_controller.dart';
import '../../../widget/tickWidget/tickWidget.dart';

class UploadDocumentScreen extends StatefulWidget {
  const UploadDocumentScreen({super.key});

  @override
  State<UploadDocumentScreen> createState() => _UploadDocumentScreenState();
}

class _UploadDocumentScreenState extends State<UploadDocumentScreen> {
  UserDetailsController userDetailsController =
      Get.put(UserDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          HelperAppBar.appbarHelper(title: "Upload Documents", hideBack: true),
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
                          title: "Driver’s License",
                          onTap: (val) {
                            userDetailsController.dlImg = val;
                            // userDetailsController.imgPost(context,
                            //     kkey: 'dl_img', val: val);
                            setState(() {});
                          }),
                    ),
                    if (userDetailsController.dlImg != "") tickWidget()
                  ],
                ),
                sizedTextfield,
                Row(
                  children: [
                    Expanded(
                      child: uploadWidget(
                          title: "Vehicle Registration",
                          onTap: (val) {
                            userDetailsController.vehicleRegImg = val;
                            setState(() {});
                          }),
                    ),
                    if (userDetailsController.vehicleRegImg != "") tickWidget()
                  ],
                ),
                sizedTextfield,
                Row(
                  children: [
                    Expanded(
                      child: uploadWidget(
                          title: "Aadhar Image",
                          onTap: (val) {
                            userDetailsController.aadharImg = val;
                            setState(() {});
                          }),
                    ),
                    if (userDetailsController.aadharImg != "") tickWidget()
                  ],
                ),
                sizedTextfield,
                Row(
                  children: [
                    Expanded(
                      child: uploadWidget(
                          title: "Vehicle Image",
                          onTap: (val) {
                            userDetailsController.vehicleImg = val;
                            setState(() {});
                          }),
                    ),
                    if (userDetailsController.vehicleImg != "") tickWidget()
                  ],
                ),
                sizedTextfield,
                Row(
                  children: [
                    Expanded(
                      child: uploadWidget(
                          title: "Profile Image",
                          onTap: (val) {
                            userDetailsController.profileImg = val;
                            setState(() {});
                          }),
                    ),
                    if (userDetailsController.profileImg != "") tickWidget()
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14, bottom: 14, top: 8),
        child: Row(
          children: [
            Expanded(
                child: AppButton.outlineButton(
                    onButtonPressed: () {
                      Get.back();
                    },
                    title: "Back")),
            const SizedBox(width: 14),
            Expanded(
                child: AppButton.primaryButton(
                    onButtonPressed: () {
                      userDetailsController.userDetailPost(context);
                    },
                    title: "Next")),
          ],
        ),
      ),
    );
  }
}


// Image.memory(
//   base64Decode(img),
//   height: 100,
// ),
