import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../model/configrationModel/configration_model.dart';
import '../../utils/apiService/api_base.dart';
import '../../utils/apiService/api_url.dart';
import '../../utils/helper/helper.dart';
import '../../utils/helper/helper_sncksbar.dart';
import 'package:audioplayers/audioplayers.dart';

class HomeController extends GetxController {

  final player = AudioPlayer();
  Future driverLocationUpdate(LatLng latlng) async {
    var body = {"driver_lat": latlng.latitude, "driver_lng": latlng.longitude};
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.postDriverLocationUrl, withToken: true);
    // log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return "";
    }
  }

  Future postDuty(bool isOnDuty) async {
    var body = {
      "is_on_duty": isOnDuty,
    };
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.postDutyUrl, withToken: true);
    log(response.body);
    var data = json.decode(response.body);

    if (data["status"] == true) {
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return "";
    }
  }

  var isLoading = false.obs;
  ConfigData? configData;
  Future getDriverConfigration() async {
    try {
      isLoading.value = true;
      var response = await ApiBase.getRequest(
        extendedURL: ApiUrl.getDriverConfigration,
      );
      log(response.body);
      var data = json.decode(response.body);
      Get.back();
      if (data["status"] == true) {
        ConfigrationModel configrationModel = ConfigrationModel.fromJson(data);
        configData = configrationModel.data!;
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

  Future postDelete() async {
    Helper.loader(Get.context);

    var response = await ApiBase.deleteRequest(
      extendedURL: ApiUrl.postDeleteAcc,
    );
    log(response.body);
    var data = json.decode(response.body);
    Get.back();
    if (data["status"] == true) {
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
      return "";
    }
  }
}
