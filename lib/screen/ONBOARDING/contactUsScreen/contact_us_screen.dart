import 'package:driver_onboarding/utils/appcolors/app_colors.dart';
import 'package:driver_onboarding/widget/appbar/appbar.dart';
import 'package:driver_onboarding/widget/buttons/button.dart';
import 'package:driver_onboarding/widget/textwidget/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/helper/helper.dart';
import 'faqs_screen.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HelperAppBar.appbarHelper(
          title: "Contact Information", hideBack: true),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1.5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.black45,
                    radius: 25,
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: AppColors.whiteColor,
                      child: const Icon(CupertinoIcons.phone),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const TextWidget(
                      text: "Customer Support",
                      fontWeight: FontWeight.bold,
                      textSize: 22),
                  const SizedBox(height: 8),
                  TextWidget(
                      text: "+91 6363574938",
                      textSize: 14,
                      color: AppColors.redColor),
                  const SizedBox(height: 12),
                  const TextWidget(
                      text:
                          "You may call us between Monday to Friday 9:00 am to 5:30 pm from your registered mobile number.",
                      textSize: 14,
                      maxLine: 5),
                  const SizedBox(height: 16),
                  SizedBox(
                      width: 140,
                      height: 45,
                      child: AppButton.outlineButton(
                          borderColor: AppColors.black45,
                          onButtonPressed: () {
                            Helper.launchPhone("+916363574938");
                          },
                          title: "Call Us"))
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(14),
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(width: 1.5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.black45,
                    radius: 25,
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: AppColors.whiteColor,
                      child: const Icon(CupertinoIcons.mail),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const TextWidget(
                      text: "Email Us",
                      fontWeight: FontWeight.bold,
                      textSize: 22),
                  const SizedBox(height: 8),
                  TextWidget(
                      text: "support@yesgobus.com",
                      textSize: 14,
                      color: AppColors.redColor),
                  const SizedBox(height: 12),
                  const TextWidget(
                      text:
                          "Write to us about your query and our customer support team will revert as soon as possible",
                      textSize: 14,
                      maxLine: 5),
                  const SizedBox(height: 16),
                  SizedBox(
                      width: 140,
                      height: 45,
                      child: AppButton.outlineButton(
                          borderColor: AppColors.black45,
                          onButtonPressed: () {
                            Helper.launchMail("support@yesgobus.com");
                          },
                          title: "Send Email"))
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const FAQSScreen());
        },backgroundColor: AppColors.primaryColor,
        child: Icon(Icons.help,color: AppColors.whiteColor,),
      ),
    );
  }
}
