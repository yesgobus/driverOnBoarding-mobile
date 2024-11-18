import 'package:driver_onboarding/controller/homeController/home_controller.dart';
import 'package:driver_onboarding/widget/dilogue/delete_dilogue.dart';
import 'package:driver_onboarding/widget/dilogue/logout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../screen/ONBOARDING/loginScreens/login_page.dart';
import '../../utils/appcolors/app_colors.dart';
import '../../utils/getStore/get_store.dart';
import '../textWidget/text_widget.dart';

Future<bool> showUserPopUp(BuildContext context) async {
  HomeController homeController = Get.find();
  return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            contentPadding: const EdgeInsets.all(0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16)),
                        color: AppColors.greyLightColor,
                        border:
                            Border.all(color: AppColors.whiteColor, width: 0)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextWidget(
                              text: "${homeController.configData!.name}",
                              textSize: 16,
                              maxLine: 2,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 12),
                          CircleAvatar(
                            backgroundColor: AppColors.primaryColor,
                            backgroundImage: NetworkImage(
                                homeController.configData!.profileImg!),
                          ),
                        ],
                      ),
                    )),
                ListTile(
                    onTap: () {
                      Get.back();
                      showLogoutPopup(context);
                    },
                    trailing: const Icon(
                      Icons.logout,
                      size: 22,
                    ),
                    title: const TextWidget(text: "Logout", textSize: 14)),
                ListTile(onTap: () {
                      Get.back();
                      showDeletePopup(context);
                    },
                    trailing: const Icon(
                      Icons.delete_outline_outlined,
                      size: 24,
                    ),
                    title: const TextWidget(text: "Delete", textSize: 14)),
                Divider(
                  color: AppColors.grey3Color,
                  height: 0,
                  thickness: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: SizedBox(
                          height: 45,
                          child: Center(
                            child: TextWidget(
                              text: "cancel".toUpperCase(),
                              color: Colors.black54,
                              textSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ));
}
