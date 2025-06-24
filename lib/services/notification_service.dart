// import 'package:app_settings/app_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_application_1/screens/user-panel/navigationMenu.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<String> getDeviceToken() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true, badge: true, sound: true);

    String? token = await messaging.getToken();

    return token!;
  }
}
