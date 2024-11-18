import 'package:driver_onboarding/screen/ONBOARDING/driverOnboardingScreens/upload_document_screen.dart';
import 'package:driver_onboarding/utils/appcolors/app_colors.dart';
import 'package:driver_onboarding/utils/constant/app_var.dart';
import 'package:driver_onboarding/widget/appbar/appbar.dart';
import 'package:driver_onboarding/widget/buttons/button.dart';
import 'package:driver_onboarding/widget/datePicker/datePicker.dart';
import 'package:driver_onboarding/widget/text_field/text_field.dart';
import 'package:driver_onboarding/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/userDetailsController/user_detail_controller.dart';
import '../../../utils/helper/helper.dart';
import 'documentation_mgt_screen.dart';

class PersonalInfoEditScreen extends StatefulWidget {
  const PersonalInfoEditScreen({super.key});

  @override
  State<PersonalInfoEditScreen> createState() => _PersonalInfoEditScreenState();
}

class _PersonalInfoEditScreenState extends State<PersonalInfoEditScreen> {
  UserDetailsController userDetailsController =
      Get.put(UserDetailsController());
  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HelperAppBar.appbarHelper(
          title: "Personal Information", hideBack: true),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyCustomTextField.textField(
                      hintText: "First Name",
                      valText: "Enter First Name",
                      controller: userDetailsController.nameController),
                  sizedTextfield,
                  // MyCustomTextField.textField(
                  //     hintText: "Last Name",
                  //     valText: "Enter Last Name",
                  //     controller: userDetailsController.lastNameController),
                  // sizedTextfield,
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
                                  date: value.toString(), type: 'dd MMM, E');
                          userDetailsController.dobPost =
                              Helper.formatDatePost(value.toString());
                          setState(() {});
                        });
                      },
                      hintText: "DOB",
                      valText: "Enter DOB",
                      controller: userDetailsController.dobController,
                      suffixIcon: Icon(
                        Icons.calendar_month,
                        color: AppColors.black45,
                      )),
                  sizedTextfield,
                  MyCustomTextField.textField(
                      textInputType: TextInputType.phone,
                      valText: "Enter Mobile Number",
                      hintText: "Mobile Number",
                      controller: userDetailsController.mobileController),
                  sizedTextfield,
                  MyCustomTextField.textField(
                      hintText: "Address",
                      valText: "Enter Address",
                      controller: userDetailsController.addressController),
                  sizedTextfield,
                  MyCustomTextField.textField(
                      textInputType: TextInputType.phone,
                      hintText: "Pincode",
                      valText: "Enter Pincode",
                      controller: userDetailsController.pincodeController),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14, bottom: 14, top: 8),
        child: AppButton.primaryButton(
            onButtonPressed: () {
              if (formkey.currentState!.validate()) {
                Get.to(const DocumentationMgtScreen());
              }
            },
            title: "Next"),
      ),
    );
  }
}
