class ApiUrl {
  /// base url
  
  static const String baseUrl = "http://ec2-13-127-219-49.ap-south-1.compute.amazonaws.com:8000/api/";
  static const String loginUrl = "cabdriver/login";
  static const String signupUrl = "cabdriver/signup";
  static const String verifyOTPUrl = "cabdriver/verify_otp";
  static const String resendOTPUrl = "cabdriver/resend_otp";
  static const String userDetailUrl = "cabdriver/update_user_detail";
  static const String getuserTypeUrl = "cabdriver/usertype";
  static const String getVehicleCategoryUrl = "cabdriver/vehicle_category/";
  // static const String imgUploadUrl = "cabdriver/upload_file";
  static const String bankDetailUrl = "cabdriver/add_bank_detail";
  static const String aadharSentOtpUrl = "cabdriver/send_otp_aadhaar";
  static const String verifyAadharOtpUrl = "cabdriver/verify_aadhaar_otp"; 
  static const String panSentOtpUrl = "cabdriver/validate_pan";
  static const String dlSentOtpUrl = "cabdriver/validate_driving_license";
  static const String verifyRCUrl = "cabdriver/validate_rc";
  static const String postDeleteAcc = "cabdriver/delete";



  //app
  static const String postDriverLocationUrl = "cabdriver/update-location";
  static const String postDutyUrl = "cabdriver/duty";
  static const String postRideAcceptUrl = "cabdriver/ride/accept";
  static const String postGoForPickupUrl = "cabdriver/ride/go_for_pickup";
  static const String postStartRideUrl = "cabdriver/ride/start_ride";
  static const String postCompleteRideUrl = "cabdriver/end-trip";
  static const String postBillingPDFUrl = "cabdriver/billingpdf";
  static const String getDriverConfigration = "cabdriver/configuration";
  


}
