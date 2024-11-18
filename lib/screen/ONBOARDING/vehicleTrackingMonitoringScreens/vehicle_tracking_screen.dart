import 'package:driver_onboarding/widget/appbar/appbar.dart';
import 'package:driver_onboarding/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/userDetailsController/user_detail_controller.dart';
import '../../../widget/buttons/button.dart';

class VehicleTrackingScreen extends StatefulWidget {
  const VehicleTrackingScreen({super.key});

  @override
  State<VehicleTrackingScreen> createState() => _VehicleTrackingScreenState();
}

class _VehicleTrackingScreenState extends State<VehicleTrackingScreen> {
  UserDetailsController userDetailsController = Get.find();
  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HelperAppBar.appbarHelper(
          title: "Vehicle Tracking and Monitoring", hideBack: true),
      body: Form(
        key: formkey,
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: MyCustomTextField.textField(
              hintText: "AIS 140 Certified System Information",
              maxLine: 10,
              valText: "Enter AIS 140 Certified System Information",
              controller: userDetailsController.aisController),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14, bottom: 14, top: 8),
        child: AppButton.primaryButton(
            onButtonPressed: () {
              if (formkey.currentState!.validate()) {
                userDetailsController.vehicleTrackingPost(context);
              }
            },
            title: "Next"),
      ),
    );
  }
}
