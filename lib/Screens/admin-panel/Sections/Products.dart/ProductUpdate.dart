import 'package:ecommerce_adminpanel/Screens/admin-panel/Widgets/DropDownButtons.dart';
import 'package:ecommerce_adminpanel/models/product-model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:velocity_x/velocity_x.dart';

import '../../../../controllers/DataControllers/ProductController.dart';

import '../../../../utils/ProductColors.dart';
import '../../Widgets/PicUpload.dart';

void showProductDialog(BuildContext context, ProductModel product) {
  final ProductsController productsController = Get.find<ProductsController>();

  final TextEditingController nameController =
      TextEditingController(text: product.productName);
  final TextEditingController descriptionController =
      TextEditingController(text: product.productDescription);
  final TextEditingController categoryName =
      TextEditingController(text: product.categoryName);
  final TextEditingController brandName =
      TextEditingController(text: product.brandName);
  final TextEditingController originalPrice =
      TextEditingController(text: product.fullPrice);
  final TextEditingController salePrice =
      TextEditingController(text: product.salePrice);
  final TextEditingController deliveryDays = TextEditingController(
      text: product.deliveryTime.replaceAll("days", "").trim());

  late RxString selectedCategroyId = (product.categoryId).obs;
  late RxString selectedBrandId = (product.brandId).obs;

  RxnString imgUrl1 = RxnString(product.productImages[0]);
  RxnString imgUrl2 = RxnString(product.productImages[1]);
  RxnString imgUrl3 = RxnString(product.productImages[2]);

  RxBool isBestSelling = (product.isBest).obs;
  RxBool isOnSale = (product.isSale).obs;

  final UpdateColorSelectionController colorsSelectionController =
      Get.put(UpdateColorSelectionController());
  // final CustomPageController customPageController =
  //     Get.find<CustomPageController>();

  colorsSelectionController.selectedColors.value = product.productColors
      .map((color) => color.toString().toUpperCase())
      .toList();
  bool areAllFieldsFilled() {
    return nameController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        categoryName.text.isNotEmpty &&
        brandName.text.isNotEmpty &&
        originalPrice.text.isNotEmpty &&
        // salePrice.text.isNotEmpty &&
        deliveryDays.text.isNotEmpty &&
        selectedCategroyId.value.isNotEmpty &&
        selectedBrandId.value.isNotEmpty &&
        imgUrl1.value != null &&
        imgUrl1.value!.isNotEmpty &&
        imgUrl2.value != null &&
        imgUrl2.value!.isNotEmpty &&
        imgUrl3.value != null &&
        imgUrl3.value!.isNotEmpty &&
        colorsSelectionController.selectedColors.isNotEmpty;
  }

  // File? selectedImage;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            child: SizedBox(
              width: Get.width * 0.5,
              height: Get.height * 1.6,
              child: Stack(
                children: [
                  AlertDialog(
                    scrollable: true,
                    actionsPadding: EdgeInsets.only(top: 10),
                    // backgroundColor: const Color(0xFFf0f1f1),
                    title: Text(
                      "Update Product",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    content: SizedBox(
                      width: Get.width * 0.45,
                      height: Get.height * 1.6,
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
                          // "Name".text.bold.xl2.make(),

                          Text(
                            "Product Name",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),

                          // Name TextField
                          TextField(
                            style:
                                TextStyle(color: Colors.grey.withOpacity(0.8)),
                            controller: nameController,
                            enabled: true,
                            decoration: InputDecoration(
                              hintText: product.productName,
                              filled: true,
                              // labelText: "Name",
                              fillColor: Colors.white,
                              labelStyle: TextStyle(fontSize: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(36),
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
                            "Description",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),

                          // Name TextField
                          TextField(
                            style:
                                TextStyle(color: Colors.grey.withOpacity(0.8)),
                            controller: descriptionController,
                            enabled: true,
                            maxLines: 5,
                            decoration: InputDecoration(
                              hintText: product.productDescription,
                              hintMaxLines: 5,

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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CategoryDropdownButton(
                                isUpdateDialog: true,
                                selectedCategroyId: selectedCategroyId,
                                label: "Category",
                                categoryName: categoryName,
                              ),
                              BrandDropdownButton(
                                  isUpdateDialog: true,
                                  brandName: brandName,
                                  label: "Brand",
                                  selectedBrandId: selectedBrandId)
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              UpdateColumn(
                                title: "Originale Price",
                                body: product.fullPrice,
                                controller: originalPrice,
                              ),
                              UpdateColumn(
                                title: "Sale Price",
                                body: product.isSale ? product.salePrice : "-",
                                controller: salePrice,
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              UpdateColumnDelivery(
                                title: "Delivery Time",
                                controller: deliveryDays,
                                body: product.deliveryTime,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  UpdateColumnIsBest(
                                    controller: isBestSelling,
                                    title: "Best selling",
                                    body: product.isBest ? "True" : "False",
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: UpdateColumnIsBest(
                                      controller: isOnSale,
                                      title: "On Sale",
                                      body: product.isSale ? "True" : "False",
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          UpdateColorSelectionWidget(),
                          SizedBox(height: 20),
                          Text(
                            "Images",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Wrap(
                            alignment: WrapAlignment.center,
                            runAlignment: WrapAlignment.center,
                            spacing: 0,
                            runSpacing: 10,
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Upload Section with Dotted Border
                              ProductUpdatePicUpload(imgUrl: imgUrl1),
                              20.widthBox,
                              ProductUpdatePicUpload(imgUrl: imgUrl2),
                              20.widthBox,
                              ProductUpdatePicUpload(imgUrl: imgUrl3),
                              20.widthBox,

                              // Form Fields
                            ],
                          ),

                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                    actions: [
                      SizedBox(
                        width: Get.width * 0.45,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.blue)),
                          onPressed: () async {
                            if (areAllFieldsFilled()) {
                              ProductModel productModel = ProductModel(
                                  brandName: brandName.text,
                                  brandId: selectedBrandId.value,
                                  productColors:
                                      colorsSelectionController.selectedColors,
                                  productId: product.productId,
                                  categoryId: selectedCategroyId.value,
                                  productName: nameController.text,
                                  categoryName: categoryName.text,
                                  salePrice: salePrice.text,
                                  fullPrice: originalPrice.text,
                                  productImages: [
                                    imgUrl1.value,
                                    imgUrl2.value,
                                    imgUrl3.value
                                  ],
                                  deliveryTime: "${deliveryDays.text} days",
                                  isSale: isOnSale.value,
                                  productDescription:
                                      descriptionController.text,
                                  createdAt: product.createdAt,
                                  updatedAt: DateTime.now(),
                                  isBest: isBestSelling.value);
                              await productsController.addProduct(productModel);
                              Get.snackbar(
                                  "Updated", "Product has been updated",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.lightBlueAccent,
                                  colorText: Colors.white);
                              Navigator.pop(context);
                            } else {
                              Get.snackbar(
                                  "Error", "Please fill all necessary details",
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

class UpdateColumnIsBest extends StatelessWidget {
  final String title;
  final String body;
  final RxBool controller;
  const UpdateColumnIsBest(
      {super.key,
      required this.title,
      required this.body,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.088,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),

          // Name TextField
          Obx(
            () => Switch(
                value: controller.value,
                onChanged: (value) {
                  controller.value = value;
                }),
          )
        ],
      ),
    );
  }
}

class UpdateColorSelectionController extends GetxController {
  RxList<dynamic> selectedColors = <dynamic>[].obs;
  RxString hoveredColor = ''.obs;

  void toggleColor(String colorName) {
    if (selectedColors.contains(colorName)) {
      selectedColors.remove(colorName);
    } else {
      selectedColors.add(colorName);
    }
  }
}

class UpdateColorSelectionWidget extends StatelessWidget {
  final UpdateColorSelectionController controller =
      Get.put(UpdateColorSelectionController());

  final List<dynamic> colorNames = [
    'RED',
    'BLUE',
    'GREEN',
    'YELLOW',
    'ORANGE',
    'PURPLE',
    'PINK',
    'BROWN',
    'GREY',
    'BLACK',
    'WHITE',
    'CYAN',
    'TEAL',
    'INDIGO',
    'LIME',
    'AMBER',
    'DEEP ORANGE',
    'DEEP PURPLE',
    'LIGHT BLUE',
    'LIGHT GREEN',
    'RED ACCENT',
    'BLUE ACCENT',
    'GREEN ACCENT',
    'YELLOW ACCENT',
    'ROSE GOLD',
    'BRONZE',
    'SILVER',
    'GOLD',
    'SPACE GRAY'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => Row(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                "Colors".text.bold.xl.make(),
                Text(
                  controller.hoveredColor.value,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            )),
        const SizedBox(height: 10),
        Obx(() => Wrap(
              runSpacing: 10,
              spacing: 10,
              children: colorNames.map((colorName) {
                final color = ColorUtils.getColorFromName(colorName);
                final isSelected =
                    controller.selectedColors.contains(colorName);
                return MouseRegion(
                  onEnter: (_) => controller.hoveredColor.value = colorName,
                  onExit: (_) => controller.hoveredColor.value = '',
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: isSelected ? Colors.black : Colors.grey,
                        width: isSelected ? 4 : 3,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () => controller.toggleColor(colorName),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        // padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            )),
      ],
    );
  }
}

class UpdateColumn extends StatelessWidget {
  final String title;
  final String body;
  final TextEditingController controller;
  const UpdateColumn(
      {super.key,
      required this.title,
      required this.body,
      required this.controller});

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
            controller: controller,
            enabled: true,
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

class UpdateColumnDelivery extends StatelessWidget {
  final String title;
  final String body;
  final TextEditingController controller;
  const UpdateColumnDelivery(
      {super.key,
      required this.title,
      required this.body,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.18,

      // height: Get.height * 0.1,
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
          Row(
            spacing: 20,
            children: [
              SizedBox(
                width: Get.width * 0.08,
                child: TextField(
                  style: TextStyle(color: Colors.grey.withOpacity(0.8)),
                  controller: controller,
                  enabled: true,
                  decoration: InputDecoration(
                    hintText: body,
                    // hintMaxLines: 5,
                    filled: true,
                    // labelText: "Name",
                    fillColor: Colors.white,
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(36),
                      borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.5), width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(36),
                      borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.5), width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(36),
                      borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.5), width: 2),
                    ),
                  ),
                ),
              ),
              "Days".text.xl.color(Colors.grey).make()
            ],
          ),
        ],
      ),
    );
  }
}
