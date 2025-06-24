import 'package:ecommerce_adminpanel/Screens/admin-panel/admin-main-screen.dart';
import 'package:ecommerce_adminpanel/Screens/auth-ui/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'Screens/auth-ui/SignScreen.dart';
import 'utils/app-constant.dart';

@pragma('vm:entry-point')
Future<void> _firebaseBackgroundHandle(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyCjcVQALd71MnMEEE8owg7AGCv-dco3sNY",
        authDomain: "e-commerece-f7d89.firebaseapp.com",
        projectId: "e-commerece-f7d89",
        storageBucket: "e-commerece-f7d89.appspot.com",
        messagingSenderId: "635663434875",
        appId: "1:635663434875:web:80fad9ea285e6264d4cede",
        measurementId: "G-JHM1PBZ75Z"),
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyCjcVQALd71MnMEEE8owg7AGCv-dco3sNY",
        authDomain: "e-commerece-f7d89.firebaseapp.com",
        projectId: "e-commerece-f7d89",
        storageBucket: "e-commerece-f7d89.appspot.com",
        messagingSenderId: "635663434875",
        appId: "1:635663434875:web:80fad9ea285e6264d4cede",
        measurementId: "G-JHM1PBZ75Z"),
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandle);

  // FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandle);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final ThemeController themeController = Get.put(ThemeController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: MyTheme.lightTheme(context),
        darkTheme: MyTheme.darkTheme(context),
        title: 'Ecommerce Admin Panel',
        themeMode: ThemeMode.light,
        home: const Splashscreen(),
        builder: EasyLoading.init());
  }
}
