import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:driver_onboarding/controller/homeController/home_controller.dart';
import 'package:driver_onboarding/controller/tripController/trip_controller.dart';
import 'package:driver_onboarding/screen/APPLICATIONS/rideScreen/ride_screen.dart';
import 'package:driver_onboarding/screen/ONBOARDING/kycScreens/kyc_info1_screen.dart';
import 'package:driver_onboarding/utils/appcolors/app_colors.dart';
import 'package:driver_onboarding/utils/constant/app_var.dart';
import 'package:driver_onboarding/utils/getStore/get_store.dart';
import 'package:driver_onboarding/utils/helper/helper.dart';
import 'package:driver_onboarding/widget/buttons/button.dart';
import 'package:driver_onboarding/widget/dilogue/user_dilogue.dart';
import 'package:driver_onboarding/widget/dropdownWidget/drop_down_widget.dart';
import 'package:driver_onboarding/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:socket_io_client/socket_io_client.dart' as client;

import '../../../controller/locationController/location_controller.dart';
import '../../../model/newTripRequest/new_trip_model.dart';

client.Socket socket = client.io(
  'http://ec2-3-109-123-180.ap-south-1.compute.amazonaws.com:3000',
  <String, dynamic>{
    'transports': ['websocket'],
    "autoConnect": true
  },
);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  TripController tripController = Get.put(TripController());
  HomeController homeController = Get.put(HomeController());
  @override
  void initState() {
    connectToServer();
    homeController.getDriverConfigration().then((val) {
      locationController.isStartWorking.value =
          homeController.configData!.isOnDuty!;
      locationController.isStartWorking.value
          ? locationController.startTracking()
          : locationController.stopTracking();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void connectToServer() {
    try {
      socket.connect();
      socket.onError((data) => log("message $data"));
      socket.onConnect((_) {
        log('++++++++++++++++++ onConnect ++++++++++++++++++++++++');
        socket.emit('register-driver', GetStoreData.getStore.read('id'));
      });

      socket.on("ride-request", (data) async {
        log("ride-request + $data");
        homeController.player.play(AssetSource('sound/telephone.mp3'));
        homeController.player.onPlayerComplete.listen((event) {
          homeController.player.play(
            AssetSource('sound/telephone.mp3'),
          );
        });
        TripDetailModel tripDetail = TripDetailModel.fromJson(data);
        tripController.tripData = tripDetail;
        Get.to(const RideScreen());
        tripController.currentStatus = RideStatus.newReq;
      });
      socket.on("restart-ride-status", (data) async {
        log("ride-request + $data");
        TripDetailModel tripDetail = TripDetailModel.fromJson(data);
        tripController.tripData = tripDetail;
        if (tripController.tripData!.status == "Accepted") {
          tripController.currentStatus = RideStatus.accept;
        } else if (tripController.tripData!.status == "PickingUp") {
          tripController.currentStatus = RideStatus.goForPickup;
        } else if (tripController.tripData!.status == "Ongoing") {
          tripController.currentStatus = RideStatus.startRide;
        }
        Get.to(const RideScreen());
      });
      socket.on("ride-request-cancel", (data) async {
        homeController.player.dispose();
        log("ride-request + $data");
        tripController.currentStatus = RideStatus.newReq;
        Get.offAll(const HomeScreen());
        AudioPlayer cancelPlayer = AudioPlayer();
        cancelPlayer.play(AssetSource('sound/alarm.mp3'));
      });

      // }
      // });

      socket.onDisconnect((_) {
        log('+++++++++++++++ disconnect ++++++++++++++++++++++++');
      });
      socket.on('fromServer', (_) => log(_));
    } catch (e) {
      log("><><><$e");
    }
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(
        GetStoreData.getStore.read('lat'), GetStoreData.getStore.read('long')),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => homeController.isLoading.value
            ? Helper.pageLoading()
            : SafeArea(
                child: Stack(
                  children: [
                    GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: _kGooglePlex,
                      zoomControlsEnabled: false,
                      myLocationEnabled: true,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: AppColors.whiteColor,
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const TextWidget(
                                      text: "Hey!",
                                      textSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    const SizedBox(height: 6),
                                    TextWidget(
                                      text:
                                          "${homeController.configData!.name}",
                                      textSize: 15,
                                      color: AppColors.primaryColor,
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    showUserPopUp(context);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(
                                        4), // Padding for shadow effect
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.white,
                                          Colors.grey[300]!
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white.withOpacity(
                                              0.8), // Light shadow on top-left
                                          blurRadius: 1,
                                          offset: Offset(5, 5),
                                        ),
                                        BoxShadow(
                                          color: Colors.black.withOpacity(
                                              0.4), // Dark shadow on bottom-right
                                          blurRadius: 10,
                                          offset: Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                    child: CircleAvatar(
                                      backgroundColor: AppColors.primaryColor,
                                      backgroundImage: NetworkImage(
                                          homeController
                                              .configData!.profileImg!),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const Divider(height: 1),
                        // isStartWorking ? vehicleAssigned() : assignedVehicle(),
                        const Spacer(),
                        Obx(() => homeController.isLoading.value
                            ? SizedBox()
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: homeController
                                        .configData!.onboardingCompleted!
                                    ? AppButton.primaryButton(
                                        onButtonPressed: () {
                                          locationController.isStartWorking.value
                                              ? locationController
                                                  .stopTracking()
                                              : locationController
                                                  .startTracking();
                                        },
                                        borderRadius: 10,
                                        bgColor: locationController
                                                .isStartWorking.value
                                            ? AppColors.redColor
                                            : AppColors.primaryColor,
                                        title: locationController
                                                .isStartWorking.value
                                            ? "Stop"
                                            : "Start Working")
                                    : AppButton.primaryButton(
                                        onButtonPressed: () {
                                          Get.to(() => const KYCInfo1Screen());
                                        },
                                        borderRadius: 10,
                                        bgColor: AppColors.primaryColor,
                                        title: "Complete Onboarding Process"),
                              )),
                        sizedTextfield,
                      ],
                    ),
                  ],
                ),
              ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     if (await Permission.storage.request().isGranted) {
      //       tripController.postBillingPDF();
      //     }
      //   },
      // ),
    );
  }

  LocationController locationController =
      Get.put(LocationController(), permanent: true);

  assignedVehicle() {
    return Container(
      color: AppColors.whiteColor.withOpacity(0.8),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextWidget(
              text: "Assign Vehicle",
              textSize: 16,
              fontWeight: FontWeight.w500,
            ),
            const SizedBox(height: 6),
            const TextWidget(
                text:
                    "Before going online, please select the vehicle category you want to work on. ",
                maxLine: 2,
                textSize: 12),
            const SizedBox(height: 6),
            Card(
              color: AppColors.whiteColor,
              surfaceTintColor: AppColors.whiteColor,
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    DropDownWidget(
                        status: "SEDAN",
                        color: AppColors.primaryColor.withOpacity(0.1),
                        statusList: ["SEDAN"],
                        circleVal: 10,
                        onChanged: (val) {}),
                    const SizedBox(height: 10),
                    DropDownWidget(
                        status: "Select a Car",
                        color: AppColors.primaryColor.withOpacity(0.1),
                        statusList: ["Select a Car"],
                        circleVal: 10,
                        onChanged: (val) {})
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  vehicleAssigned() {
    return Container(
      color: AppColors.whiteColor.withOpacity(0.8),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.grey3Color)),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: "Vehicle Assigned",
                    textSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 6),
                  TextWidget(
                      text:
                          "Click on go working screen and wait for the booking alerts",
                      textSize: 12),
                ],
              ),
            ),
            sizedTextfield,
            AppButton.primaryButton(
                onButtonPressed: () {
                  Get.to(() => const RideScreen());
                },
                borderRadius: 10,
                title: "Go Working"),
            sizedTextfield,
          ],
        ),
      ),
    );
  }
}
