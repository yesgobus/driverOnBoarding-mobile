import 'dart:convert';
import 'dart:developer';

import 'package:driver_onboarding/controller/userDetailsController/user_detail_controller.dart';
import 'package:driver_onboarding/screen/ONBOARDING/driverProfileScreens/remedial_training_dilogue.dart';
import 'package:driver_onboarding/screen/ONBOARDING/multiAggregatorScreens/multi_aggregator_operation_screen.dart';
import 'package:driver_onboarding/screen/ONBOARDING/uploadWidget/upload_field.dart';
import 'package:driver_onboarding/utils/constant/app_var.dart';
import 'package:driver_onboarding/widget/appbar/appbar.dart';
import 'package:driver_onboarding/widget/buttons/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../widget/text_field/text_field.dart';

class DocumentationMgtScreen extends StatefulWidget {
  const DocumentationMgtScreen({super.key});

  @override
  State<DocumentationMgtScreen> createState() => _DocumentationMgtScreenState();
}

class _DocumentationMgtScreenState extends State<DocumentationMgtScreen> {
  UserDetailsController userDetailsController = Get.find();
  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HelperAppBar.appbarHelper(
          title: "Documentation Management", hideBack: true),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  uploadWidget(
                      title: "Documentation Management",
                      onTap: (val) {
                        //val = base64
                      }),
                  sizedTextfield,
                  uploadWidget(title: "Training Records", onTap: (val) {}),
                  sizedTextfield,
                  MyCustomTextField.textField(
                      maxLine: 7,
                      hintText: "Ratings and Feedback",
                      valText: "Enter Rating and Feedback",
                      controller: userDetailsController.rateReviewController),
                ],
              ),
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
                      if (formkey.currentState!.validate()) {
                        showTrainingPopup(
                            context: context,
                            onTap: () {
                              userDetailsController.docMgtDetailPost(context);
                            });
                      }
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