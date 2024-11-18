import 'package:driver_onboarding/controller/userDetailsController/user_detail_controller.dart';
import 'package:driver_onboarding/screen/ONBOARDING/complaintScreens/complaint_screen.dart';
import 'package:driver_onboarding/screen/ONBOARDING/multiAggregatorScreens/driver_warning_dilogue.dart';
import 'package:driver_onboarding/screen/ONBOARDING/multiAggregatorScreens/driving_hour_dilogue.dart';
import 'package:driver_onboarding/utils/helper/helper.dart';
import 'package:driver_onboarding/utils/helper/helper_sncksbar.dart';
import 'package:driver_onboarding/widget/appbar/appbar.dart';
import 'package:driver_onboarding/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../widget/buttons/button.dart';

class MultiAggregatorScreen extends StatefulWidget {
  const MultiAggregatorScreen({super.key});

  @override
  State<MultiAggregatorScreen> createState() => _MultiAggregatorScreenState();
}

class _MultiAggregatorScreenState extends State<MultiAggregatorScreen> {
  UserDetailsController userDetailsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HelperAppBar.appbarHelper(
          title: "Information Page on Multi-Aggregator Operations Policy",
          hideBack: true),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            Divider(),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return SizedBox(height: 12);
                },
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return TextWidget(
                      text:
                          "$index. Lorem ipsum dolor sit amet consectetur. Lacus nisi faucibus nunc ac. Eu aliquam non sem pharetra quam mauris pulvinar. Eu purus lorem quam tempor pharetra risus vel nunc praesent. Ac blandit rhoncus massa quis.i.",
                      maxLine: 10,
                      textSize: 14);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14, bottom: 14, top: 8),
        child: AppButton.primaryButton(
            onButtonPressed: () {
              userDetailsController.perDayLimitController.text = "6";
              showDrivingHourPopup(
                  context: context,
                  onTap: () {
                    if (int.parse(
                            userDetailsController.perDayLimitController.text) >=
                        int.parse(userDetailsController
                            .howManyHoursController.text)) {
                      Get.back();
                      userDetailsController.drivingHrsDetailPost(context);
                    } else {
                      HelperSnackBar.snackBar(
                          "Error", "Driver hours must be less than limit");
                    }
                  });
            },
            title: "Understood"),
      ),
    );
  }
}
