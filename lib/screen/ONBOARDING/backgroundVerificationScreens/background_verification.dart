import 'package:driver_onboarding/controller/userDetailsController/user_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constant/app_var.dart';
import '../../../widget/appbar/appbar.dart';
import '../../../widget/buttons/button.dart';
import '../../../widget/tickWidget/tickWidget.dart';
import '../training&programingScreens/training_program_screen.dart';
import '../uploadWidget/upload_field.dart';

class BackgroundVerificationScreen extends StatefulWidget {
  const BackgroundVerificationScreen({super.key});

  @override
  State<BackgroundVerificationScreen> createState() =>
      _BackgroundVerificationScreenState();
}

class _BackgroundVerificationScreenState
    extends State<BackgroundVerificationScreen> {
  UserDetailsController userDetailsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HelperAppBar.appbarHelper(
          title: "Background Verification", hideBack: true),
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
                          title: "Police  Verification ",
                          onTap: (val) {
                            userDetailsController.policeVerificationImg = val;
                            setState(() {});
                          }),
                    ),
                    if (userDetailsController.policeVerificationImg != "")
                      tickWidget()
                  ],
                ),
                sizedTextfield,
                Row(
                  children: [
                    Expanded(
                      child: uploadWidget(
                          title: "Medical Examination",
                          onTap: (val) {
                            userDetailsController.medicalExamImg = val;
                            setState(() {});
                          }),
                    ),
                    if (userDetailsController.medicalExamImg != "") tickWidget()
                  ],
                ),
                sizedTextfield,
                Row(
                  children: [
                    Expanded(
                      child: uploadWidget(
                          title: "Criminal Records",
                          onTap: (val) {
                            userDetailsController.criminalRecordImg = val;
                            setState(() {});
                          }),
                    ),
                    if (userDetailsController.criminalRecordImg != "")
                      tickWidget()
                  ],
                ),
                sizedTextfield,
                Row(
                  children: [
                    Expanded(
                      child: uploadWidget(
                          title: "Certificate Issuance",
                          onTap: (val) {
                            userDetailsController.certificateInsuranceImg = val;
                            setState(() {});
                          }),
                    ),
                    if (userDetailsController.certificateInsuranceImg != "")
                      tickWidget()
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14, bottom: 14, top: 8),
        child: AppButton.primaryButton(
            onButtonPressed: () {
              userDetailsController.bgVerificationDetailPost(context);
            },
            title: "Next"),
      ),
    );
  }
}
