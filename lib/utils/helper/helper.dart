import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Helper {
  static String formatPrice(String text) {
    return "\u{20B9} $text";
  }

  static String formatDate({String? type, required String date}) {
    return DateFormat(type ?? "dd-MM-yyy").format(DateTime.parse(date));
  }

  static String formatDatePost(String date) {
    return DateFormat("yyyy-MM-dd").format(DateTime.parse(date));
  }

  static imageLoader() {
    return Container(
        color: Colors.black12,
        child: const SpinKitThreeBounce(size: 18, color: Colors.black));
  }

  static pageLoading() {
    return Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: const SpinKitThreeBounce(size: 30, color: Colors.black));
  }

  static Widget spinLoading() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: SpinKitThreeBounce(size: 30, color: Colors.black),
    );
  }

  static loader(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const SpinKitThreeBounce(size: 30, color: Colors.white);
      },
    );
  }

  static getDilogueLoader() {
    Get.defaultDialog(
        title: "",
        titlePadding: EdgeInsets.all(0),
        backgroundColor: Colors.transparent,
        content: SpinKitThreeBounce(size: 30, color: Colors.white));
  }

  // Function to launch the phone dialer
  static launchPhone(String phoneNumber) async {
    if (await canLaunch("tel:$phoneNumber")) {
      await launch("tel:$phoneNumber");
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  // Function to launch the mail app
  static launchMail(String mailAddress) async {
    if (await canLaunch("mailto:$mailAddress")) {
      await launch("mailto:$mailAddress");
    } else {
      throw 'Could not launch $mailAddress';
    }
  }
}
