import 'package:ecommerce_adminpanel/Screens/admin-panel/ProfileScreen/Profilescreen.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_application_1/controllers/ChangeInfoController.dart';
// import 'package:flutter_application_1/models/user-model.dart';
// import 'package:flutter_application_1/screens/user-panel/Profilescreen.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../controllers/ChangeInfoController.dart';
import '../../../models/user-model.dart';

// import '../../widgets/DialogLogoutWidget.dart';

class UpdateUserInfoScreen extends StatelessWidget {
  UserModel userModel;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final ChangeInfoController changeInfoController =
      Get.put(ChangeInfoController());

  UpdateUserInfoScreen({super.key, required this.userModel}) {
    nameController.text = userModel.username;
    phoneController.text = userModel.phone;
    cityController.text = userModel.city;
    addressController.text = userModel.userAddress;
    streetController.text = userModel.street;
  }
  RxBool isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    final currentTheme = Theme.of(context);

    return Scaffold(
      backgroundColor: currentTheme.primaryColor,
      appBar: AppBar(
        title: Text(
          'Update Information',
          style: TextStyle(
              color: currentTheme.colorScheme.tertiary,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: currentTheme.colorScheme.tertiary),
      ),
      body: Center(
        child: SizedBox(
          width: Get.width * 0.6,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTextField(
                  controller: nameController,
                  labelText: 'Name',
                  icon: Icons.person,
                  theme: currentTheme,
                ),
                const SizedBox(height: 32),
                _buildTextField(
                  controller: phoneController,
                  labelText: 'Phone No',
                  icon: Icons.phone,
                  theme: currentTheme,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 32),
                _buildTextField(
                  controller: cityController,
                  labelText: 'City',
                  icon: Icons.terrain,
                  theme: currentTheme,
                ),
                const SizedBox(height: 32),
                _buildTextField(
                  controller: streetController,
                  labelText: 'Street',
                  icon: Icons.traffic,
                  theme: currentTheme,
                ),
                const SizedBox(height: 32),
                _buildTextArea(
                  controller: addressController,
                  labelText: 'Address',
                  icon: Icons.home,
                  theme: currentTheme,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(top:16.0, bottom : 16, left: Get.width * 0.12, right: Get.width * 0.12),
        child: ElevatedButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomDialog(
                      title: "Save Changes",
                      content: "Are you sure ?",
                      onCancel: () {
                        Navigator.of(context).pop();
                        nameController.text = userModel.username;
                        phoneController.text = userModel.phone;
                        cityController.text = userModel.city;
                        addressController.text = userModel.userAddress;
                        streetController.text = userModel.street;
                        Get.off(() => const ProfileScreen());
                      },
                      onConfirm: () async {
                        Navigator.of(context).pop();

                        changeInfoController.UpdateInfo(
                            nameController.text,
                            phoneController.text,
                            cityController.text,
                            addressController.text,
                            streetController.text);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            'Information Updated',
                            style: TextStyle(
                                color: currentTheme.colorScheme.surface),
                          ),
                          backgroundColor: currentTheme.colorScheme.onPrimary,
                        ));
                        Get.off(() => const ProfileScreen());
                      });
                });
          },
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                currentTheme.colorScheme.onPrimary,
              ),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)))),
          child: Text(
            'Save Changes',
            style: TextStyle(color: currentTheme.colorScheme.surface),
          ),
        ).h(Get.height / 16),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    required ThemeData theme,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: theme.colorScheme.tertiaryFixed),
        prefixIcon: Icon(icon, color: theme.colorScheme.onPrimary),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: theme.colorScheme.tertiary),
        ),
        hintStyle: TextStyle(color: theme.colorScheme.tertiaryFixed),
      ),
    );
  }

  Widget _buildTextArea({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    required ThemeData theme,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: 2,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: theme.colorScheme.tertiaryFixed),
        prefixIcon: Icon(icon, color: theme.colorScheme.onPrimary),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: theme.colorScheme.tertiary),
        ),
        hintStyle: TextStyle(color: theme.colorScheme.tertiaryFixed),
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  const CustomDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final currentTheme = Theme.of(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      content: Text(
        content,
        style: const TextStyle(fontSize: 18),
      ),
      actions: <Widget>[
        TextButton(
          style: ButtonStyle(
              backgroundColor:
                  WidgetStatePropertyAll(currentTheme.colorScheme.surface)),
          onPressed: onCancel,
          child: Text(
            'Cancel',
            style: TextStyle(color: currentTheme.colorScheme.onPrimary),
          ),
        ),
        TextButton(
          style: ButtonStyle(
              backgroundColor:
                  WidgetStatePropertyAll(currentTheme.colorScheme.onPrimary)),
          onPressed: onConfirm,
          child: Text(
            'Confirm',
            style: TextStyle(color: currentTheme.colorScheme.surface),
          ),
        ),
      ],
    );
  }
}
