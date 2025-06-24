import 'package:ecommerce_adminpanel/Screens/auth-ui/LoginWidget.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:lottie/lottie.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../controllers/GetDeviceTokenController.dart';
import '../../controllers/GetUserDataController.dart';

class SignScreen extends StatefulWidget {
  const SignScreen({super.key});

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  GetDeviceTokenController getDeviceTokenController =
      Get.put(GetDeviceTokenController());
  GetUserDataController getUserDataController =
      Get.put(GetUserDataController());

  TextEditingController useremail = TextEditingController();
  TextEditingController userpassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final getTheme = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: getTheme.colorScheme.secondary,
      body: Row(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(0),
                height: Get.height * 0.4,
                width: Get.width * 0.2,
                child: Lottie.asset("assets/images/loadingCart.json",
                    fit: BoxFit.cover),
              ).pOnly(left: 0),
              Container(
                height: Get.height * 0.3,
                width: Get.width * 0.3,
                alignment: Alignment.centerLeft,
                child: "Admin Panel"
                    .text
                    .align(TextAlign.left)
                    .color(Colors.white)
                    .xl5
                    .make()
                    .pOnly(right: 50, top: 10),
              ),
            ],
          ),
          Center(
            child: LoginWidget(),
          )
        ],
      ),
    );
  }
}
