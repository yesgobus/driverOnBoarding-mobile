import 'dart:convert';
import 'dart:developer';
import 'package:driver_onboarding/model/kycModel/aadharKyc_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../screen/ONBOARDING/driverOnboardingScreens/personal_info_screen.dart';
import '../../screen/ONBOARDING/driverOnboardingScreens/upload_document_screen.dart';
import '../../utils/apiService/api_base.dart';
import '../../utils/apiService/api_url.dart';
import '../../utils/helper/helper.dart';
import '../../utils/helper/helper_sncksbar.dart';

class MyKYCController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  // TextEditingController pincodeController = TextEditingController();

  TextEditingController aadharController = TextEditingController();
  TextEditingController panController = TextEditingController();
  TextEditingController dobPanController = TextEditingController();
  String dobPostPAN = "";
  TextEditingController namePanController = TextEditingController();
  TextEditingController dlController = TextEditingController();
  TextEditingController dobDlController = TextEditingController();
  String dobPostDL = "";
  TextEditingController rcController = TextEditingController();

  TextEditingController accHoldernameController = TextEditingController();
  TextEditingController accNumController = TextEditingController();
  TextEditingController reenterAccNumController = TextEditingController();
  TextEditingController ifscController = TextEditingController();
  int selectAccIndex = 0;
  final TextEditingController otpcontroller = TextEditingController();
  AadharOtpData aadharOtpData = AadharOtpData();

  Future userDetailPost(context) async {
    Helper.loader(context);
    var body = {
      "fullName": nameController.text,
      "email": emailController.text,
      "mobileNumber": mobileController.text,
      // "pincode": pincodeController.text,
    };
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.userDetailUrl, withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      Get.back();
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return "";
    }
  }

  Future bankDetailPost(context) async {
    Helper.loader(context);
    var body = {
      "account_type": selectAccIndex == 0 ? "Savings" : "Current",
      "account_holder_name": accHoldernameController.text,
      "account_number": accNumController.text,
      "ifsc_code": ifscController.text,
    };
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.bankDetailUrl, withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      Get.back();
      Get.to(const PersonalInfoScreen());
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return "";
    }
  }

  Future<bool> aadharSentOtpPost(context) async {
    //559476186587
    Helper.loader(context);
    var body = {"aadhaar_number": aadharController.text};
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.aadharSentOtpUrl, withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      Get.back();
      AadharModelSentOtp aadharModelSentOtp = AadharModelSentOtp.fromJson(data);
      aadharOtpData = aadharModelSentOtp.data!.data!;

      return true;
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return false;
    }
  }

  RxBool isAadharVerify = false.obs;
  Future verifyAadharOtpPost(context) async {
    Helper.loader(context);
    var body = {
      "otp": otpcontroller.text,
      "aadhaar_number": aadharController.text,
      "client_id": aadharOtpData.clientId
    };
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.verifyAadharOtpUrl, withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      Get.back();
      Get.back();
      isAadharVerify = true.obs;
      update();
    } else {
      Get.back();
      isAadharVerify = false.obs;
      HelperSnackBar.snackBar("Error", data["message"]);
      return "";
    }
  }

  RxBool isPanVerify = false.obs;
  Future panVerifyPost(context) async {
    Helper.loader(context);
    var body = {
      "pan_number": panController.text,
      "dob": dobPostPAN,
      "full_name": namePanController.text
    };
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.panSentOtpUrl, withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      Get.back();
      isPanVerify = true.obs;
    } else {
      Get.back();
      isPanVerify = false.obs;
      HelperSnackBar.snackBar("Error", data["message"]);
      return "";
    }
  }

  RxBool isDlVerify = false.obs;
  Future dlVerifyPost(context) async {
    Helper.loader(context);
    var body = {"license_number": dlController.text, "dob": dobPostDL};
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.dlSentOtpUrl, withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      Get.back();
      isDlVerify = true.obs;
    } else {
      Get.back();
      isDlVerify = false.obs;
      HelperSnackBar.snackBar("Error", data["message"]);
      return "";
    }
  }

  RxBool isRCVerify = false.obs;
  Future rcVerifyPost(context) async {
    Helper.loader(context);
    var body = {
      "rc_number": rcController.text,
    };
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.verifyRCUrl, withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      Get.back();
      isRCVerify = true.obs;
    } else {
      Get.back();
      isRCVerify = false.obs;
      HelperSnackBar.snackBar("Error", data["message"]);
      return "";
    }
  }
}
