import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screen/ONBOARDING/complaintScreens/certificate_remined_renewal_dilogue.dart';
import '../../screen/ONBOARDING/complaintScreens/complaint_screen.dart';
import '../../screen/ONBOARDING/complaintScreens/compliance_dilogue.dart';
import '../../screen/ONBOARDING/contactUsScreen/contact_us_screen.dart';
import '../../screen/ONBOARDING/driverOnboardingScreens/confirmation_screen.dart';
import '../../screen/ONBOARDING/insurance&healthScreen/insurance_health_screen.dart';
import '../../screen/ONBOARDING/multiAggregatorScreens/driver_warning_dilogue.dart';
import '../../screen/ONBOARDING/multiAggregatorScreens/multi_aggregator_operation_screen.dart';
import '../../screen/ONBOARDING/recordsManagementScreens/record_management_screen.dart';
import '../../screen/ONBOARDING/training&programingScreens/training_program_screen.dart';
import '../../screen/ONBOARDING/vehicleTrackingMonitoringScreens/instruction_dilogue.dart';
import '../../screen/ONBOARDING/vehicleTrackingMonitoringScreens/panic_dilogue.dart';
import '../../screen/ONBOARDING/vehicleTrackingMonitoringScreens/vehicle_tracking_screen.dart';
import '../../utils/apiService/api_base.dart';
import '../../utils/apiService/api_url.dart';
import '../../utils/helper/helper.dart';
import '../../utils/helper/helper_sncksbar.dart';

class UserDetailsController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  String dobPost = "";
  TextEditingController mobileController = TextEditingController();
  TextEditingController alternateMobileController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController yearExpController = TextEditingController();
  TextEditingController vehicleModelController = TextEditingController();
  // TextEditingController vehicleCategoryController = TextEditingController();
  TextEditingController vehicleNumberController = TextEditingController();
  TextEditingController yearOfRegController = TextEditingController();
  String dlImg = "";
  String vehicleRegImg = "";
  String aadharImg = "";
  String vehicleImg = "";
  String profileImg = "";
  String? registerAs;
  String? registerAsID;
  String? vehicleCategory;
  String? vehicleCategoryID;
  Future userDetailPost(context) async {
    Helper.loader(context);
    var body = {
      "user_type": registerAsID,
      "fullName": nameController.text,
      "email": emailController.text,
      "mobileNumber": mobileController.text,
      "pincode": pincodeController.text,
      "dob": dobPost,
      "address": addressController.text,
      "bloodGroup": bloodGroupController.text,
      "alternateNumber": alternateMobileController.text,
      "total_experience": yearExpController.text,
      "vehicle_model": vehicleModelController.text,
      "vehicle_category": vehicleCategoryID,
      "vehicle_number": vehicleNumberController.text,
      "year_of_registration": yearOfRegController.text,
      "dl_img": dlImg,
      "vehicle_reg_img": vehicleRegImg,
      "vehicle_image": vehicleImg,
      "profile_img": profileImg,
      "aadhaar_img": aadharImg,
    };
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.userDetailUrl, withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      Get.back();
      Get.to(const ConfirmationScreen());
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return "";
    }
  }

  List<String> userTypeName = [];
  List<String> userTypeId = [];
  var isLoading = false.obs;
  Future getUserType() async {
    try {
      isLoading.value = true;
      var response = await ApiBase.getRequest(
        extendedURL: ApiUrl.getuserTypeUrl,
      );
      log(response.body);
      var data = json.decode(response.body);

      if (data["status"] == true) {
        userTypeName.clear();
        userTypeId.clear();
        for (var i = 0; i < data['data'].length; i++) {
          userTypeName.add(data['data'][i]['user_type_name']);
          userTypeId.add(data['data'][i]['user_type_id']);
        }
      } else {
        HelperSnackBar.snackBar("Error", data["message"]);
        return "";
      }
    } catch (e) {
      log("message $e");
    } finally {
      isLoading.value = false;
    }
  }

  List<String> vehicleCatName = [];
  List<String> vehicleCatId = [];
  var isLoading2 = false.obs;
  Future getVehicleCat(userTypeId) async {
    try {
      isLoading2.value = true;
      var response = await ApiBase.getRequest(
        extendedURL: ApiUrl.getVehicleCategoryUrl + userTypeId,
      );
      log(response.body);
      var data = json.decode(response.body);

      if (data["status"] == true) {
        vehicleCatName.clear();
        vehicleCatId.clear();
        for (var i = 0; i < data['data'].length; i++) {
          vehicleCatName.add(data['data'][i]['category_name']);
          vehicleCatId.add(data['data'][i]['category_id']);
        }
      } else {
        HelperSnackBar.snackBar("Error", data["message"]);
        return "";
      }
    } catch (e) {
      log("message $e");
    } finally {
      isLoading2.value = false;
    }
  }

  // Future imgPost(context, {required String kkey, required String val}) async {
  //   Helper.loader(context);
  //   var body = {
  //     kkey: val.toString(),
  //   };
  //   var response = await ApiBase.postRequest(
  //       body: body, extendedURL: ApiUrl.imgUploadUrl, withToken: true);
  //   log(response.body);
  //   var data = json.decode(response.body);
  //   if (data["status"] == true) {
  //     Get.back();
  //   } else {
  //     Get.back();
  //     HelperSnackBar.snackBar("Error", data["message"]);
  //     return "";
  //   }
  // }

  TextEditingController rateReviewController = TextEditingController();

  Future docMgtDetailPost(context) async {
    Helper.loader(context);
    var body = {
      "ratingFeedback": rateReviewController.text,
    };
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.userDetailUrl, withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      Get.back();
      Get.to(MultiAggregatorScreen());
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return "";
    }
  }

  TextEditingController perDayLimitController = TextEditingController();
  TextEditingController howManyHoursController = TextEditingController();
  Future drivingHrsDetailPost(context) async {
    Helper.loader(context);
    var body = {
      "limitations": perDayLimitController.text,
      "total_work_hour": howManyHoursController.text,
    };
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.userDetailUrl, withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      Get.back();
      showDrivingWarningPopup(
          context: context,
          onTap: () {
            Get.back();
            Get.to(ComplaintScreen());
          });
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return "";
    }
  }

  String policeVerificationImg = "";
  String medicalExamImg = "";
  String criminalRecordImg = "";
  String certificateInsuranceImg = "";
  Future bgVerificationDetailPost(context) async {
    Helper.loader(context);
    var body = {
      'police_verification_img': policeVerificationImg,
      'medical_exam_img': medicalExamImg,
      'criminal_record_img': criminalRecordImg,
      'certificate_insurance_img': certificateInsuranceImg,
    };
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.userDetailUrl, withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      Get.back();
      Get.to(const TrainingNprogramingScreen());
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return "";
    }
  }

  String inductionTrainingImg = "";
  String refresherTrainingImg = "";
  String trainingSessionImg = "";
  String trainingRecordsImg = "";
  Future trainingProgramePost(context) async {
    Helper.loader(context);
    var body = {
      'induction_training_img': inductionTrainingImg,
      'refresher_training_img': refresherTrainingImg,
      'training_session_img': trainingSessionImg,
      'training_records_img': trainingRecordsImg,
    };
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.userDetailUrl, withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      Get.back();
      Get.to(const InsuranceHealthScreen());
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return "";
    }
  }

  String termInsuranceImg = "";
  String healthInsuranceImg = "";
  String claimsProcessingImg = "";
  Future insuranceHealthPost(context) async {
    Helper.loader(context);
    var body = {
      'term_insurance_img': termInsuranceImg,
      'health_insurance_img': healthInsuranceImg,
      'claim_processing_img': claimsProcessingImg,
    };
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.userDetailUrl, withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      Get.back();
      Get.to(const MultiAggregatorScreen());
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return "";
    }
  }

  TextEditingController vehicleRegistrationController = TextEditingController();
  TextEditingController permitDetailsController = TextEditingController();
  TextEditingController pendingChallansController = TextEditingController();
  String permitImg = "";

  Future complaintPost(context) async {
    Helper.loader(context);
    var body = {
      // "vehicle_registration": vehicleRegistrationController.text,
      // "permit_details": permitDetailsController.text,
      // "pending_e_challans": pendingChallansController.text,
      "permit_img": permitImg
    };
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.userDetailUrl, withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      Get.back();
      Get.to(() => RecordsManagementScreen());

//  showInstructionPopup(
//           context: context,
//           onTap: () {
//             Get.back();
//             showPanicPopup(
//                 context: context,
//                 onTap: () {
//                   Get.back();
//                   Get.to(() => RecordsManagementScreen());
//                 });
//           });

      // showCertificateRenewRemindPopup(
      //     context: context,
      //     onTap: () {
      //       Get.back();
      //       showComplaincePopup(
      //           context: context,
      //           onTap: () {
      //             Get.back();
      //             Get.to(VehicleTrackingScreen());
      //           });
      //     });
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return "";
    }
  }

  String docUploadSessionImg = "";
  String licenseImg = "";
  Future recordsMngtPost(context) async {
    Helper.loader(context);
    var body = {
      'doc_upload_session_img': docUploadSessionImg,
      'license_img': licenseImg,
    };
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.userDetailUrl, withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      Get.back();
      Get.to(() => ContactUsScreen());
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return "";
    }
  }

  TextEditingController aisController = TextEditingController();

  Future vehicleTrackingPost(context) async {
    Helper.loader(context);
    var body = {
      "tracking_monitoring": aisController.text,
    };
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.userDetailUrl, withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      Get.back();
      showInstructionPopup(
          context: context,
          onTap: () {
            Get.back();
            showPanicPopup(
                context: context,
                onTap: () {
                  Get.back();
                  Get.to(() => RecordsManagementScreen());
                });
          });
    } else {
      Get.back();
      HelperSnackBar.snackBar("Error", data["message"]);
      return "";
    }
  }
}
