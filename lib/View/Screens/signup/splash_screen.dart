import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:omega/Constant/Components.dart';
import 'package:omega/Constant/reusable.dart';
import 'package:omega/Control/logincontroller.dart';

import '../home_screen.dart';
import 'login_screen.dart';

class splashscreen extends StatelessWidget {
  splashscreen({super.key});
  logincontroller controll = logincontroller();

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 4), () async {
      if (remeber.read("token") == null) {
        Get.off(() => loginscreen(),
            transition: Transition.fadeIn,
            curve: Curves.easeInOut,
            duration: Duration(seconds: 3));
      } else if (usernow.read("user")==null){
        Get.off(() => loginscreen(),
            transition: Transition.fadeIn,
            curve: Curves.easeInOut,
            duration: Duration(seconds: 3));
      }
      else{
        Get.off(()=>homescreen(),
            transition: Transition.fadeIn,
            curve: Curves.easeInOut,
            duration: Duration(seconds: 3));

      }
    });
    return SafeArea(
      child: Scaffold(
        body: Container(
          width:getwidth(context),
          height: getheight(context),
          child: Center(
            child: Container(
              width: 200,
              height: 200,
              child: Image(
                image: AssetImage("assets/images/img_group_9.png"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
