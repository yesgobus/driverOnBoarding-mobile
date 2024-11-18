import 'package:driver_onboarding/utils/constant/png_asset_constant.dart';
import 'package:driver_onboarding/utils/helper/helper.dart';
import 'package:driver_onboarding/widget/appbar/appbar.dart';
import 'package:driver_onboarding/widget/textwidget/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FAQSScreen extends StatefulWidget {
  const FAQSScreen({super.key});

  @override
  State<FAQSScreen> createState() => _FAQSScreenState();
}

class _FAQSScreenState extends State<FAQSScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HelperAppBar.appbarHelper(title: "FAQ Popup", hideBack: true),
      body: Column(
        children: [
          Image.asset(PngAssetPath.faqImg),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return Divider(height: 1,);
              },
              itemCount: 5,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return const ListTile(contentPadding: EdgeInsets.symmetric(horizontal: 14),
                    title: TextWidget(text: "What is Driving?", textSize: 16),
                    trailing: Icon(Icons.add));
              },
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(10.0),
          //   child: Row(
          //     children: [
          //       TextWidget(
          //           text: "Chat Support",
          //           textSize: 18,
          //           fontWeight: FontWeight.w500),
          //     ],
          //   ),
          // ),
          Image.asset(PngAssetPath.chatImg)
        ],
      ),
    );
  }
}
