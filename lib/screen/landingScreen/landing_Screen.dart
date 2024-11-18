import 'package:driver_onboarding/screen/APPLICATIONS/accountScreen/account_screen.dart';
import 'package:driver_onboarding/screen/APPLICATIONS/homeScreen/home_screen.dart';
import 'package:driver_onboarding/screen/APPLICATIONS/walletScreen/wallet_screen.dart';
import 'package:flutter/material.dart';

import '../../utils/appcolors/app_colors.dart';
import '../../widget/textwidget/text_widget.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({
    super.key,
  });

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  List icons = [
    Icons.home_outlined,
    Icons.wallet,
    Icons.person_outline,
  ];
  List title = [
    "Home",
    "Wallet",
    "Account",
  ];
  List screen = [HomeScreen(), WalletScreen(), AccountScreen()];
  int selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Container(
        height: 58,
        padding: EdgeInsets.only(top: 8, bottom: 6, left: 20, right: 20),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            icons.length,
            (index) => InkWell(
              onTap: () {
                selectIndex = index;
                setState(() {});
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icons[index],
                    size: 27,
                    color: selectIndex == index
                        ? AppColors.primaryColor
                        : AppColors.blackColor,
                  ),
                  SizedBox(height: 5),
                  TextWidget(
                    text: title[index],
                    textSize: 11,
                    color: selectIndex == index
                        ? AppColors.primaryColor
                        : AppColors.blackColor,
                    maxLine: 2,
                    align: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: screen[selectIndex],
    );
  }

  // int currentTab() => widget.navigationShell.currentIndex;

  // void _goBranch(int index) {
  //   widget.navigationShell.goBranch(
  //     index,
  //     initialLocation: index == widget.navigationShell.currentIndex,
  //   );
  // }
}
