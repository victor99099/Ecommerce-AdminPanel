import 'package:ecommerce_adminpanel/controllers/DataControllers/BrandController.dart';

import 'package:ecommerce_adminpanel/controllers/PageController.dart';
import 'package:ecommerce_adminpanel/models/brand-model.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:velocity_x/velocity_x.dart';

import '../../../../controllers/UniqueIdGenerator.dart';
import '../../Widgets/PicUpload.dart';

class AddBrandPage extends StatefulWidget {
  const AddBrandPage({super.key});

  @override
  _AddBrandPageState createState() => _AddBrandPageState();
}

class _AddBrandPageState extends State<AddBrandPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController slugController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  // DropzoneViewController? dropzoneController;
  RxnString imgUrl = RxnString();
  final BrandsController brandsController = Get.find<BrandsController>();
  final CustomPageController customPageController =
      Get.find<CustomPageController>();

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);

    return Container(
      color: const Color(0xFFf0f1f1),
      child: Padding(
        padding: EdgeInsets.only(
            left: Get.width * 0.05,
            right: Get.width * 0.05,
            top: Get.height * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 10,
                  children: [
                    IconButton(
                        onPressed: () {
                          customPageController.SelectedPage.value = 2;
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.blue)),
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                    "Add Brand".text.xl3.bold.make(),
                  ],
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (imgUrl.value == null ||
                          nameController.text.isEmpty) {
                        Get.snackbar("Error", "Please fill all details",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.lightBlueAccent,
                            colorText: Colors.white);
                      } else {
                        BrandModel brand = BrandModel(
                            brandId: UUIDGenerator.generate(),
                            brandImage: imgUrl.value!,
                            brandName: nameController.text,
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now());
                        await brandsController.addBrand(brand);
                        Get.snackbar("Uploaded", "New brand has been added",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.lightBlueAccent,
                            colorText: Colors.white);
                        customPageController.SelectedPage.value = 2;
                      }
                    },
                    style: ButtonStyle(
                        elevation: WidgetStatePropertyAll(10),
                        padding: WidgetStatePropertyAll(EdgeInsets.all(15)),
                        backgroundColor: WidgetStatePropertyAll(Colors.blue),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    child: Text(
                      "Add",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )),
              ],
            ),
            SizedBox(
              height: Get.height * 0.1,
            ),
    
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Upload Section with Dotted Border
                PicUpload(imgUrl: imgUrl),
    
                20.widthBox,
    
                // Form Fields
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTextField("Name", nameController,
                          "The name is how it appears on your site."),
                    ],
                  ),
                ),
              ],
            ),
    
            20.heightBox,
    
            // Submit Button
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, String hint,
      {bool isMultiline = false}) {
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label.text.bold.xl2.make(),
        TextFormField(
          controller: controller,
          maxLines: isMultiline ? 3 : 1,
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
        5.heightBox,
        Text(
          hint,
          style: TextStyle(
              color: const Color.fromARGB(255, 131, 130, 130), fontSize: 16),
        )
      ],
    );
  }
}
