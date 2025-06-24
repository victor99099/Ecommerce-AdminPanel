
import 'package:ecommerce_adminpanel/Screens/admin-panel/Widgets/DropDownButtons.dart';
import 'package:ecommerce_adminpanel/controllers/DataControllers/BrandController.dart';
import 'package:ecommerce_adminpanel/controllers/DataControllers/CategoryController.dart';
import 'package:ecommerce_adminpanel/controllers/DataControllers/ProductController.dart';

import 'package:ecommerce_adminpanel/controllers/PageController.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';


import 'package:velocity_x/velocity_x.dart';

import '../../../../controllers/UniqueIdGenerator.dart';
import '../../../../models/product-model.dart';
import '../../../../utils/ProductColors.dart';
import '../../Widgets/PicUpload.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryName = TextEditingController();
  final TextEditingController brandName = TextEditingController();
  final TextEditingController originalPrice = TextEditingController();
  final TextEditingController salePrice = TextEditingController();
  final TextEditingController deliveryDays = TextEditingController();

  late RxString selectedCategroyId;
  late RxString selectedBrandId;

  RxnString imgUrl1 = RxnString();
  RxnString imgUrl2 = RxnString();
  RxnString imgUrl3 = RxnString();

  RxBool isBestSelling = false.obs;

  final ColorSelectionController colorsSelectionController =
      Get.put(ColorSelectionController());

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

  final ProductsController productsController = Get.find<ProductsController>();
  CategoriesController categoriesController = Get.find<CategoriesController>();
  BrandsController brandsController = Get.find<BrandsController>();

  final CustomPageController customPageController =
      Get.find<CustomPageController>();

  @override
  void initState() {
    super.initState();
    if (categoriesController.categoriesList.isNotEmpty) {
      selectedCategroyId =
          categoriesController.categoriesList[0].categoryId.obs;
    }
    if (brandsController.brandsList.isNotEmpty) {
      selectedBrandId = brandsController.brandsList[0].brandId.obs;
    }
  }

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 2,
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
                            customPageController.SelectedPage.value = 4;
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.blue)),
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          )),
                      "Add".text.xl3.bold.make(),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: ElevatedButton(
                        onPressed: () async {
                          if (areAllFieldsFilled()) {
                            ProductModel productModel = ProductModel(
                                brandName: brandName.text,
                                brandId: selectedBrandId.value,
                                productColors:
                                    colorsSelectionController.selectedColors,
                                productId: UUIDGenerator.generate(),
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
                                isSale: salePrice.text.contains("-")
                                    ? false
                                    : true,
                                productDescription:
                                    descriptionController.text,
                                createdAt: DateTime.now(),
                                updatedAt: DateTime.now(),
                                isBest: isBestSelling.value);
                            await productsController.addProduct(productModel);
                            Get.snackbar(
                                "Uploaded", "New product has been added",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.lightBlueAccent,
                                colorText: Colors.white);
                            customPageController.SelectedPage.value = 2;
                          } else {
                            Get.snackbar(
                                "Error", "Please fill all necessary details",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.lightBlueAccent,
                                colorText: Colors.white);
                          }
                        },
                        style: ButtonStyle(
                            elevation: WidgetStatePropertyAll(10),
                            padding:
                                WidgetStatePropertyAll(EdgeInsets.all(15)),
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.blue),
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(10)))),
                        child: Text(
                          "Add",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
    
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Upload Section with Dotted Border
                  PicUpload(imgUrl: imgUrl1),
                  20.widthBox,
                  PicUpload(imgUrl: imgUrl2),
                  20.widthBox,
                  PicUpload(imgUrl: imgUrl3),
                  20.widthBox,
    
                  // Form Fields
                ],
              ),
    
              SizedBox(
                height: Get.height * 0.05,
              ),
              Expanded(
                child: Column(
                  spacing: 20,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField("Name", nameController,
                        "The name is how it appears on your site."),
                    _buildTextField("Description", descriptionController,
                        "The description is how it appears on your site.",
                        isMultiline: true),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CategoryDropdownButton(
                          selectedCategroyId: selectedCategroyId,
                          label: "Category",
                          categoryName: categoryName,
                        ),
                        BrandDropdownButton(
                            brandName: brandName,
                            label: "Brand",
                            selectedBrandId: selectedBrandId)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildTextFieldHalf(
                          "Original Price",
                          originalPrice,
                        ),
                        _buildTextFieldHalf(
                          "Sale Price",
                          salePrice,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: customPageController.isCompact.value
                          ? customPageController.isMenuOpen.value
                              ? Get.width * 0.32
                              : Get.width * 0.4
                          : Get.width * 0.32,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildTextFieldDelivery(
                            "Delivery Time In Days",
                            deliveryDays,
                          ),
                          _buildTextFieldBestSelling(
                            "Best Selling",
                            isBestSelling,
                          ),
                        ],
                      ),
                    ),
                    ColorSelectionWidget()
                  ],
                ),
              ),
    
              // Submit Button
            ],
          ),
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
        label.text.bold.xl.make(),
        TextFormField(
          controller: controller,
          maxLines: isMultiline ? 5 : 1,
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
        // 2.heightBox,
      ],
    );
  }

  Widget _buildTextFieldHalf(String label, TextEditingController controller) {
    return Obx(
      () => SizedBox(
        width: customPageController.isCompact.value
            ? customPageController.isMenuOpen.value
                ? Get.width * 0.32
                : Get.width * 0.4
            : Get.width * 0.32,
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            label.text.bold.xl.make(),
            TextFormField(
              controller: controller,
              maxLines: 1,
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
            // 2.heightBox,
          ],
        ),
      ),
    );
  }

  Widget _buildTextFieldDelivery(
      String label, TextEditingController controller) {
    return Obx(
      () => SizedBox(
        width: customPageController.isCompact.value
            ? customPageController.isMenuOpen.value
                ? Get.width * 0.16
                : Get.width * 0.2
            : Get.width * 0.16,
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            label.text.bold.xl.make(),
            Row(
              spacing: 25,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: customPageController.isCompact.value
                      ? customPageController.isMenuOpen.value
                          ? Get.width * 0.1
                          : Get.width * 0.15
                      : Get.width * 0.1,
                  child: TextFormField(
                    controller: controller,
                    maxLines: 1,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelStyle: TextStyle(fontSize: 20),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.5), width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.5), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.5), width: 2),
                      ),
                    ),
                  ),
                ),
                "Days".text.xl.color(Colors.grey).make()
              ],
            ),
            // 2.heightBox,
          ],
        ),
      ),
    );
  }

  Widget _buildTextFieldBestSelling(String label, RxBool controller) {
    return Obx(
      () => SizedBox(
        width: customPageController.isCompact.value
            ? customPageController.isMenuOpen.value
                ? Get.width * 0.16
                : Get.width * 0.2
            : Get.width * 0.16,
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            label.text.bold.xl.make(),
            SizedBox(
                // width: customPageController.isCompact.value
                //     ? customPageController.isMenuOpen.value
                //         ? Get.width * 0.1
                //         : Get.width * 0.15
                //     : Get.width * 0.1,
                child: Switch(
                    value: isBestSelling.value,
                    onChanged: (value) {
                      isBestSelling.value = value;
                    })),
            // 2.heightBox,
          ],
        ),
      ),
    );
  }
}

class ColorSelectionController extends GetxController {
  RxList<String> selectedColors = <String>[].obs;
  RxString hoveredColor = ''.obs;

  void toggleColor(String colorName) {
    if (selectedColors.contains(colorName)) {
      selectedColors.remove(colorName);
    } else {
      selectedColors.add(colorName);
    }
  }
}

class ColorSelectionWidget extends StatelessWidget {
  final ColorSelectionController controller =
      Get.put(ColorSelectionController());

  final List<String> colorNames = [
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  child: GestureDetector(
                    onTap: () => controller.toggleColor(colorName),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? Colors.black : Colors.white,
                          width: isSelected ? 4 : 3,
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
