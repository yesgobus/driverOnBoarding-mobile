import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/userDetailsController/user_detail_controller.dart';
import '../../../utils/constant/app_var.dart';
import '../../../widget/appbar/appbar.dart';
import '../../../widget/buttons/button.dart';
import '../../../widget/tickWidget/tickWidget.dart';
import '../insurance&healthScreen/insurance_health_screen.dart';
import '../uploadWidget/upload_field.dart';

class TrainingNprogramingScreen extends StatefulWidget {
  const TrainingNprogramingScreen({super.key});

  @override
  State<TrainingNprogramingScreen> createState() =>
      _TrainingNprogramingScreenState();
}

class _TrainingNprogramingScreenState extends State<TrainingNprogramingScreen> {
  UserDetailsController userDetailsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          HelperAppBar.appbarHelper(title: "Training Program ", hideBack: true),
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
                          title: "Induction Training",
                          onTap: (val) {
                            userDetailsController.inductionTrainingImg = val;
                            setState(() {});
                          }),
                    ),
                    if (userDetailsController.inductionTrainingImg != "") tickWidget()
                  ],
                ),
                sizedTextfield,
                Row(
                  children: [
                    Expanded(
                      child: uploadWidget(
                          title: "Refresher Training",
                          onTap: (val) {
                            userDetailsController.refresherTrainingImg = val;
                            setState(() {});
                          }),
                    ),
                    if (userDetailsController.refresherTrainingImg != "") tickWidget()
                  ],
                ),
                sizedTextfield,
                Row(
                  children: [
                    Expanded(
                      child: uploadWidget(
                          title: "Training Session",
                          onTap: (val) {
                            userDetailsController.trainingSessionImg = val;
                            setState(() {});
                          }),
                    ),
                    if (userDetailsController.trainingSessionImg != "") tickWidget()
                  ],
                ),
                sizedTextfield,
                Row(
                  children: [
                    Expanded(
                      child: uploadWidget(
                          title: "Training Records",
                          onTap: (val) {
                            userDetailsController.trainingRecordsImg = val;
                            setState(() {});
                          }),
                    ),
                    if (userDetailsController.trainingRecordsImg != "") tickWidget()
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
              userDetailsController.trainingProgramePost(context);
            },
            title: "Next"),
      ),
    );
  }
}
