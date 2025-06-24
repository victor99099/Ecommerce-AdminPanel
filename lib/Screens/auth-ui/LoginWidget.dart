import 'package:ecommerce_adminpanel/Screens/auth-ui/NotAdminScreen.dart';
import 'package:ecommerce_adminpanel/controllers/GetUserDataController.dart';
import 'package:ecommerce_adminpanel/controllers/SignINController.dart';
import 'package:ecommerce_adminpanel/controllers/SignUpController.dart';
import 'package:ecommerce_adminpanel/controllers/googleSignInController.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../controllers/ForgetPasswordController.dart';
import '../../services/notification_service.dart';
import '../admin-panel/admin-main-screen.dart';

class LoginWidget extends StatelessWidget {
  LoginWidget({super.key});

  final RxBool isFPScreenEnabled = false.obs;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 3),
              color: Color.fromARGB(255, 113, 177, 233),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10)),
          width: MediaQuery.of(context).size.height,
          constraints: BoxConstraints(
            // Use constraints instead of fixed height
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: Column(
            children: [
              Material(
                color: Colors.transparent,
                elevation: 0,
                borderRadius: BorderRadius.circular(10),
                child: TabBar(
                  labelStyle: const TextStyle(
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                  padding: const EdgeInsets.only(top: 10),
                  labelPadding: const EdgeInsets.all(5),
                  indicatorPadding: const EdgeInsets.all(0),
                  dividerHeight: 0,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white.withOpacity(0.2),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white.withOpacity(0.5),
                  tabs: const [
                    Padding(
                        padding: EdgeInsets.only(left: 40, right: 40),
                        child: Tab(
                          text: 'Sign In',
                        )),
                    Padding(
                      padding: EdgeInsets.only(left: 40, right: 40),
                      child: Tab(text: 'Sign Up'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.68,
                child: Obx(
                  () => TabBarView(
                    children: [
                      isFPScreenEnabled.value
                          ? ForgetPasswordSection(
                              isFPScreenEnabled: isFPScreenEnabled,
                            )
                          : SignInSection(
                              isFPScreenEnabled: isFPScreenEnabled,
                            ),
                      SignUpSection()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgetPasswordSection extends StatelessWidget {
  final RxBool isFPScreenEnabled;
  ForgetPasswordSection({super.key, required this.isFPScreenEnabled});

  final TextEditingController emailController = TextEditingController();
  final ForgetPasswordController forgetPasswordController =
      Get.put(ForgetPasswordController());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30, left: 50, right: 50),
      child: Column(
        spacing: 10,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              spacing: 10,
              children: [
                IconButton(
                    onPressed: () {
                      isFPScreenEnabled.value = false;
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
                Text(
                  "Forgot Password",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          SizedBox(
            height: Get.height * 0.05,
          ),
          CustomTextField(
            hintText: "Enter Email",
            controller: emailController,
            icon: Iconsax.sms,
          ),
          Container(
            padding: const EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            height: 60,
            child: ElevatedButton(
                onPressed: () async {
                  String email = emailController.text.trim();

                  if (email.isEmpty) {
                    Get.snackbar("Error", "Please enter email!",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.lightBlueAccent,
                        colorText: Colors.white);
                  } else {
                    String email = emailController.text.trim();
                    forgetPasswordController.forgetPasswordMethod(email);
                  }
                },
                style: ButtonStyle(
                    elevation: const WidgetStatePropertyAll(10),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                    backgroundColor: const WidgetStatePropertyAll(
                        Color.fromARGB(255, 2, 20, 34))),
                child: const Text(
                  "Send Reset Link",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
          ),
        ],
      ),
    );
  }
}

class SignInSection extends StatefulWidget {
  final RxBool isFPScreenEnabled;
  SignInSection({super.key, required this.isFPScreenEnabled});

  @override
  State<SignInSection> createState() => _SignInSectionState();
}

class _SignInSectionState extends State<SignInSection> {
  late TextEditingController emailController;

  late TextEditingController passController;

  RxBool isPassVisible = true.obs;

  final SignInController signInController = Get.put((SignInController()));
  final GetUserDataController getUserDataController =
      Get.find<GetUserDataController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30, left: 50, right: 50),
      child: Column(
        spacing: 10,
        children: [
          CustomTextField(
            hintText: "Enter Email",
            controller: emailController,
            icon: Iconsax.sms,
          ),
          PasswordField(isPassVisible: isPassVisible, password: passController),
          Container(
            padding: const EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width,
            height: 60,
            child: ElevatedButton(
                onPressed: () async {
                  String email = emailController.text.trim();
                  String password = passController.text.trim();

                  if (email.isEmpty || password.isEmpty) {
                    Get.snackbar("Error", "Please enter all details!",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.lightBlueAccent,
                        colorText: Colors.white);
                  } else {
                    try {
                      UserCredential? userCredential =
                          await signInController.signInMethod(email, password);

                      if (userCredential!.user!.emailVerified) {
                        Get.snackbar("Success", "login successfully!",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.lightBlueAccent,
                            colorText: Colors.white);
                        final GetUserDataController getUserDataController =
                            Get.put(GetUserDataController());

                        var userData = await getUserDataController
                            .getUserData(userCredential!.user!.uid);

                        if (userData[0]['isAdmin'] == true) {
                          Get.offAll(() => const AdminScreen());
                        } else {
                          Get.offAll(() => const NotAdminScreen());
                        }
                        // Get.offAll(() => const AdminScreen());
                      } else {
                        Get.snackbar("Error",
                            "Please verify your email, check your inbox",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.lightBlueAccent,
                            colorText: Colors.white);
                      }
                    } catch (e) {
                      Get.snackbar("Error",
                            e.toString(),
                            snackPosition:
                                SnackPosition.BOTTOM,
                            backgroundColor:
                                Color(0xFFFF5722),
                            colorText: Colors.white);
                    }
                  }
                },
                style: ButtonStyle(
                    elevation: const WidgetStatePropertyAll(10),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                    backgroundColor: const WidgetStatePropertyAll(
                        Color.fromARGB(255, 2, 20, 34))),
                child: const Text(
                  "Sign In",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
          ),
          GestureDetector(
            onTap: () {
              widget.isFPScreenEnabled.value = true;
            },
            child: Container(
              margin: const EdgeInsets.all(0),
              alignment: Alignment.centerRight,
              child: "Forgot Password ? ".text.bold.color(Colors.white).make(),
            ).pOnly(right: 10, top: 10, bottom: 0),
          ),
          const OrSignInDivider(),
          GoogleLogin()
        ],
      ),
    );
  }
}

class SignUpSection extends StatefulWidget {
  const SignUpSection({super.key});

  @override
  State<SignUpSection> createState() => _SignUpSectionState();
}

class _SignUpSectionState extends State<SignUpSection> {
  late TextEditingController nameController;

  late TextEditingController emailController;

  late TextEditingController passController;
  late TextEditingController phoneController;
  late TextEditingController cityController;

  RxBool isPassVisible = true.obs;
  final SignUpController signUpController = Get.put(SignUpController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passController = TextEditingController();
    phoneController = TextEditingController();
    cityController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 50, right: 50),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                spacing: 10,
                children: [
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  CustomTextField(
                    hintText: "Enter Name",
                    controller: nameController,
                    icon: Iconsax.user_edit,
                  ),
                  CustomTextField(
                    hintText: "Enter Email",
                    controller: emailController,
                    icon: Iconsax.sms,
                  ),
                  CustomTextField(
                    hintText: "Enter Phone No",
                    controller: phoneController,
                    icon: Icons.phone,
                  ),
                  CustomTextField(
                    hintText: "Enter City Name",
                    controller: cityController,
                    icon: Icons.location_city_outlined,
                  ),
                  PasswordField(
                      isPassVisible: isPassVisible, password: passController),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: ElevatedButton(
                        onPressed: () async {
                          NotificationService notificationService =
                              NotificationService();
                          String name = nameController.text.trim();
                          String userrmail = emailController.text.trim();
                          String userphone = phoneController.text.trim();
                          String usercity = cityController.text.trim();
                          String userpassword = passController.text.trim();
                          String userDeviceToken =
                              await notificationService.getDeviceToken();

                          if (name.isEmpty ||
                              userrmail.isEmpty ||
                              userphone.isEmpty ||
                              usercity.isEmpty ||
                              userpassword.isEmpty) {
                            Get.snackbar("Error", "Fill all details",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.lightBlueAccent,
                                colorText: Colors.white);
                          } else {
                            UserCredential? userCredential =
                                await signUpController.signUpMethod(
                                    name,
                                    userrmail,
                                    userphone,
                                    usercity,
                                    userpassword,
                                    userDeviceToken);
                            if (userCredential != null) {
                              Get.snackbar("Verification Email Sent",
                                  "Please check your email",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.lightBlueAccent,
                                  colorText: Colors.white);
                              FirebaseAuth.instance.signOut();
                              // Get.offAll(() => const SignScreen());
                            }
                          }
                        },
                        style: ButtonStyle(
                            elevation: const WidgetStatePropertyAll(10),
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            backgroundColor: const WidgetStatePropertyAll(
                                Color.fromARGB(255, 2, 20, 34))),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                  ),
                  const OrSignInDivider(),
                  GoogleLogin(),
                  SizedBox(
                    height: Get.height * 0.08,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData icon;
  const CustomTextField(
      {super.key,
      required this.icon,
      required this.controller,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white, // White background color
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromARGB(
                255, 113, 177, 233), // Dark blue border color when enabled
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromARGB(
                255, 113, 177, 233), // Dark blue border color when focused
            width: 3.0, // Border width when focused
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: Icon(
          icon,
          color: const Color.fromARGB(255, 109, 109, 109),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
      ),
      style: const TextStyle(color: Colors.black), // Text color
    );
  }
}

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
    required this.isPassVisible,
    required this.password,
  });

  final RxBool isPassVisible;
  final TextEditingController password;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextFormField(
        obscureText: isPassVisible.value,
        controller: password,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white, // White background color
            hintText: "Enter Password",
            hintStyle: const TextStyle(color: Colors.grey),
            prefixIcon: const Icon(
              Iconsax.key_square,
              color: Color.fromARGB(255, 109, 109, 109),
            ),
            suffixIcon: Obx(() => GestureDetector(
                  onTap: () {
                    isPassVisible.toggle();
                  },
                  child: isPassVisible.value
                      ? const Icon(Iconsax.eye_slash,
                          color: Color.fromARGB(255, 109, 109, 109))
                      : const Icon(Iconsax.eye,
                          color: Color.fromARGB(255, 109, 109, 109)),
                )),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    color: Color.fromARGB(255, 113, 177, 233), width: 3)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    color: Color.fromARGB(255, 113, 177, 233)))),
      ),
    );
  }
}

class GoogleLogin extends StatelessWidget {
  GoogleLogin({super.key});

  final GoogleSignInController _googleSignInController =
      GoogleSignInController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      width: MediaQuery.of(context).size.width,
      height: 60,
      child: ElevatedButton(
          style: ButtonStyle(
              elevation: const WidgetStatePropertyAll(10),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
              backgroundColor: const WidgetStatePropertyAll(
                  Color.fromARGB(255, 255, 255, 255))),
          onPressed: () async {
            _googleSignInController.SignInWithGoogle();
          },
          child: Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset("assets/images/google.png"),
              ),
              const Text(
                "Sign In With Google",
                style: TextStyle(
                    color: Color.fromARGB(255, 2, 20, 34), fontSize: 16),
              ),
            ],
          )),
    );
  }
}

class OrSignInDivider extends StatelessWidget {
  const OrSignInDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Row(
        children: [
          Flexible(
              child: Divider(
            color: Colors.white,
            thickness: 1,
            indent: 20,
            endIndent: 10,
          )),
          Text(
            "Or",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          Flexible(
              child: Divider(
            color: Colors.white,
            thickness: 1,
            indent: 10,
            endIndent: 20,
          )),
        ],
      ),
    );
  }
}
