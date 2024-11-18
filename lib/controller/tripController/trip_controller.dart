import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:driver_onboarding/screen/APPLICATIONS/homeScreen/home_screen.dart';
import 'package:driver_onboarding/utils/getStore/get_store.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:path/path.dart' as path;
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:open_filex/open_filex.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/completeTripModel/complete_trip_model.dart';
import '../../model/newTripRequest/new_trip_model.dart';
import '../../screen/APPLICATIONS/rideScreen/ride_screen.dart';
import '../../utils/apiService/api_base.dart';
import '../../utils/apiService/api_url.dart';
import '../../utils/helper/helper_sncksbar.dart';

Map<String, String> requestHeaders = {
  'Authorization': "Bearer ${GetStoreData.getStore.read('access_token')}",
  'Content-Type': 'application/json',
};

class TripController extends GetxController {
  RxBool isLoading = false.obs;
  RideStatus? currentStatus;
  TripDetailModel? tripData;

  Future postRideAccept(
      {required bool isAccept, required String rideID}) async {
    var body = {
      'ride_id': rideID,
      "status_accept": isAccept,
      'is_transport_ride': tripData!.isTransportRide
    };
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.postRideAcceptUrl, withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      if (isAccept) {
        currentStatus = RideStatus.accept;
      } else {
        currentStatus = RideStatus.reject;
        currentStatus = RideStatus.newReq;
        Get.offAll(HomeScreen());
      }
      Get.back();
    } else {
      Get.back();
      Get.off(() => const HomeScreen());
      HelperSnackBar.snackBar("Error", data["message"]);
    }
  }

  Future postGoForPickup(String rideID) async {
    var body = {
      'ride_id': rideID,
      'is_transport_ride': tripData!.isTransportRide
    };
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.postGoForPickupUrl, withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      currentStatus = RideStatus.goForPickup;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
    }
  }

  Future postStartRide(String rideID, String otp) async {
    var body = {
      'otp': otp,
      'ride_id': rideID,
      'is_transport_ride': tripData!.isTransportRide
    };
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.postStartRideUrl, withToken: true);
    log(response.body);
    var data = json.decode(response.body);
    if (data["status"] == true) {
      currentStatus = RideStatus.startRide;
    } else {
      HelperSnackBar.snackBar("Error", data["message"]);
    }
  }

  TripComplete tripComplete = TripComplete();
  Future postCompleteRide() async {
    try {
      isLoading.value = true;
      var body = {
        'ride_id': tripData!.rideID,
        'is_transport_ride': tripData!.isTransportRide
      };
      var response = await ApiBase.postRequest(
          body: body, extendedURL: ApiUrl.postCompleteRideUrl, withToken: true);
      log(response.body);
      var data = json.decode(response.body);
      if (data["status"] == true) {
        currentStatus = RideStatus.completeRide;
        CompleteTripModel completeTripModel = CompleteTripModel.fromJson(data);
        tripComplete = completeTripModel.data!;
      } else {
        HelperSnackBar.snackBar("Error", data["message"]);
      }
    } catch (e) {
      log("complete ride $e ");
    } finally {
      isLoading.value = false;
    }
  }

  Future postBillingPDF() async {
    isLoading.value = true;
    var body = {
      'ride_id': tripData!.rideID,
      'is_transport_ride': tripData!.isTransportRide.toString()
    };
    var response = await ApiBase.postRequest(
        body: body, extendedURL: ApiUrl.postBillingPDFUrl, withToken: true);
    try {
      log(response.body);
      var data = json.decode(response.body);
      if (data["status"] == true) {
        String pdfURL = "${data['data']['pdf_url']}";
        String pdfname = "${data['data']['pdf_name']}";
        download(pdfURL, pdfname);
      } else {
        HelperSnackBar.snackBar("Error", data["message"]);
      }
    } catch (e) {
      log("billingpdf ride $e ");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _saveFileWithMediaStore(
      String url, String fileName, Dio dio) async {
    try {
      final downloads = await _getDownloadsDirectory();
      if (downloads == null) {
        print('Could not access downloads directory');
        return;
      }

      // File path for MediaStore
      final filePath = '${downloads.path}/$fileName';
      print('Saving file to: $filePath');

      await dio.download(url, filePath);

      OpenFilex.open(filePath); // Open the file once saved
    } catch (e) {
      print('Error downloading or saving file: $e');
    }
  }

  Future<Directory?> _getDownloadsDirectory() async {
    if (Platform.isAndroid) {
      // Use getExternalStorageDirectory for scoped storage path on Android
      return await getExternalStorageDirectory();
    } else {
      return await getApplicationDocumentsDirectory();
    }
  }

  Future<bool> _isAndroid10OrHigher() async {
    try {
      final int sdkInt = int.parse(await _getAndroidSdkVersion());
      return sdkInt >= 30; // Android 10 is API level 29
    } catch (e) {
      return false;
    }
  }

  Future<String> _getAndroidSdkVersion() async {
    try {
      final sdkVersion = await MethodChannel('flutter.platform')
          .invokeMethod<String>('getAndroidSdkVersion');
      return sdkVersion ?? '0';
    } catch (e) {
      return '0';
    }
  }

  download(String url, String fileName) async {
    Dio dio = Dio();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    int androidVersion = androidInfo.version.sdkInt;

    try {
      if (Platform.isAndroid && androidVersion >= 30) {
        await launch("$url");
      } else if (Platform.isIOS) {
        Directory appDocDir = await getApplicationDocumentsDirectory();
        String filePath = '${appDocDir.path}/$fileName';
        await dio.download(url, filePath);
        OpenFilex.open(filePath);
      } else {
        if (await Permission.storage.request().isGranted) {
          await launch("$url");
          Directory? downloadsDir = Directory('/storage/emulated/0/Download');
          if (downloadsDir.existsSync()) {
            final filePath = '${downloadsDir.path}/$fileName';
            print('Saving file to: $filePath');
            await dio.download(url, filePath);
            OpenFilex.open(filePath);
          }
        }
      }
    } catch (e) {
      print('Download error: $e');
    }

    //   Dio dio = Dio();
    //   try {
    //     if (Platform.isAndroid) {
    //       if (await Permission.storage.request().isGranted) {
    //         // Use Scoped Storage (Downloads directory for Android 10+)
    //         Directory? downloadsDir;
    //         if (Platform.isAndroid && await _isAndroid30OrHigher()) {
    //           downloadsDir = await _getDownloadDirectoryScoped();
    //         } else {
    //           downloadsDir = Directory('/storage/emulated/0/Download');
    //         }

    //         if (downloadsDir != null) {
    //           final filePath = '${downloadsDir.path}/$name';
    //           print('Saving file to: $filePath');

    //           // Download the file using Dio
    //           final response = await dio.download(path, filePath,
    //               options: Options(responseType: ResponseType.bytes));

    //           if (response.statusCode == 200) {
    //             print('File downloaded at: $filePath');
    //             OpenFilex.open(filePath); // Open the file
    //           } else {
    //             print('Failed to download the file.');
    //           }
    //         } else {
    //           print('Failed to find the download directory');
    //         }
    //       } else {
    //         print('Storage permission denied');
    //       }
    //     } else if (Platform.isIOS) {
    //       Directory dir = await getApplicationDocumentsDirectory();
    //       final filePath = '${dir.path}/$name';
    //       print('Saving file to: $filePath');

    //       final response = await dio.download(path, filePath,
    //           options: Options(responseType: ResponseType.bytes));

    //       if (response.statusCode == 200) {
    //         OpenFilex.open(filePath);
    //       } else {
    //         print('Failed to download the file.');
    //       }
    //     }
    //   } catch (e) {
    //     print('Download error: $e');
    //   }
    // }

    // Future<Directory?> _getDownloadDirectoryScoped() async {
    //   if (Platform.isAndroid) {
    //     final downloadsDir = Directory('/storage/emulated/0/Download');
    //     if (await downloadsDir.exists()) {
    //       return downloadsDir;
    //     }
    //   }
    //   return null;
    // }

    // Future<bool> _isAndroid30OrHigher() async {
    //   try {
    //     final int sdkInt = int.parse(await _getAndroidSdkVersion());
    //     return sdkInt >= 30;
    //   } catch (e) {
    //     return false;
    //   }
    // }

    // Future<String> _getAndroidSdkVersion() async {
    //   try {
    //     final sdkVersion = await MethodChannel('flutter.platform')
    //         .invokeMethod<String>('getAndroidSdkVersion');
    //     return sdkVersion ?? '0';
    //   } catch (e) {
    //     return '0';
    //   }

    // Dio dio = Dio();
    // try {
    //   var dir = await getApplicationDocumentsDirectory();
    //   String filePath = '${dir.path}/$name';
    //   final response = await dio.download(
    //     path,
    //     filePath,
    //   );

    //   if (response.statusCode == 200) {
    //     OpenFilex.open(filePath);
    //   } else {
    //     // Handle error case
    //     print('Failed to download the file.');
    //   }

    //   print('File downloaded at: $filePath');
    // } catch (e) {
    //   log("message $e");
    // }
  }
}
