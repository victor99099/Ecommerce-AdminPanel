import 'package:ecommerce_adminpanel/Screens/admin-panel/Widgets/PicUpload.dart';

import 'package:ecommerce_adminpanel/controllers/DataControllers/CategoryController.dart';
import 'package:ecommerce_adminpanel/controllers/DataControllers/UserController.dart';
import 'package:ecommerce_adminpanel/controllers/PageController.dart';
import 'package:ecommerce_adminpanel/models/categories-model.dart';
import 'package:ecommerce_adminpanel/services/send_notification.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../models/user-model.dart';

class PromotionSection extends StatefulWidget {
  const PromotionSection({super.key});

  @override
  _PromotionSectionState createState() => _PromotionSectionState();
}

class _PromotionSectionState extends State<PromotionSection> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  final UsersController usersController = Get.find<UsersController>();
  void sendNotificationsInBackground() {
    _sendNotifications(
      usersController.usersList,
      titleController.text,
      bodyController.text,
    );
  }

  void _sendNotifications(List<UserModel> users, String title, String body) {
    for (var user in users) {
      if (user.userDeviceToken.isNotEmpty) {
        SendNotificationService.sendNotificationUsingApi(
          token: user.userDeviceToken,
          title: title,
          body: body,
          data: {"Screen": "Promotion"},
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: const Color(0xFFf0f1f1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: Get.height * 0.05,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: Get.width * 0.035),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: 10,
                      children: [
                        Icon(
                          Iconsax.tag5,
                          size: 30,
                          color: Colors.blue,
                        ),
                        Text(
                          "Promotions",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.8),
                              fontSize: 30,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Text(
                      "Send flash deals and discounts alerts to users",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.6), fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.04,
            ),
            _buildTextField(
                "Title", titleController, "The title of the notification"),
            _buildTextField("Body", bodyController, "The title of the body",
                isMultiline: true),
            SizedBox(
              height: Get.height * 0.03,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 50),
              // padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.blue),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
                  onPressed: () async {
                    // EasyLoading.show();
                    if (titleController.text.isNotEmpty &&
                        bodyController.text.isNotEmpty) {
                      EasyLoading.show(status: "Sending...");

                      await Future(() async {
                        for (var user in usersController.usersList) {
                          if (user.userDeviceToken.isNotEmpty) {
                            await SendNotificationService
                                .sendNotificationUsingApi(
                              token: user.userDeviceToken,
                              title: titleController.text,
                              body: bodyController.text,
                              data: {"Screen": "Promotion"},
                            );
                          }
                        }
                      });

                      EasyLoading.dismiss();
                      Get.snackbar(
                          "Sent", "Notification has been sent to all users",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.lightBlueAccent,
                          colorText: Colors.white);
                      // EasyLoading.dismiss();
                    } else {
                      Get.snackbar("Error",
                          "Please fill all necessary details (name & email)",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.lightBlueAccent,
                          colorText: Colors.white);
                      // EasyLoading.dismiss();
                    }
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                "Send Notification",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                          Icon(
                            Iconsax.arrow_right_25,
                            color: Colors.white,
                            size: 40,
                          ),
                        ],
                      ))),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, String hint,
      {bool isMultiline = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 50),
      child: Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label.text.bold.xl.make(),
          TextFormField(
            controller: controller,
            maxLines: isMultiline ? 2 : 1,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelStyle: TextStyle(fontSize: 20),
              border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.grey.withOpacity(0.5), width: 2),
              ),
            ),
          ),
          // 2.heightBox,
        ],
      ),
    );
  }
}
