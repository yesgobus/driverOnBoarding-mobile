import 'package:driver_onboarding/widget/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/userDetailsController/user_detail_controller.dart';
import '../../../widget/buttons/button.dart';
import '../../../widget/tickWidget/tickWidget.dart';
import '../uploadWidget/upload_field.dart';

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({super.key});

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  UserDetailsController userDetailsController = Get.find();
  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HelperAppBar.appbarHelper(title: "Compliance", hideBack: true),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: uploadWidget(
                          title: "Permit Details",
                          onTap: (val) {
                           userDetailsController. permitImg = val;
                            setState(() {});
                          }),
                    ),
                    if (userDetailsController.permitImg != "") tickWidget()
                  ],
                ),

                // MyCustomTextField.textField(
                //     hintText: "Pending E-Challans",
                //     maxLine: 7,
                //     valText: "Enter Pending E-Challans",
                //     controller: userDetailsController.pendingChallansController),
                // sizedTextfield,
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14, bottom: 14, top: 8),
        child: AppButton.primaryButton(
            onButtonPressed: () {
              if (formkey.currentState!.validate()) {
                userDetailsController.complaintPost(context);
              }
            },
            title: "Next"),
      ),
    );
  }

}
