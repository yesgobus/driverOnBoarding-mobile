import 'package:driver_onboarding/screen/ONBOARDING/driverOnboardingScreens/upload_document_screen.dart';
import 'package:driver_onboarding/utils/constant/app_var.dart';
import 'package:driver_onboarding/utils/helper/helper.dart';
import 'package:driver_onboarding/utils/helper/helper_sncksbar.dart';
import 'package:driver_onboarding/widget/appbar/appbar.dart';
import 'package:driver_onboarding/widget/buttons/button.dart';
import 'package:driver_onboarding/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/userDetailsController/user_detail_controller.dart';
import '../../../widget/dropdownWidget/drop_down_widget.dart';

class DrivingExpScreen extends StatefulWidget {
  const DrivingExpScreen({super.key});

  @override
  State<DrivingExpScreen> createState() => _DrivingExpScreenState();
}

class _DrivingExpScreenState extends State<DrivingExpScreen> {
  UserDetailsController userDetailsController = Get.find();
  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HelperAppBar.appbarHelper(
            title: "Vehicle Information", hideBack: true),
        body: Obx(() => userDetailsController.isLoading2.value
            ? Helper.pageLoading()
            : SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyCustomTextField.textField(
                              hintText: "How many Year’s of Experience",
                              textInputType: TextInputType.phone,
                              valText: "Enter Total Year Of Experience",
                              controller:
                                  userDetailsController.yearExpController),
                          sizedTextfield,
                          DropDownWidget(
                              status: userDetailsController.vehicleCategory ??
                                  "Vehicle Category",
                              circleVal: 6,
                              statusList: userDetailsController.vehicleCatName,
                              onChanged: (val) {
                                userDetailsController.vehicleCategory = val;
                                for (var i = 0;
                                    i <
                                        userDetailsController
                                            .vehicleCatName.length;
                                    i++) {
                                  if (userDetailsController.vehicleCatName[i] ==
                                      val) {
                                    userDetailsController.vehicleCategoryID =
                                        userDetailsController.vehicleCatId[i];
                                  }
                                }
                                setState(() {});
                              }),
                          sizedTextfield,
                          // MyCustomTextField.textField(
                          //     hintText: "Vehicle Category",
                          //     valText: "Enter Vehicle Category",
                          //     controller:
                          //         userDetailsController.vehicleCategoryController),
                          // sizedTextfield,
                          MyCustomTextField.textField(
                              hintText: "Vehicle Model",
                              valText: "Enter Vehicle Model",
                              controller:
                                  userDetailsController.vehicleModelController),
                          sizedTextfield,
                          MyCustomTextField.textField(
                              hintText: "Vehicle Number",
                              valText: "Enter Vehicle Number",
                              controller: userDetailsController
                                  .vehicleNumberController),
                          sizedTextfield,
                          MyCustomTextField.textField(
                              hintText: "Vehicle Registration Year",
                              valText: "Enter Vehicle Reg. Year",
                              textInputType: TextInputType.number,
                              controller:
                                  userDetailsController.yearOfRegController),
                          sizedTextfield,
                        ],
                      ),
                    ),
                  ),
                ),
              )),
        bottomNavigationBar: Padding(
          padding:
              const EdgeInsets.only(left: 14, right: 14, bottom: 14, top: 8),
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
                          // showtrainingProgramePopup(
                          //     context: context,
                          //     onTap: () {
                          //       userDetailsController.userDetailPost(context);
                          //     });
                          if (userDetailsController.vehicleCategory != null) {
                            Get.to(const UploadDocumentScreen());
                          } else {
                            HelperSnackBar.snackBar(
                                "Error", "Please Choose Vehicle Category");
                          }
                        }
                      },
                      title: "Next")),
            ],
          ),
        ));
  }
}
