// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables


import 'package:driver_onboarding/screen/ONBOARDING/kycScreens/otp_page_aadhar.dart';
import 'package:driver_onboarding/controller/kycController/myKYC_controller.dart';
import 'package:driver_onboarding/utils/appcolors/app_colors.dart';
import 'package:driver_onboarding/utils/constant/app_var.dart';
import 'package:driver_onboarding/utils/getStore/get_store.dart';
import 'package:driver_onboarding/utils/helper/helper_sncksbar.dart';
import 'package:driver_onboarding/widget/appbar/appbar.dart';
import 'package:driver_onboarding/widget/text_field/text_field.dart';
import 'package:driver_onboarding/widget/textwidget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/helper/helper.dart';
import '../../../widget/buttons/button.dart';
import '../../../widget/datePicker/datePicker.dart';

class CompleteKYCScreen extends StatefulWidget {
  const CompleteKYCScreen({super.key});

  @override
  State<CompleteKYCScreen> createState() => _CompleteKYCScreenState();
}

class _CompleteKYCScreenState extends State<CompleteKYCScreen>
    with SingleTickerProviderStateMixin {
  MyKYCController kycController = Get.put(MyKYCController());
  late TabController _tabController;
  GlobalKey<FormState> formkey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // Initialize the TabController
    kycController.nameController.text = GetStoreData.getStore.read('name');
    kycController.emailController.text = GetStoreData.getStore.read('email');
    kycController.mobileController.text = GetStoreData.getStore.read('phone');
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey2Color,
      appBar: HelperAppBar.appbarHelper(
          title: "Complete KYC", hideBack: true, bgColor: AppColors.grey2Color),
      body: DefaultTabController(
        length: 3,
        child: Form(
          key: formkey,
          child: Column(
            children: [
              TabBar(
                controller: _tabController,
                labelColor: AppColors.primaryColor,
                unselectedLabelColor: AppColors.grey5Color,
                padding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero, dividerHeight: 0,
                indicator: BoxDecoration(), // No indicator
                tabs: [
                  Tab(text: 'Personal Details'),
                  Tab(text: 'ID Proof'),
                  Tab(text: 'Bank Details'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    SingleChildScrollView(
                        child: SizedBox(
                      height: 636,
                      child: Container(
                        margin: EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                offset:
                                    Offset(0, -2), // Offset in the y-direction
                                blurRadius: 2,
                                spreadRadius: 2,
                              ),
                            ],
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            )),
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              text: "Enter Your Details",
                              textSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: 12),
                            MyCustomTextField.textField(
                                borderClr: AppColors.black45,
                                hintText: "Full Name",
                                valText: "Enter Full Name",
                                controller: kycController.nameController),
                            sizedTextfield,
                            MyCustomTextField.textField(
                                borderClr: AppColors.black45,
                                hintText: "Mobile",
                                valText: "Enter Mobile Number",
                                textInputType: TextInputType.phone,
                                controller: kycController.mobileController),
                            sizedTextfield,
                            MyCustomTextField.textField(
                                borderClr: AppColors.black45,
                                hintText: "Email",
                                valText: "Enter Email",
                                controller: kycController.emailController),
                            sizedTextfield,
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, bottom: 14, top: 8),
                              child: AppButton.primaryButton(
                                  onButtonPressed: () {
                                    if (formkey.currentState!.validate()) {
                                      kycController.userDetailPost(context);
                                      _tabController.animateTo(1);
                                    }
                                  },
                                  title: "Next"),
                            ),
                          ],
                        ),
                      ),
                    )),
                    SingleChildScrollView(
                      child: SizedBox(
                        height: 810,
                        child: Container(
                          margin: EdgeInsets.only(top: 8),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  offset: Offset(
                                      0, -2), // Offset in the y-direction
                                  blurRadius: 2,
                                  spreadRadius: 2,
                                ),
                              ],
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25),
                              )),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: "Enter Your Documents Details",
                                textSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(height: 4),
                              Card(
                                color: AppColors.whiteColor,
                                surfaceTintColor: AppColors.whiteColor,
                                elevation: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                        text: "Aadhar Details",
                                        textSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      SizedBox(height: 12),
                                      Obx(
                                        () => Row(
                                          children: [
                                            Expanded(
                                              child:
                                                  MyCustomTextField.textField(
                                                      borderClr:
                                                          AppColors.black45,
                                                      hintText: "Aadhar Number",
                                                      maxLength: 12,
                                                      textInputType:
                                                          TextInputType.number,
                                                      suffixIcon: InkWell(
                                                        onTap: () {
                                                          kycController
                                                              .aadharSentOtpPost(
                                                                  context)
                                                              .then((value) {
                                                            if (value) {
                                                              Get.to(OtpPageAadhar())!
                                                                  .whenComplete(
                                                                      () {
                                                                setState(() {});
                                                              });
                                                            }
                                                          });
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal: 2,
                                                                  vertical: 4),
                                                          child: SizedBox(
                                                            width: 60,
                                                            child: Card(
                                                              color: AppColors
                                                                  .primaryColor,
                                                              surfaceTintColor:
                                                                  AppColors
                                                                      .primaryColor,
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        8.0,
                                                                    vertical:
                                                                        4),
                                                                child: Center(
                                                                  child: TextWidget(
                                                                      text:
                                                                          "Verify",
                                                                      color: AppColors
                                                                          .whiteColor,
                                                                      textSize:
                                                                          14),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      controller: kycController
                                                          .aadharController),
                                            ),
                                            if (kycController
                                                .isAadharVerify.value)
                                              SizedBox(width: 8),
                                            if (kycController
                                                .isAadharVerify.value)
                                              Icon(
                                                Icons.verified,
                                                color: AppColors.greenColor,
                                              )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 4),
                              Card(
                                elevation: 4,
                                color: AppColors.whiteColor,
                                surfaceTintColor: AppColors.whiteColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                        text: "PAN Details",
                                        textSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      SizedBox(height: 12),
                                      MyCustomTextField.textField(
                                          borderClr: AppColors.black45,
                                          hintText:
                                              "Full Name (As Per PAN Card)",
                                          controller:
                                              kycController.namePanController),
                                      sizedTextfield,
                                      MyCustomTextField.textField(
                                          borderClr: AppColors.black45,
                                          hintText: "DOB",
                                          readonly: true,
                                          suffixIcon: Icon(
                                            Icons.calendar_month,
                                            color: AppColors.black45,
                                          ),
                                          onTap: () {
                                            selectDate(context, DateTime.now())
                                                .then((value) {
                                              kycController
                                                      .dobPanController.text =
                                                  Helper.formatDate(
                                                      date: value.toString(),
                                                      type: 'dd MMM, E');
                                              kycController.dobPostPAN =
                                                  Helper.formatDatePost(
                                                      value.toString());

                                              setState(() {});
                                            });
                                          },
                                          controller:
                                              kycController.dobPanController),
                                      sizedTextfield,
                                      Row(
                                        children: [
                                          Expanded(
                                            child: MyCustomTextField.textField(
                                              borderClr: AppColors.black45,
                                              hintText: "PAN Number",
                                              controller:
                                                  kycController.panController,
                                              suffixIcon: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 2,
                                                        vertical: 4),
                                                child: SizedBox(
                                                  width: 60,
                                                  child: InkWell(
                                                    onTap: () {
                                                      kycController
                                                          .panVerifyPost(
                                                              context)
                                                          .then((value) =>
                                                              setState(() {}));
                                                    },
                                                    child: Card(
                                                      color: AppColors
                                                          .primaryColor,
                                                      surfaceTintColor:
                                                          AppColors
                                                              .primaryColor,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 8.0,
                                                                vertical: 4),
                                                        child: Center(
                                                          child: TextWidget(
                                                              text: "Verify",
                                                              color: AppColors
                                                                  .whiteColor,
                                                              textSize: 14),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (kycController.isPanVerify.value)
                                            SizedBox(width: 8),
                                          if (kycController.isPanVerify.value)
                                            Icon(
                                              Icons.verified,
                                              color: AppColors.greenColor,
                                            )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 4),
                              Card(
                                  elevation: 4,
                                  color: AppColors.whiteColor,
                                  surfaceTintColor: AppColors.whiteColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                          text: "DL Details",
                                          textSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        SizedBox(height: 12),
                                        MyCustomTextField.textField(
                                            hintText: "DOB",
                                            borderClr: AppColors.black45,
                                            readonly: true,
                                            suffixIcon: Icon(
                                              Icons.calendar_month,
                                              color: AppColors.black45,
                                            ),
                                            onTap: () {
                                              selectDate(
                                                      context, DateTime.now())
                                                  .then((value) {
                                                kycController
                                                        .dobDlController.text =
                                                    Helper.formatDate(
                                                        date: value.toString(),
                                                        type: 'dd MMM, E');
                                                kycController.dobPostDL =
                                                    Helper.formatDatePost(
                                                        value.toString());

                                                setState(() {});
                                              });
                                            },
                                            controller:
                                                kycController.dobDlController),
                                        sizedTextfield,
                                        Row(
                                          children: [
                                            Expanded(
                                              child:
                                                  MyCustomTextField.textField(
                                                borderClr: AppColors.black45,
                                                hintText: "DL Number",
                                                controller:
                                                    kycController.dlController,
                                                suffixIcon: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 2,
                                                      vertical: 4),
                                                  child: SizedBox(
                                                    width: 60,
                                                    child: InkWell(
                                                      onTap: () {
                                                        kycController
                                                            .dlVerifyPost(
                                                                context)
                                                            .then((value) =>
                                                                setState(
                                                                    () {}));
                                                      },
                                                      child: Card(
                                                        color: AppColors
                                                            .primaryColor,
                                                        surfaceTintColor:
                                                            AppColors
                                                                .primaryColor,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      8.0,
                                                                  vertical: 4),
                                                          child: Center(
                                                            child: TextWidget(
                                                                text: "Verify",
                                                                color: AppColors
                                                                    .whiteColor,
                                                                textSize: 14),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            if (kycController.isDlVerify.value)
                                              SizedBox(width: 8),
                                            if (kycController.isDlVerify.value)
                                              Icon(
                                                Icons.verified,
                                                color: AppColors.greenColor,
                                              )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                              SizedBox(height: 4),
                              Card(
                                  elevation: 4,
                                  color: AppColors.whiteColor,
                                  surfaceTintColor: AppColors.whiteColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                          text: "RC Verification",
                                          textSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        SizedBox(height: 12),
                                        Row(
                                          children: [
                                            Expanded(
                                              child:
                                                  MyCustomTextField.textField(
                                                borderClr: AppColors.black45,
                                                hintText: "RC Verification",
                                                controller:
                                                    kycController.rcController,
                                                suffixIcon: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 2,
                                                      vertical: 4),
                                                  child: SizedBox(
                                                    width: 60,
                                                    child: InkWell(
                                                      onTap: () {
                                                        kycController
                                                            .rcVerifyPost(
                                                                context)
                                                            .then((value) =>
                                                                setState(
                                                                    () {}));
                                                      },
                                                      child: Card(
                                                        color: AppColors
                                                            .primaryColor,
                                                        surfaceTintColor:
                                                            AppColors
                                                                .primaryColor,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      8.0,
                                                                  vertical: 4),
                                                          child: Center(
                                                            child: TextWidget(
                                                                text: "Verify",
                                                                color: AppColors
                                                                    .whiteColor,
                                                                textSize: 14),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            if (kycController.isRCVerify.value)
                                              SizedBox(width: 8),
                                            if (kycController.isRCVerify.value)
                                              Icon(
                                                Icons.verified,
                                                color: AppColors.greenColor,
                                              )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, bottom: 14, top: 8),
                                child: AppButton.primaryButton(
                                    onButtonPressed: () {
                                      _tabController.animateTo(2);
                                    },
                                    title: "Next"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                        child: SizedBox(
                      height: 636,
                      child: Container(
                        margin: EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                offset:
                                    Offset(0, -2), // Offset in the y-direction
                                blurRadius: 2,
                                spreadRadius: 2,
                              ),
                            ],
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            )),
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              text: "Enter Account Details",
                              textSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: 12),
                            SizedBox(
                              height: 38,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextWidget(
                                      text: "Account Type",
                                      textSize: 15,
                                      fontWeight: FontWeight.w500),
                                  SizedBox(width: 8),
                                  ListView.separated(
                                    separatorBuilder: (context, index) {
                                      return SizedBox(width: 8);
                                    },
                                    itemCount: 2,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return SizedBox(
                                        width: 90,
                                        child: AppButton.primaryButton(
                                            height: 30,
                                            bgColor:
                                                kycController.selectAccIndex ==
                                                        index
                                                    ? AppColors.primaryColor
                                                    : AppColors.primaryColor
                                                        .withOpacity(0.2),
                                            textColor:
                                                kycController.selectAccIndex ==
                                                        index
                                                    ? AppColors.whiteColor
                                                    : AppColors.blackColor,
                                            fontSize: 12,
                                            onButtonPressed: () {
                                              kycController.selectAccIndex =
                                                  index;
                                              setState(() {});
                                            },
                                            title: accType[index]),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12),
                            MyCustomTextField.textField(
                                borderClr: AppColors.black45,
                                hintText: "Account Holder Name",
                                valText: "Enter Account Holder Name",
                                controller:
                                    kycController.accHoldernameController),
                            sizedTextfield,
                            MyCustomTextField.textField(
                                borderClr: AppColors.black45,
                                hintText: "Account Number",
                                obcureText: true,
                                valText: "Enter Account Number",
                                textInputType: TextInputType.number,
                                controller: kycController.accNumController),
                            sizedTextfield,
                            MyCustomTextField.textField(
                                borderClr: AppColors.black45,
                                hintText: "Enter Again Account Number",
                                valText: "Confirm Account Number",
                                textInputType: TextInputType.number,
                                controller:
                                    kycController.reenterAccNumController),
                            sizedTextfield,
                            MyCustomTextField.textField(
                                borderClr: AppColors.black45,
                                hintText: "IFSC Code",
                                valText: "Enter IFSC Code",
                                controller: kycController.ifscController),
                            sizedTextfield,
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, bottom: 14, top: 8),
                              child: AppButton.primaryButton(
                                  onButtonPressed: () {
                                    if (formkey.currentState!.validate()) {
                                      if (kycController.accNumController.text ==
                                          kycController
                                              .reenterAccNumController.text) {
                                        kycController.bankDetailPost(context);
                                      } else {
                                        HelperSnackBar.snackBar("Error",
                                            "Please Match Account Number");
                                      }
                                      // Get.to(const UploadDocumentScreen());
                                    }
                                    // Get.to(PersonalInfoScreen());
                                  },
                                  title: "Next"),
                            ),
                          ],
                        ),
                      ),
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  var aadharimgFront = "";
  var aadharimgBack = "";
  var panimgFront = "";
  var panimgBack = "";
  var dlimgFront = "";
  var dlimgBack = "";
  // _generateChildren() {
  //   List<Widget> children = [];
  //   // Generate children widgets
  //   for (int i = 0; i < docType.length; i++) {
  //     children.add(SizedBox(
  //       width: 128,
  //       child: AppButton.primaryButton(
  //           height: 35,
  //           bgColor: selectDocIndex == i
  //               ? AppColors.primaryColor
  //               : AppColors.primaryColor.withOpacity(0.2),
  //           textColor: selectDocIndex == i
  //               ? AppColors.whiteColor
  //               : AppColors.blackColor,
  //           fontSize: 12,
  //           onButtonPressed: () {
  //             selectDocIndex = i;
  //             setState(() {});
  //           },
  //           title: docType[i]),
  //     ));
  //   }
  //   return children;
  // }

  int selectDocIndex = 0;
  List docType = ["Aadhar Card", "Pan Card", "Driving License"];

  List accType = ["Saving", "Current"];
}
        //  Container(
        //             margin: EdgeInsets.only(top: 8),
        //             decoration: BoxDecoration(
        //                 boxShadow: [
        //                   BoxShadow(
        //                     color: Colors.black.withOpacity(0.1),
        //                     offset: Offset(0, -2), // Offset in the y-direction
        //                     blurRadius: 2,
        //                     spreadRadius: 2,
        //                   ),
        //                 ],
        //                 color: AppColors.whiteColor,
        //                 borderRadius: BorderRadius.only(
        //                   topLeft: Radius.circular(25),
        //                   topRight: Radius.circular(25),
        //                 )),
        //             padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        //             child: Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 TextWidget(
        //                   text: "Choose Document Type",
        //                   textSize: 18,
        //                   fontWeight: FontWeight.w500,
        //                 ),
        //                 SizedBox(height: 12),
        //                 Wrap(
        //                     spacing: 8.0,
        //                     runSpacing: 8.0,
        //                     alignment: WrapAlignment.start,
        //                     children: _generateChildren()),
        //                 SizedBox(height: 22),
        //                 TextWidget(
        //                   text: "Upload ID Proof",
        //                   textSize: 18,
        //                   fontWeight: FontWeight.w500,
        //                 ),
        //                 SizedBox(height: 8),
        //                 TextWidget(
        //                   text:
        //                       "Submit the pan card in a plain dark surface and make sure it’s visible your documents",
        //                   textSize: 12,
        //                   maxLine: 2,
        //                   color: AppColors.black45,
        //                 ),
        //                 SizedBox(height: 22),
        //                 Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     InkWell(
        //                       onTap: () {
        //                         showUploadPopup(
        //                             context: context,
        //                             title: "Front",
        //                             onTap: (val) {
        //                               if (selectDocIndex == 0) {
        //                                 aadharimgFront = val;
        //                               } else if (selectDocIndex == 1) {
        //                                 panimgFront = val;
        //                               } else if (selectDocIndex == 2) {
        //                                 dlimgFront = val;
        //                               }
        //                               setState(() {});
        //                               Get.back();
        //                             });
        //                       },
        //                       child: Container(
                                
        //                         height: 150,
        //                         width: Get.width / 2 - 18,
        //                         decoration: BoxDecoration(
        //                            boxShadow: [
        //                               BoxShadow(
        //                                 color: Colors.grey
        //                                     .withOpacity(0.3), // shadow color
        //                                 spreadRadius: 1, // spread radius
        //                                 blurRadius: 5, // blur radius
        //                                 offset: Offset(
        //                                     0, 3), // changes position of shadow
        //                               ),
        //                             ],
        //                             color: AppColors.whiteColor,
        //                             border: Border.all(color: Colors.black12),
        //                             borderRadius: BorderRadius.circular(8),
        //                             image: DecorationImage(
        //                                 image: MemoryImage(
        //                                     base64Decode(selectDocIndex == 0
        //                                         ? aadharimgFront
        //                                         : selectDocIndex == 1
        //                                             ? panimgFront
        //                                             : dlimgFront)),
        //                                 fit: BoxFit.cover)),
        //                         child: Column(
        //                           mainAxisAlignment: MainAxisAlignment.center,
        //                           children: [
        //                             Icon(
        //                               Icons.camera_alt_outlined,
        //                               color: AppColors.primaryColor,
        //                               size: 30,
        //                             ),
        //                             SizedBox(height: 12),
        //                             TextWidget(
        //                               text: "Front",
        //                               textSize: 16,
        //                               fontWeight: FontWeight.w500,
        //                             )
        //                           ],
        //                         ),
        //                       ),
        //                     ),
        //                     SizedBox(width: 12),
        //                     InkWell(
        //                       onTap: () {
        //                         showUploadPopup(
        //                             context: context,
        //                             title: "Back",
        //                             onTap: (val) {
        //                               if (selectDocIndex == 0) {
        //                                 aadharimgBack = val;
        //                               } else if (selectDocIndex == 1) {
        //                                 panimgBack = val;
        //                               } else if (selectDocIndex == 2) {
        //                                 dlimgBack = val;
        //                               }
        //                               setState(() {});
        //                               Get.back();
        //                             });
        //                       },
        //                       child: Container(
        //                         height: 150,
        //                         width: Get.width / 2 - 18,
        //                         decoration: BoxDecoration(
        //                             boxShadow: [
        //                               BoxShadow(
        //                                 color: Colors.grey
        //                                     .withOpacity(0.3), // shadow color
        //                                 spreadRadius: 1, // spread radius
        //                                 blurRadius: 5, // blur radius
        //                                 offset: Offset(
        //                                     0, 3), // changes position of shadow
        //                               ),
        //                             ],
        //                             color: AppColors.whiteColor,
        //                             border: Border.all(color: Colors.black12),
        //                             borderRadius: BorderRadius.circular(8),
        //                             image: DecorationImage(
        //                                 image: MemoryImage(
        //                                     base64Decode(selectDocIndex == 0
        //                                         ? aadharimgBack
        //                                         : selectDocIndex == 1
        //                                             ? panimgBack
        //                                             : dlimgBack)),
        //                                 fit: BoxFit.cover)),
        //                         child: Column(
        //                           mainAxisAlignment: MainAxisAlignment.center,
        //                           children: [
        //                             Icon(
        //                               Icons.camera_alt_outlined,
        //                               color: AppColors.primaryColor,
        //                               size: 30,
        //                             ),
        //                             SizedBox(height: 12),
        //                             TextWidget(
        //                               text: "Back",
        //                               textSize: 16,
        //                               fontWeight: FontWeight.w500,
        //                             )
        //                           ],
        //                         ),
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //                 Spacer(),
        //                 Padding(
        //                   padding: const EdgeInsets.only(
        //                       left: 8, right: 8, bottom: 14, top: 8),
        //                   child: AppButton.primaryButton(
        //                       onButtonPressed: () {
        //                         _tabController.animateTo(2);
        //                       },
        //                       title: "Next"),
        //                 ),
        //               ],
        //             ),
        //           ),
         