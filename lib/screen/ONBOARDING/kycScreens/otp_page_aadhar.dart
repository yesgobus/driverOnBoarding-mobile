import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/kycController/myKYC_controller.dart';
import '../../../utils/constant/png_asset_constant.dart';
import '../../../widget/buttons/button.dart';
import '../../../widget/text_field/otp_text_field.dart';

class OtpPageAadhar extends StatefulWidget {
  OtpPageAadhar({
    super.key,
  });

  @override
  State<OtpPageAadhar> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPageAadhar> {
  MyKYCController kycController = Get.put(MyKYCController());

  int _timerSeconds = 60;
  late Timer _timer;
  bool _isTimerRunning = false;

  void _startTimer() {
    _isTimerRunning = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timerSeconds > 0) {
          _timerSeconds--;
        } else {
          _isTimerRunning = false;
          _timer.cancel();
        }
      });
    });
  }

  void _resendOTP() {
    if (!_isTimerRunning) {
      _timerSeconds = 60;
      // loginMobileController.sendOTP();
      _startTimer();
    }
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  void initState() {
    _startTimer();
    kycController.otpcontroller.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white10, elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Spacer(),
            Image.asset(
              PngAssetPath.otpVerification,
              height: 174,
              width: 200,
            ),
            SizedBox(height: 20),
            Text(
              'Enter Verification Code',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'We have just sent a verification code to your mobile number',
              style:
                  theme.textTheme.bodyMedium?.copyWith(color: Colors.black45),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            OtpTextField(
              pinLength: 6,
              controller: kycController.otpcontroller,
              onCompleted: (String st) {},
            ),
            SizedBox(height: 20),
            // InkWell(
            //   onTap: () {
            //     _resendOTP();
            //   },
            //   child: TextWidget(
            //     text: "Resend ${_isTimerRunning ? ": $_timerSeconds sec" : ""}",
            //     textSize: 16,
            //     color: AppColors.primaryColor,
            //   ),
            // ),
            const Spacer(),
            AppButton.primaryButton(
                title: 'Verify',
                onButtonPressed: () {
                  kycController
                      .verifyAadharOtpPost(context);
                }),
          ],
        ),
      ),
    );
  }
}
