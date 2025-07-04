import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //for password visibility
  RxBool isPasswordVisible = false.obs;

  Future<UserCredential?> signInMethod(
    String userEmail,
    String userPassword,
  ) async {
    try {
      EasyLoading.show(status: "Please Wait ..");
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: userEmail, password: userPassword);

      //add data to database

      EasyLoading.dismiss();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", "${e.message}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.lightBlueAccent,
          colorText: Colors.white);
      EasyLoading.dismiss();
    }
    return null;
  }
}
