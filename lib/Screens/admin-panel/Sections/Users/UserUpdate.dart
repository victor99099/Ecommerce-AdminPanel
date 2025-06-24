import 'package:ecommerce_adminpanel/Screens/admin-panel/Widgets/DropDownButtons.dart';
import 'package:ecommerce_adminpanel/Screens/admin-panel/Widgets/PicUpload.dart';
import 'package:ecommerce_adminpanel/controllers/DataControllers/UserController.dart';
import 'package:ecommerce_adminpanel/models/user-model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showUserUpdateDialog(BuildContext context, UserModel user) async {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController deviceTokeController = TextEditingController();
  RxBool selectedRole = (user.isAdmin ? true : false).obs;
  RxnString imgUrl = RxnString(user.userImg.isEmpty ? "" : user.userImg);
  nameController.text = user.username;
  emailController.text = user.email;
  phoneController.text = user.phone;
  countryController.text = user.country;
  cityController.text = user.city;
  streetController.text = user.street;
  addressController.text = user.userAddress;
  deviceTokeController.text = user.userDeviceToken;

  UsersController usersController = Get.put(UsersController());

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            child: SizedBox(
              width: Get.width * 0.5,
              child: Stack(
                children: [
                  AlertDialog(
                    scrollable: true,
                    // backgroundColor: const Color(0xFFf0f1f1),
                    title: Row(
                      spacing: 20,
                      children: [
                        CircleAvatar(
                          child: UserUpdatePicUpload(imgUrl: imgUrl),
                          // user.userImg.isEmpty
                          //     ? Text(user.username[0].firstLetterUpperCase())
                          //     : Image.network(user.userImg),
                        ),
                        Text(
                          "User Info",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),

                    content: SizedBox(
                      width: Get.width * 0.45,
                      height: Get.height * 1.1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Divider(
                            endIndent: 0,
                            indent: 0,
                            color: Colors.grey.withOpacity(0.8),
                          ),
                          SizedBox(height: 10),

                          Text(
                            "User Name",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          // Name TextField
                          TextField(
                            style: TextStyle(color: Colors.grey),
                            // controller: nameController,
                            enabled: true,
                            controller: nameController,
                            decoration: InputDecoration(
                              // hintText: user.username,
                              filled: true,

                              // labelText: "Name",
                              fillColor: Colors.white,
                              labelStyle: TextStyle(fontSize: 20),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.5),
                                    width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.5),
                                    width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.5),
                                    width: 2),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              UpdateColumn(
                                title: "Email",
                                body: user.email,
                                controller: emailController,
                              ),
                              UpdateColumn(
                                title: "Phone no",
                                body: user.phone,
                                controller: phoneController,
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              UpdateColumn(
                                title: "Country",
                                controller: countryController,
                                body: user.country.isEmpty
                                    ? "null"
                                    : user.country,
                              ),
                              UpdateColumn(
                                title: "City",
                                controller: cityController,
                                body: user.city.isEmpty ? "null" : user.city,
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Street",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          // Name TextField
                          TextField(
                            style: TextStyle(color: Colors.grey),
                            // controller: nameController,
                            enabled: true,

                            decoration: InputDecoration(
                              hintStyle: TextStyle(fontSize: 12),
                              // hintText: user.street.isEmpty ? "null" : user.street,
                              filled: true,
                              // labelText: "Name",
                              fillColor: Colors.white,
                              labelStyle: TextStyle(fontSize: 20),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.5),
                                    width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.5),
                                    width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.5),
                                    width: 2),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Address",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),

                          // Name TextField
                          TextField(
                            style: TextStyle(color: Colors.grey),
                            // controller: nameController,

                            enabled: true,
                            decoration: InputDecoration(
                              // hintText: user.userAddress.isEmpty
                              // ? "null"
                              // : user.userAddress,
                              hintMaxLines: 3,
                              hintStyle: TextStyle(fontSize: 12),
                              filled: true,
                              // labelText: "Name",
                              fillColor: Colors.white,
                              labelStyle: TextStyle(fontSize: 20),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.5),
                                    width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.5),
                                    width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.5),
                                    width: 2),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Device Token",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          // Name TextField
                          TextField(
                            style: TextStyle(color: Colors.grey),
                            // controller: nameController,
                            enabled: true,
                            decoration: InputDecoration(
                              hintText: user.userDeviceToken,
                              filled: true,
                              // labelText: "Name",
                              fillColor: Colors.white,
                              hintStyle: TextStyle(fontSize: 12),
                              labelStyle: TextStyle(fontSize: 20),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.5),
                                    width: 1),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.5),
                                    width: 1),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.5),
                                    width: 2),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              UserDropdownButton(
                                label: "Role",
                                selectedRole: selectedRole,
                                options: ["Admin", "User"],
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                    actionsAlignment: MainAxisAlignment.center,
                    actionsPadding: EdgeInsets.only(top: 10),
                    actions: [
                      SizedBox(
                        width: Get.width * 0.45,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.blue)),
                          onPressed: () async {
                            if (nameController.text.isNotEmpty &&
                                emailController.text.isNotEmpty) {
                              Map<String, dynamic> updatedData = {
                                "username": nameController.text,
                                "email": emailController.text,
                                "phone": phoneController.text,
                                "userImg": imgUrl.value,
                                "userDeviceToken": deviceTokeController.text,
                                "country": countryController.text,
                                "userAddress": addressController.text,
                                "street": streetController.text,
                                "isAdmin": selectedRole.value,
                                "isActive": false,
                                "createdOn": user.createdOn,
                                "city": cityController.text
                              };
                              usersController.updateUser(user.uId, updatedData);
                              Get.snackbar("Updated", "User has been updated",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.lightBlueAccent,
                                  colorText: Colors.white);
                              Navigator.pop(context);
                            } else {
                              Get.snackbar("Error",
                                  "Please fill all necessary details (name & email)",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.lightBlueAccent,
                                  colorText: Colors.white);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Update",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                      right: Get.width * 0.015,
                      top: Get.width * 0.015,
                      child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.close_rounded,
                            color: Colors.grey,
                          ))),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

class UpdateColumn extends StatelessWidget {
  final String title;
  final String body;
  final TextEditingController controller;
  const UpdateColumn(
      {super.key,
      required this.controller,
      required this.title,
      required this.body});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.18,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 5),

          // Name TextField
          TextField(
            style: TextStyle(color: Colors.grey),
            controller: controller,
            enabled: true,
            decoration: InputDecoration(
              // hintMaxLines: 5,
              filled: true,
              // labelText: "Name",
              fillColor: Colors.white,
              labelStyle: TextStyle(fontSize: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
                borderSide:
                    BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
                borderSide:
                    BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
                borderSide:
                    BorderSide(color: Colors.grey.withOpacity(0.5), width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoColumn extends StatelessWidget {
  final String title;
  final String body;

  const InfoColumn({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.18,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 5),

          // Name TextField
          TextField(
            style: TextStyle(color: Colors.grey),
            enabled: false,
            decoration: InputDecoration(
              hintText: body,
              // hintMaxLines: 5,
              filled: true,
              // labelText: "Name",
              fillColor: Colors.white,
              labelStyle: TextStyle(fontSize: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
                borderSide:
                    BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
                borderSide:
                    BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
                borderSide:
                    BorderSide(color: Colors.grey.withOpacity(0.5), width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
