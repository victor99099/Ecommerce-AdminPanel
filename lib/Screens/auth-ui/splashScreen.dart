import 'dart:async';

import 'package:ecommerce_adminpanel/Screens/auth-ui/NotAdminScreen.dart';
import 'package:ecommerce_adminpanel/Screens/auth-ui/SignScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../controllers/GetUserDataController.dart';
import '../../utils/app-constant.dart';
import '../admin-panel/admin-main-screen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Get.offAll(() => const SignScreen());
      loggedin(context);
    });
  }

  Future<void> loggedin(BuildContext context) async {
    final currentTheme = Theme.of(context);
    if (user != null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => Container(
          color: Colors.blue,
          width: Get.width,
          height: Get.height,
          child: Center(
            child: Column(
              children: [
                Lottie.asset("assets/images/loadingCart.json",height: Get.height * 0.7),
                "Logging in ...".text.xl3.color(Colors.white).make()
              ],
            ),
          ),
        ),
      );
      final GetUserDataController getUserDataController =
          Get.put(GetUserDataController());

      var userData = await getUserDataController.getUserData(user!.uid);

      if (userData[0]['isAdmin'] == true) {
        Get.offAll(() => const AdminScreen());
      } else {
        Get.offAll(() => const NotAdminScreen());
      }
    } else {
      Get.to(() => const SignScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    final getTheme = Theme.of(context);
    return Scaffold(
      backgroundColor: getTheme.colorScheme.secondary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                height: Get.height * 0.9,
                width: Get.width,
                child: Lottie.asset("assets/images/loadingCart.json",
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.contain),
              ),
            ),
            Container(
              height: Get.height * 1 / 3,
              width: Get.width,
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(bottom: 20),
              child: (AppConstant.AppPoweredNy)
                  .text
                  .xl
                  .textStyle(const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold))
                  .make(),
            )
          ],
        ),
      ),
    );
  }
}
