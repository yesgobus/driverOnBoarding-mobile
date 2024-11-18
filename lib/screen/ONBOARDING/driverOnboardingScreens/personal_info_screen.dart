import 'package:driver_onboarding/controller/kycController/myKYC_controller.dart';
import 'package:driver_onboarding/controller/userDetailsController/user_detail_controller.dart';
import 'package:driver_onboarding/screen/ONBOARDING/driverOnboardingScreens/upload_document_screen.dart';
import 'package:driver_onboarding/utils/appcolors/app_colors.dart';
import 'package:driver_onboarding/utils/constant/app_var.dart';
import 'package:driver_onboarding/utils/helper/helper_sncksbar.dart';
import 'package:driver_onboarding/widget/appbar/appbar.dart';
import 'package:driver_onboarding/widget/buttons/button.dart';
import 'package:driver_onboarding/widget/datePicker/datePicker.dart';
import 'package:driver_onboarding/widget/dropdownWidget/drop_down_widget.dart';
import 'package:driver_onboarding/widget/text_field/text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/helper/helper.dart';
import 'driving_exp_screen.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  UserDetailsController userDetailsController =
      Get.put(UserDetailsController());
  MyKYCController kycController = Get.put(MyKYCController());
  GlobalKey<FormState> formkey = GlobalKey();
  @override
  void initState() {
    userDetailsController.nameController.text =
        kycController.nameController.text;
    userDetailsController.emailController.text =
        kycController.emailController.text;
    userDetailsController.mobileController.text =
        kycController.mobileController.text;
    userDetailsController.getUserType();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HelperAppBar.appbarHelper(
          title: "Personal Information", hideBack: true),
      body: Obx(() => userDetailsController.isLoading.value
          ? Helper.pageLoading()
          : SingleChildScrollView(
              child: Form(
                key: formkey,
                child: SafeArea(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropDownWidget(
                            status: userDetailsController.registerAs ??
                                "Register As",
                            circleVal: 6,
                            statusList: userDetailsController.userTypeName,
                            onChanged: (val) {
                              userDetailsController.registerAs = val;
                              for (var i = 0;
                                  i < userDetailsController.userTypeName.length;
                                  i++) {
                                if (userDetailsController.userTypeName[i] ==
                                    val) {
                                  userDetailsController.registerAsID =
                                      userDetailsController.userTypeId[i];
                                  userDetailsController.getVehicleCat(
                                      userDetailsController.registerAsID);
                                }
                              }

                              setState(() {});
                            }),
                        sizedTextfield,
                        MyCustomTextField.textField(
                            hintText: "Full Name",
                            valText: "Enter Full Name",
                            controller: userDetailsController.nameController),
                        // sizedTextfield,
                        // MyCustomTextField.textField(
                        //     hintText: "Last Name",
                        //     valText: "Enter Last Name",
                        //     controller: userDetailsController.lastNameController),
                        sizedTextfield,
                        MyCustomTextField.textField(
                            hintText: "Email",
                            valText: "Enter Email",
                            controller: userDetailsController.emailController),
                        sizedTextfield,
                        MyCustomTextField.textField(
                            readonly: true,
                            onTap: () {
                              selectDate(context, DateTime.now()).then((value) {
                                userDetailsController.dobController.text =
                                    Helper.formatDate(
                                        date: value.toString(),
                                        type: 'dd MMM, E');
                                userDetailsController.dobPost =
                                    Helper.formatDatePost(value.toString());
                                setState(() {});
                              });
                            },
                            hintText: "DOB",
                            controller: userDetailsController.dobController,
                            valText: "Enter DOB",
                            suffixIcon: Icon(
                              Icons.calendar_month,
                              color: AppColors.black45,
                            )),
                        sizedTextfield,
                        MyCustomTextField.textField(
                            textInputType: TextInputType.phone,
                            hintText: "Mobile Number",
                            valText: "Enter Mobile Number",
                            controller: userDetailsController.mobileController),
                        sizedTextfield,
                        MyCustomTextField.textField(
                            textInputType: TextInputType.phone,
                            hintText: "Alternate Mobile Number",
                            valText: "Enter Alternate Mobile Number",
                            controller: userDetailsController
                                .alternateMobileController),
                        sizedTextfield,
                        MyCustomTextField.textField(
                            hintText: "Blood Group",
                            valText: "Enter Blood Group",
                            controller:
                                userDetailsController.bloodGroupController),
                        sizedTextfield,
                        MyCustomTextField.textField(
                            hintText: "Address",
                            valText: "Enter Address",
                            controller:
                                userDetailsController.addressController),
                        sizedTextfield,
                        MyCustomTextField.textField(
                            textInputType: TextInputType.phone,
                            hintText: "Pincode",
                            valText: "Enter Pincode",
                            controller:
                                userDetailsController.pincodeController),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14, bottom: 14, top: 8),
        child: AppButton.primaryButton(
            onButtonPressed: () {
              if (formkey.currentState!.validate()) {
                if (userDetailsController.registerAs != null) {
                  Get.to(const DrivingExpScreen());
                } else {
                  HelperSnackBar.snackBar(
                      "Error", "Please choose register as categories");
                }
              }
            },
            title: "Next"),
      ),
    );
  }
}
