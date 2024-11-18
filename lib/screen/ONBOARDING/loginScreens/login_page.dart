import 'package:driver_onboarding/screen/ONBOARDING/loginScreens/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../controller/loginController/login_controller.dart';
import '../../../utils/appcolors/app_colors.dart';
import '../../../utils/constant/png_asset_constant.dart';
import '../../../widget/buttons/button.dart';
import '../../../widget/text_field/text_field.dart';
import '../../../widget/textwidget/text_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginMobileController loginMobileController =
      Get.put(LoginMobileController());
  GlobalKey<FormState> formkey = GlobalKey();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {});
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                // const Spacer(),
                Image.asset(
                  PngAssetPath.appLogo,
                  height: 120,
                  color: AppColors.blackColor,
                  width: 120,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Welcome ',
                    style: const TextStyle(
                        fontSize: 24,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'YesGoBus',
                          style: TextStyle(color: AppColors.blackColor)),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),

                TextWidget(
                  text: 'Sign in with your mobile number',
                  color: AppColors.blackColor,
                  textSize: 12,
                ),
                const SizedBox(height: 20),
                MyCustomTextField.textFieldPhone(
                    textInputType: TextInputType.phone,
                    controller: loginMobileController.phoneController,
                    borderClr: AppColors.blackColor,
                    borderRadius: 100,
                    textClr: AppColors.blackColor,
                    valText: "Please enter mobile number",
                    hintText: "Mobile Number"),

              
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                        child:
                            Container(height: 1, color: AppColors.blackColor)),
                    const SizedBox(width: 6),
                    TextWidget(
                      text: "Or",
                      textSize: 14,
                      color: AppColors.blackColor,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                        child:
                            Container(height: 1, color: AppColors.blackColor)),
                  ],
                ),
                // const SizedBox(height: 10),
                // CustomOutlinedIconButton(
                //   radius: 50,
                //   color: AppColors.blackColor,
                //   borderWidth: 1,
                //   size: const Size(double.infinity, 55),
                //   icon: Icon(
                //     Icons.facebook_outlined,
                //     color: AppColors.blackColor,
                //   ),
                //   label: TextWidget(
                //     text: 'Continue With facebook',
                //     textSize: 16,
                //     color: AppColors.blackColor,
                //   ),
                //   onPressed: () {},
                // ),
                // const SizedBox(height: 10),
                // CustomOutlinedIconButton(
                //   size: const Size(double.infinity, 55),
                //   radius: 50,
                //   borderWidth: 1,
                //   color: AppColors.blackColor,
                //   icon: Icon(
                //     Icons.g_mobiledata,
                //     color: AppColors.blackColor,
                //   ),
                //   label: TextWidget(
                //     text: 'Continue With Google',
                //     textSize: 16,
                //     color: AppColors.blackColor,
                //   ),
                //   onPressed: () {},
                // ),
                // const SizedBox(height: 10),
                // CustomOutlinedIconButton(
                //   radius: 50,
                //   borderWidth: 1,
                //   color: AppColors.blackColor,
                //   size: const Size(double.infinity, 55),
                //   icon: Icon(
                //     Icons.apple_outlined,
                //     color: AppColors.blackColor,
                //   ),
                //   label: TextWidget(
                //     text: 'Continue With Apple',
                //     textSize: 16,
                //     color: AppColors.blackColor,
                //   ),
                //   onPressed: () {},
                // ),
              
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                        text: "I don’t have an account ",
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackColor,
                        textSize: 14),
                    InkWell(
                      onTap: () {
                        Get.to(() => SignupScreen());
                      },
                      child: const TextWidget(
                        text: "Sign Up",
                        textSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryColor,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(PngAssetPath.jstdialImg),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: AppButton.primaryButton(
              title: 'SIGN IN',
              onButtonPressed: () {
                if (formkey.currentState!.validate()) {
                  loginMobileController.loginApi(context);
                  // Get.to(KYCInfo1Screen());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
