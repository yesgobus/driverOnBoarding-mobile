import 'dart:convert';
import 'dart:developer' as log;
// import 'dart:io';
import 'dart:math';

import 'package:driver_onboarding/screen/ONBOARDING/loginScreens/otp_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
// import 'package:otpless_flutter/otpless_flutter.dart';
import '../../screen/APPLICATIONS/permmissionScreen/permission_screen.dart';
import '../../screen/ONBOARDING/kycScreens/kyc_info1_screen.dart';
import '../../utils/apiService/api_base.dart';
import '../../utils/apiService/api_url.dart';
import '../../utils/getStore/get_store.dart';
import '../../utils/helper/helper.dart';
import '../../utils/helper/helper_sncksbar.dart';

class LoginMobileController extends GetxController {
  TextEditingController phoneController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController conPasswordController = TextEditingController();
  final TextEditingController otpcontroller = TextEditingController();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool isLogin = true;
  String orderId = "";
  Future<String> loginApi(context) async {
    Helper.loader(context);
    var body = {
      "mobileNumber": "91${phoneController.text}",
    };
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.loginUrl, withToken: false);
    log.log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      Get.back();
      orderId = data['data']['orderId'];

      Get.to(OtpPage());
      return data['data']['otp'].toString();
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return "";
    }
  }

  Future<String> signupApi(context) async {
    Helper.loader(context);
    var body = {
      "mobileNumber": "91${phoneController.text}",
      "firstName": firstNameController.text,
      "lastName": lastNameController.text,
      "email": emailController.text,
    };
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.signupUrl, withToken: false);
    log.log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      Get.back();
      orderId = data['data']['orderId'];
      Get.to(OtpPage());

      return data['data']['otp'].toString();
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return "";
    }
  }

  Future<String> verifyOtpApi(context) async {
    Helper.loader(context);
    var body = {
      "mobileNumber": "91${phoneController.text}",
      "orderId": orderId,
      "otp": otpcontroller.text,
    };
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.verifyOTPUrl, withToken: false);
    log.log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      Get.back();
      GetStoreData.storeUserData(
          id: data['data']['user']['_id'],
          email: data['data']['user']['email'],
          name: data['data']['user']['firstName'] +
              " " +
              data['data']['user']['lastName'],
          authToken: data['data']['token'],
          phone: data['data']['user']['mobileNumber']);

      log.log(GetStoreData.getStore.read('access_token'));
      if (isLogin) {
        Get.offAll(PermissionLandingScreen());
      } else {
        Get.offAll(KYCInfo1Screen());
      }
      return data['data']['otp'].toString();
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return "";
    }
  }

  Future<String> resendOTP(context) async {
    Helper.loader(context);
    var body = {
      "orderId": orderId,
    };
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.resendOTPUrl, withToken: false);
    log.log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      Get.back();
      HelperSnackBar.snackBar("Success", data["message"]);

      return data['data']['otp'].toString();
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return "";
    }
  }

  // var imageBase64 = "".obs;
  // final ImagePicker _picker = ImagePicker();
  // XFile? image;

  // Future<void> openCameraGallery({required bool isCamera}) async {

  //   var tempimage = await _picker.pickImage(
  //       source: isCamera ? ImageSource.camera : ImageSource.gallery);
  //   if (tempimage != null) {
  //     // File f = new File(tempimage.path);
  //     // var s = f.lengthSync();
  //     // var fileSizeInKB = s / 2048;
  //     // if (fileSizeInKB > fileSizeLimit) {
  //     //   HelperSnackBar.snackBar("Error", "Please select under 2 mb");
  //     // } else {
  //     image = tempimage;
  //     File file = File(image!.path);
  //     List<int> fileInByte = file.readAsBytesSync();
  //     String fileInBase64 = base64Encode(fileInByte);
  //     imageBase64.value = "data:image/jpeg;base64,$fileInBase64";
  //     // }
  //   }
  //   // Get.back();
  //   update();
  // }
}
