import 'dart:async';
import 'dart:developer';

import 'package:driver_onboarding/controller/homeController/home_controller.dart';
import 'package:driver_onboarding/controller/tripController/trip_controller.dart';
import 'package:driver_onboarding/utils/appcolors/app_colors.dart';
import 'package:driver_onboarding/utils/constant/app_var.dart';
import 'package:driver_onboarding/utils/constant/png_asset_constant.dart';
import 'package:driver_onboarding/utils/helper/helper.dart';
import 'package:driver_onboarding/widget/buttons/button.dart';
import 'package:driver_onboarding/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../utils/getStore/get_store.dart';
import '../../../widget/text_field/otp_text_field.dart';
import '../paymentScreen/payment_screen.dart';

class RideScreen extends StatefulWidget {
  const RideScreen({super.key});

  @override
  State<RideScreen> createState() => _RideScreenState();
}

class _RideScreenState extends State<RideScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  TripController tripController = Get.put(TripController());
  HomeController homeController = Get.find();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(
        GetStoreData.getStore.read('lat'), GetStoreData.getStore.read('long')),
    zoom: 14.4746,
  );

  final Set<Polyline> _polylines = {};
  final List<LatLng> _polylineCoordinates = [];
  // late BitmapDescriptor customIcon;
  @override
  void initState() {
    super.initState();
    _createPolylines();
  }

  final Set<Marker> _markers = {};
  void _setCustomMarker() async {
    final BitmapDescriptor customMarker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(10, 10)),
      PngAssetPath.locationPinImg,
    );

    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('customMarker'),
          position: LatLng(
              double.parse(tripController.tripData!.dropLat!),
              double.parse(
                  tripController.tripData!.dropLng!)), // Example coordinates
          icon: customMarker,
        ),
      );
    });
  }

  PolylinePoints polylinePoints = PolylinePoints();
  PolylineResult result = PolylineResult();
  _createPolylines() async {
    try {
      result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey: googleAPIKey,
        request: PolylineRequest(
            origin: PointLatLng(
                double.parse(tripController.tripData!.pickupLat!),
                double.parse(tripController.tripData!.pickupLng!)),
            destination: PointLatLng(
                double.parse(tripController.tripData!.dropLat!),
                double.parse(tripController.tripData!.dropLng!)),
            mode: TravelMode.transit),
      );

      log("message${result.points}");
      result.points.forEach((PointLatLng point) {
        _polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      _polylines.add(Polyline(
        polylineId: const PolylineId('poly'),
        visible: true,
        points: _polylineCoordinates,
        width: 4,
        color: AppColors.primaryColor,
      ));
      _setCustomMarker();

      setState(() {});
    } catch (e) {
      log("message $e");
    }
  }

//  GoogleMapController? mapController;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              GoogleMap(
                zoomControlsEnabled: true,
                zoomGesturesEnabled: true,
                initialCameraPosition: _kGooglePlex,
                myLocationEnabled: true,
                markers: _markers,
                myLocationButtonEnabled: true,
                polylines: _polylines,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  //  mapController = controller;
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(10.0),
                  //   child: InkWell(
                  //     onTap: () {
                  //       Get.back();
                  //     },
                  //     child: CircleAvatar(
                  //       backgroundColor: AppColors.whiteColor,
                  //       child: const Icon(Icons.arrow_back),
                  //     ),
                  //   ),
                  // ),
                  if (tripController.currentStatus == null) waitingForOrder(),
                  if (tripController.currentStatus == RideStatus.newReq)
                    newRidesReq(),
                  if (tripController.currentStatus == RideStatus.accept)
                    ridesReqAccept(),
                  if (tripController.currentStatus == RideStatus.goForPickup)
                    otpReq(),
                  if (tripController.currentStatus == RideStatus.startRide)
                    ontheWay(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  waitingForOrder() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(12), topLeft: Radius.circular(12))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          const TextWidget(
              text: "Rides", textSize: 16, fontWeight: FontWeight.w500),
          const SizedBox(height: 8),
          const TextWidget(
              text: "You new booking cards show here", textSize: 15),
          sizedTextfield,
          AppButton.primaryButton(
              onButtonPressed: () {
                tripController.currentStatus = RideStatus.newReq;
                setState(() {});
              },
              title: "Open Floating Bubble",
              borderRadius: 10),
          sizedTextfield,
          AppButton.primaryButton(
              onButtonPressed: () {},
              title: "Wait For The Order !",
              borderRadius: 10),
          sizedTextfield,
        ],
      ),
    );
  }

  newRidesReq() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(12), topLeft: Radius.circular(12))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                  text: tripController.tripData!.isTransportRide!
                      ? "New Parcel Ride"
                      : "New Rides",
                  textSize: 16,
                  fontWeight: FontWeight.w500),
              TextWidget(
                text: "Today at ${tripController.tripData!.currentTime}",
                textSize: 14,
                fontWeight: FontWeight.w500,
              )
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: Get.width,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: AppColors.grey2Color,
                border: Border.all(color: AppColors.grey5Color),
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: "${tripController.tripData!.userName}",
                      textSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(height: 6),
                    TextWidget(
                      text:
                          "${tripController.tripData!.tripDistance}  ${tripController.tripData!.tripDuration}",
                      textSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                TextWidget(
                  text: "${tripController.tripData!.tripAmount}",
                  textSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),
              ],
            ),
          ),
          sizedTextfield,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 8,
                backgroundColor: AppColors.grey3Color,
                child: CircleAvatar(
                  backgroundColor: AppColors.greenColor,
                  radius: 5,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: tripController.tripData!.isTransportRide!
                          ? "Pick Parcel From"
                          : "Pickup From",
                      textSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    const SizedBox(height: 4),
                    TextWidget(
                        text: "${tripController.tripData!.pickupAddress}",
                        textSize: 12,
                        maxLine: 2,
                        fontWeight: FontWeight.w500),
                    const SizedBox(height: 4),
                    TextWidget(
                      text:
                          "${tripController.tripData!.pickupDistance} - ${tripController.tripData!.pickupDuration} Away",
                      textSize: 12,
                      fontWeight: FontWeight.w500,
                    )
                  ],
                ),
              )
            ],
          ),
          const Divider(height: 22),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 8,
                backgroundColor: AppColors.grey3Color,
                child: CircleAvatar(
                  backgroundColor: AppColors.redColor,
                  radius: 5,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: tripController.tripData!.isTransportRide!
                          ? "Drop Parcel At"
                          : "Drop From",
                      textSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    const SizedBox(height: 4),
                    TextWidget(
                        text: "${tripController.tripData!.dropAddress}",
                        textSize: 12,
                        maxLine: 2,
                        fontWeight: FontWeight.w500),
                    const SizedBox(height: 4),
                    TextWidget(
                      text:
                          "${tripController.tripData!.tripDistance} - ${tripController.tripData!.tripDuration} Away",
                      textSize: 12,
                      fontWeight: FontWeight.w500,
                    )
                  ],
                ),
              )
            ],
          ),
          sizedTextfield,
          Row(
            children: [
              Expanded(
                child: AppButton.primaryButton(
                    onButtonPressed: () {
                      homeController.player.dispose();

                      Helper.loader(context);
                      tripController
                          .postRideAccept(
                              isAccept: true,
                              rideID: tripController.tripData!.rideID!)
                          .then((val) {
                        setState(() {});
                      });
                    },
                    title: "Accept",
                    bgColor: AppColors.darkGreenColor,
                    borderRadius: 10),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: AppButton.primaryButton(
                    onButtonPressed: () {
                      Helper.loader(context);
                      homeController.player.dispose();

                      tripController
                          .postRideAccept(
                              isAccept: false,
                              rideID: tripController.tripData!.rideID!)
                          .then((val) {
                        setState(() {});
                      });
                    },
                    title: "Reject",
                    bgColor: AppColors.redColor,
                    borderRadius: 10),
              ),
            ],
          ),
          sizedTextfield,
        ],
      ),
    );
  }

  ridesReqAccept() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(12), topLeft: Radius.circular(12))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          const TextWidget(
              text: "Go for pickup", textSize: 16, fontWeight: FontWeight.w500),
          const SizedBox(height: 12),
          Container(
            width: Get.width,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: AppColors.grey2Color,
                border: Border.all(color: AppColors.grey5Color),
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: "${tripController.tripData!.userName}",
                      textSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(height: 6),
                    TextWidget(
                      text:
                          "${tripController.tripData!.tripDistance}  ${tripController.tripData!.tripDuration}",
                      textSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
                TextWidget(
                  text: "${tripController.tripData!.tripAmount}",
                  textSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),
              ],
            ),
          ),
          sizedTextfield,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 8,
                backgroundColor: AppColors.grey3Color,
                child: CircleAvatar(
                  backgroundColor: AppColors.greenColor,
                  radius: 5,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: tripController.tripData!.isTransportRide!
                          ? "Pick Parcel From"
                          : "Pickup From",
                      textSize: 13,
                      maxLine: 2,
                      fontWeight: FontWeight.w500,
                    ),
                    const SizedBox(height: 4),
                    TextWidget(
                        text: "${tripController.tripData!.pickupAddress}",
                        textSize: 12,
                        maxLine: 2,
                        fontWeight: FontWeight.w500),
                    const SizedBox(height: 4),
                    TextWidget(
                      text:
                          "${tripController.tripData!.pickupDistance} - ${tripController.tripData!.pickupDuration} Away",
                      textSize: 12,
                      fontWeight: FontWeight.w500,
                    )
                  ],
                ),
              )
            ],
          ),
          const Divider(height: 22),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 8,
                backgroundColor: AppColors.grey3Color,
                child: CircleAvatar(
                  backgroundColor: AppColors.redColor,
                  radius: 5,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: tripController.tripData!.isTransportRide!
                          ? "Drop Parcel At"
                          : "Drop From",
                      textSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    const SizedBox(height: 4),
                    TextWidget(
                        text: "${tripController.tripData!.dropAddress}",
                        textSize: 12,
                        maxLine: 2,
                        fontWeight: FontWeight.w500),
                    const SizedBox(height: 4),
                    TextWidget(
                      text:
                          "${tripController.tripData!.tripDistance} - ${tripController.tripData!.tripDuration} Away",
                      textSize: 12,
                      fontWeight: FontWeight.w500,
                    )
                  ],
                ),
              )
            ],
          ),
          sizedTextfield,
          Row(
            children: [
              Expanded(
                child: AppButton.primaryButton(
                    onButtonPressed: () {
                      Helper.launchPhone(tripController.tripData!.userPhone!);
                    },
                    title: "Call",
                    bgColor: AppColors.darkGreenColor,
                    borderRadius: 10),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: AppButton.primaryButton(
                    onButtonPressed: () {
                      tripController
                          .postGoForPickup(tripController.tripData!.rideID!)
                          .then((val) {
                        setState(() {});
                      });
                    },
                    title: "Go for pickup",
                    borderRadius: 10),
              ),
            ],
          ),
          sizedTextfield,
        ],
      ),
    );
  }

  otpReq() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(12), topLeft: Radius.circular(12))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          const TextWidget(
              text: "On the way to pickup",
              textSize: 16,
              fontWeight: FontWeight.w500),
          sizedTextfield,
          const Center(
            child: TextWidget(
                text: "Enter OTP", textSize: 16, fontWeight: FontWeight.w500),
          ),
          sizedTextfield,
          Center(
            child: OtpTextField(
              pinLength: 4,
              controller: otpcontroller,
              onCompleted: (String st) {},
            ),
          ),
          sizedTextfield,
          sizedTextfield,
          Row(
            children: [
              Expanded(
                child: AppButton.primaryButton(
                    onButtonPressed: () {
                      Helper.launchPhone(tripController.tripData!.userPhone!);
                    },
                    title: "Call",
                    bgColor: AppColors.darkGreenColor,
                    borderRadius: 10),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: AppButton.primaryButton(
                    onButtonPressed: () {
                      tripController
                          .postStartRide(tripController.tripData!.rideID!,
                              otpcontroller.text)
                          .then((val) {
                        setState(() {});
                      });
                    },
                    title: "Start Ride",
                    borderRadius: 10),
              ),
            ],
          ),
          sizedTextfield,
        ],
      ),
    );
  }

  ontheWay() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(12), topLeft: Radius.circular(12))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                  text: "On The Way",
                  textSize: 16,
                  fontWeight: FontWeight.w500),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: Get.width,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: AppColors.grey2Color,
                border: Border.all(color: AppColors.grey5Color),
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: tripController.tripData!.isTransportRide!
                      ? "Receiver: ${tripController.tripData!.receiverName} "
                      : "${tripController.tripData!.userName}",
                  textSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),
                if (tripController.tripData!.isTransportRide!)
                  const SizedBox(height: 6),
                if (tripController.tripData!.isTransportRide!)
                  InkWell(
                    onTap: () {
                      Helper.launchPhone(
                          tripController.tripData!.receiverNumber!);
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                            backgroundColor: Colors.green.shade600,
                            radius: 10,
                            child: Icon(Icons.call,
                                color: AppColors.whiteColor, size: 12)),
                        SizedBox(width: 4),
                        TextWidget(
                          text: "${tripController.tripData!.receiverNumber}",
                          textSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor,
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 6),
                TextWidget(
                  text:
                      "${tripController.tripData!.tripDistance}  ${tripController.tripData!.tripDuration}",
                  textSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                const SizedBox(height: 6),
                TextWidget(
                  text: "${tripController.tripData!.tripAmount}",
                  textSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),
              ],
            ),
          ),
          sizedTextfield,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 8,
                backgroundColor: AppColors.grey3Color,
                child: CircleAvatar(
                  backgroundColor: AppColors.redColor,
                  radius: 5,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: tripController.tripData!.isTransportRide!
                          ? "Drop Parcel At"
                          : "Drop From",
                      textSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    const SizedBox(height: 4),
                    TextWidget(
                        text: "${tripController.tripData!.dropAddress}",
                        textSize: 12,
                        maxLine: 2,
                        fontWeight: FontWeight.w500),
                    const SizedBox(height: 4),
                    TextWidget(
                      text:
                          "${tripController.tripData!.tripDistance} - ${tripController.tripData!.tripDuration} Away",
                      textSize: 12,
                      fontWeight: FontWeight.w500,
                    )
                  ],
                ),
              )
            ],
          ),
          sizedTextfield,
          Row(
            children: [
              Expanded(
                child: AppButton.primaryButton(
                    onButtonPressed: () {
                      Get.to(() => PaymentScreen());
                    },
                    title: tripController.tripData!.isTransportRide!
                        ? "Parcel Delivered"
                        : "Complete Ride",
                    bgColor: AppColors.darkGreenColor,
                    borderRadius: 10),
              ),
            ],
          ),
          sizedTextfield,
        ],
      ),
    );
  }

  TextEditingController otpcontroller = TextEditingController();
}

enum RideStatus {
  newReq,
  accept,
  reject,
  goForPickup,
  startRide,
  completeRide,
}
