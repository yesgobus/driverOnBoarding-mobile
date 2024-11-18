import 'package:driver_onboarding/controller/tripController/trip_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../utils/appcolors/app_colors.dart';
import '../../../utils/constant/png_asset_constant.dart';
import '../../../utils/helper/helper.dart';
import '../../../widget/buttons/button.dart';
import '../../../widget/textwidget/text_widget.dart';
import '../homeScreen/home_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TripController tripController = Get.put(TripController());

  // late bool isTrue;

  @override
  void initState() {
    tripController.postCompleteRide();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          body: SafeArea(
            child: Obx(
              () => tripController.isLoading.value
                  ? Helper.pageLoading()
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                height: 220,
                                width: Get.width,
                              ),
                              Positioned(
                                  top: -45,
                                  child: Image.asset(
                                    PngAssetPath.topRibbonImg,
                                    width: Get.width,
                                    color: AppColors.primaryColor,
                                    height: 230,
                                    fit: BoxFit.fill,
                                  )),
                              Positioned(
                                  top: 30,
                                  left: 20,
                                  right: 20,
                                  child: TextWidget(
                                      text: "Bill Payment",
                                      align: TextAlign.center,
                                      color: AppColors.whiteColor,
                                      textSize: 16)),
                              Positioned(
                                left: Get.width / 2 - 50,
                                top: 100,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.network(
                                      tripController
                                          .tripComplete.customerImage!,
                                      fit: BoxFit.fill,
                                      height: 100,
                                      width: 100,
                                    )),
                              ),
                            ],
                          ),
                          TextWidget(
                            text: tripController.tripComplete.customerName!,
                            textSize: 20,
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.bold,
                          ),
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        const SizedBox(width: 10),
                                        const Icon(Icons.circle,
                                            color: Colors.green),
                                        const SizedBox(width: 10),
                                        Flexible(
                                          child: TextWidget(
                                            text:
                                                '${tripController.tripComplete.pickupAddress}',
                                            textSize: 14,
                                            color: AppColors.black65,
                                            maxLine: 3,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    Row(
                                      children: [
                                        const SizedBox(width: 10),
                                        const Icon(Icons.circle,
                                            color: Colors.red),
                                        const SizedBox(width: 10),
                                        Flexible(
                                          child: TextWidget(
                                            text:
                                                '${tripController.tripComplete.dropAddress}',
                                            textSize: 14,
                                            color: AppColors.black65,
                                            maxLine: 3,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextWidget(
                                      text: "Bill Details".toUpperCase(),
                                      textSize: 16,
                                      color: AppColors.grey5Color,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextWidget(
                                      text: "Booking ID",
                                      textSize: 14,
                                      color: AppColors.blackColor,
                                    ),
                                    TextWidget(
                                      text:
                                          '${tripController.tripComplete.tripId}',
                                      textSize: 14,
                                      color: AppColors.blackColor,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextWidget(
                                      text: "Vehicle Number",
                                      textSize: 14,
                                      color: AppColors.blackColor,
                                    ),
                                    TextWidget(
                                      text:
                                          '${tripController.tripComplete.vehicleNumber}',
                                      textSize: 14,
                                      color: AppColors.blackColor,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextWidget(
                                      text: "Date",
                                      textSize: 14,
                                      color: AppColors.blackColor,
                                    ),
                                    TextWidget(
                                      text:
                                          '${tripController.tripComplete.dateTimeRide}',
                                      textSize: 14,
                                      color: AppColors.blackColor,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextWidget(
                                      text: "Distance Travelled",
                                      textSize: 14,
                                      color: AppColors.blackColor,
                                    ),
                                    TextWidget(
                                      text:
                                          '${tripController.tripComplete.distanceTravel}',
                                      textSize: 14,
                                      color: AppColors.blackColor,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextWidget(
                                      text: "Time Taken",
                                      textSize: 14,
                                      color: AppColors.blackColor,
                                    ),
                                    TextWidget(
                                      text:
                                          '${tripController.tripComplete.tripTime}',
                                      textSize: 14,
                                      color: AppColors.blackColor,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextWidget(
                                      text: "Distance Fare",
                                      textSize: 14,
                                      color: AppColors.blackColor,
                                    ),
                                    TextWidget(
                                      text:
                                          '${tripController.tripComplete.distanceFare}',
                                      textSize: 14,
                                      color: AppColors.blackColor,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextWidget(
                                      text: "Any additional km charge",
                                      textSize: 14,
                                      color: AppColors.blackColor,
                                    ),
                                    TextWidget(
                                      text:
                                          '${tripController.tripComplete.extraKmCharge}',
                                      textSize: 14,
                                      color: AppColors.blackColor,
                                    ),
                                  ],
                                ),
                                Divider(
                                  height: 30,
                                  color: AppColors.black45,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextWidget(
                                      text: "Total",
                                      textSize: 18,
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    TextWidget(
                                      text:
                                          '${tripController.tripComplete.totalAmount}',
                                      textSize: 18,
                                      color: AppColors.blackColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
          bottomNavigationBar: Obx(
            () => tripController.isLoading.value
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 6),
                    child: Row(
                      children: [
                        Expanded(
                          child: AppButton.primaryButton(
                              onButtonPressed: () {
                                Get.offAll(const HomeScreen());
                              },
                              title: "Done"),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: AppButton.primaryButton(
                              onButtonPressed: () async {
                                tripController.postBillingPDF();
                              },
                              bgColor: AppColors.redColor,
                              title: "Invoice"),
                        ),
                      ],
                    ),
                  ),
          )),
    );
  }
}
