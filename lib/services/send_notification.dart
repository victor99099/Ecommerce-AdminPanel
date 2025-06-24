// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'getServiceKey.dart';

class SendNotificationService {
  static Future<void> sendNotificationUsingApi({
    required String? token,
    required String? title,
    required String? body,
    required Map<String, dynamic>? data,
  }) async {
    String serverKey = await GetServiceKey().getServerKeyToken();

    String url =
        "https://fcm.googleapis.com/v1/projects/e-commerece-f7d89/messages:send";

    var headers = <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $serverKey',
    };

    //mesaage
    Map<String, dynamic> message = {
      "message": {
        "token": token,
        "notification": {"body": body, "title": title},
        "data": data,
        "android": {
          "priority": "HIGH",
          "notification": {
            "channel_id": "high_importance_channel",
            "sound": "default",
          },
        },
      },
    };

    //hit api
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(message),
    );
    if (response.statusCode == 200) {
      print("✅ Notification sent successfully!");
    } else {
      print("❌ Notification failed to send!");
      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
    }
  }
}
