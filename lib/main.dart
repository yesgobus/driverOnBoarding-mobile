import 'package:driver_onboarding/screen/APPLICATIONS/permmissionScreen/permission_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:keep_screen_on/keep_screen_on.dart';
import 'screen/ONBOARDING/loginScreens/login_page.dart';
import 'utils/getStore/get_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  KeepScreenOn.turnOn();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Yesgo Cab Driver',
      debugShowCheckedModeBanner: false,
      home: GetStoreData.getStore.read('access_token') == null
          ? LoginPage()
          : PermissionLandingScreen(),
      // PermissionLandingScreen(),
      theme: ThemeData(useMaterial3: true),
    );
  }
}
