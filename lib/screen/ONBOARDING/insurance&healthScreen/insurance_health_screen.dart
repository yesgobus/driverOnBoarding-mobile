import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/userDetailsController/user_detail_controller.dart';
import '../../../utils/constant/app_var.dart';
import '../../../widget/appbar/appbar.dart';
import '../../../widget/buttons/button.dart';
import '../../../widget/tickWidget/tickWidget.dart';
import '../multiAggregatorScreens/multi_aggregator_operation_screen.dart';
import '../uploadWidget/upload_field.dart';

class InsuranceHealthScreen extends StatefulWidget {
  const InsuranceHealthScreen({super.key});

  @override
  State<InsuranceHealthScreen> createState() => _InsuranceHealthScreenState();
}

class _InsuranceHealthScreenState extends State<InsuranceHealthScreen> {
  UserDetailsController userDetailsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HelperAppBar.appbarHelper(
          title: "Insurance and Health Coverage ", hideBack: true),
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
                          title: "Term Insurance Policy",
                          onTap: (val) {
                            userDetailsController.termInsuranceImg = val;
                            setState(() {});
                          }),
                    ),
                    if (userDetailsController.termInsuranceImg != "") tickWidget()
                  ],
                ),
                sizedTextfield,
                Row(
                  children: [
                    Expanded(
                      child: uploadWidget(
                          title: "Health Insurance Policy",
                          onTap: (val) {
                            userDetailsController.healthInsuranceImg = val;
                            setState(() {});
                          }),
                    ),
                    if (userDetailsController.healthInsuranceImg != "") tickWidget()
                  ],
                ),
                sizedTextfield,
                Row(
                  children: [
                    Expanded(
                      child: uploadWidget(
                          title: "Claims Processing",
                          onTap: (val) {
                            userDetailsController.claimsProcessingImg = val;
                            setState(() {});
                          }),
                    ),
                    if (userDetailsController.claimsProcessingImg != "") tickWidget()
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
              userDetailsController.insuranceHealthPost(context);
              // Get.to(const PersonalInfoEditScreen());
            },
            title: "Next"),
      ),
    );
  }
}
