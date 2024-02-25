import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:omega/Constant/Components.dart';
import 'package:omega/Control/homecontroller.dart';

import 'View/Screens/address/all address.dart';
import 'View/Screens/signup/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  devicename = await getDeviceName();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness:
          Brightness.dark, // Replace with your desired status bar color
    ),
  );
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: splashscreen(),
      initialBinding: BindingsBuilder(() {
        Get.lazyPut<homecontroller>(() => homecontroller());
        Get.lazyPut(() => alladdress());
      }),
    );
  }
}
