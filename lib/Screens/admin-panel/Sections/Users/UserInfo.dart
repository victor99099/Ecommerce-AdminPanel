import 'package:ecommerce_adminpanel/models/user-model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

void showUserInfoDialog(BuildContext context, UserModel user) async {
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
                          child: user.userImg.isEmpty
                              ? Text(user.username[0].firstLetterUpperCase())
                              : Image.network(user.userImg),
                        ),
                        Text(
                          "User Info",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),

                    content: SizedBox(
                      width: Get.width * 0.45,
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
                            style:
                                TextStyle(color: Colors.grey.withOpacity(0.8)),
                            // controller: nameController,
                            enabled: false,
                            decoration: InputDecoration(
                              hintText: user.username,
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
                              InfoColumn(
                                title: "Email",
                                body: user.email,
                              ),
                              InfoColumn(
                                title: "Phone no",
                                body: user.phone,
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InfoColumn(
                                title: "Country",
                                body: user.country.isEmpty
                                    ? "null"
                                    : user.country,
                              ),
                              InfoColumn(
                                title: "City",
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
                            style:
                                TextStyle(color: Colors.grey.withOpacity(0.8)),
                            // controller: nameController,
                            enabled: false,

                            decoration: InputDecoration(
                              hintStyle: TextStyle(fontSize: 12),
                              hintText:
                                  user.street.isEmpty ? "null" : user.street,
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
                            style:
                                TextStyle(color: Colors.grey.withOpacity(0.8)),
                            // controller: nameController,

                            enabled: false,
                            decoration: InputDecoration(
                              hintText: user.userAddress.isEmpty
                                  ? "null"
                                  : user.userAddress,
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
                            style:
                                TextStyle(color: Colors.grey.withOpacity(0.8)),
                            // controller: nameController,
                            enabled: false,
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
                              InfoColumn(
                                title: "Role",
                                body: user.isAdmin ? "Admin" : "User",
                              ),
                              InfoColumn(
                                title: "Created On",
                                body: formatTimestampString(user.createdOn),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
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

String formatTimestampString(String timestampString) {
  // Extract the seconds part using string operations
  String secondsPart = timestampString
      .split("seconds=")[1] // Get part after "seconds="
      .split(",")[0] // Take only the seconds value
      .trim(); // Remove any spaces

  // Convert seconds to an integer
  int seconds = int.tryParse(secondsPart) ?? 0;

  // Convert to Date manually
  int day = (seconds ~/ 86400) % 30 + 1; // Approximate day calculation
  int month = ((seconds ~/ 2592000) % 12) + 1; // Approximate month
  int year = 1970 + (seconds ~/ 31536000); // Approximate year from epoch

  // Ensure proper formatting (01, 02, etc.)
  String dayStr = day.toString().padLeft(2, '0');
  String monthStr = month.toString().padLeft(2, '0');
  String yearStr = year.toString();

  return "$dayStr-$monthStr-$yearStr"; // Example: 23-05-2025
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
            style: TextStyle(color: Colors.grey.withOpacity(0.8)),
            // controller: nameController,

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
