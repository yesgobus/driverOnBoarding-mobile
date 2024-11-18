import 'dart:async';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../homeController/home_controller.dart';

class LocationController extends GetxController {
  var isStartWorking = false.obs;
  Timer? timer;
  Position? currentPosition;
  HomeController homeController = Get.put(HomeController());

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  Future<void> startTracking() async {
    if (timer != null && timer!.isActive) {
      return; // Timer is already running
    }
    if (await _checkPermissions()) {
      isStartWorking.value = true;
      homeController.postDuty(isStartWorking.value);

      timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
        currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        print(
            'Driver current position: $currentPosition ${DateTime.timestamp().second}');
        homeController.driverLocationUpdate(
            LatLng(currentPosition!.latitude, currentPosition!.longitude));
      });
    }
  }

  void stopTracking() {
    timer?.cancel();
    isStartWorking.value = false;
    homeController.postDuty(isStartWorking.value);
    print('Tracking stopped');
  }

  Future<bool> _checkPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }
}
