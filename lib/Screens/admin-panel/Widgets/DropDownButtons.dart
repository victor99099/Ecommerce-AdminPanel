import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ecommerce_adminpanel/controllers/DataControllers/UserController.dart';
import 'package:ecommerce_adminpanel/controllers/PageController.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:velocity_x/velocity_x.dart';

import '../../../controllers/DashboardControllers/growthController.dart';
import '../../../controllers/DataControllers/BrandController.dart';
import '../../../controllers/DataControllers/CategoryController.dart';

class DashboardGrowthDropdownButton extends StatefulWidget {
  DashboardGrowthDropdownButton();
  @override
  State<DashboardGrowthDropdownButton> createState() =>
      _DashboardGrowthDropdownButtonState();
}

class _DashboardGrowthDropdownButtonState
    extends State<DashboardGrowthDropdownButton> {
  // BrandsController brandsController = Get.find<BrandsController>();
  // UsersController usersController = Ge
  CustomPageController customPageController = Get.find<CustomPageController>();
  GrowthController growthController = Get.find<GrowthController>();
  List<String> options = ['Year', 'Month', 'Week'];
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 2,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "Growth This",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ),
          SizedBox(
            width: customPageController.isCompact.value
                ? customPageController.isMenuOpen.value
                    ? Get.width * 0.12
                    : Get.width * 0.14
                : Get.width * 0.14,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.grey.withOpacity(0.5))),
              child: DropdownButton2(
                underline: SizedBox(),
                isExpanded: true,
                hint: Text(
                  'Select an Option',
                  style: TextStyle(fontSize: 14),
                ),
                items: [
                  DropdownMenuItem(
                    child: Row(
                      spacing: 10,
                      children: [
                        Text(options[0]),
                      ],
                    ),
                    value: options[0],
                  ),
                  DropdownMenuItem(
                    child: Row(
                      spacing: 10,
                      children: [
                        Text(options[1]),
                      ],
                    ),
                    value: options[1],
                  ),
                  DropdownMenuItem(
                    child: Row(
                      spacing: 10,
                      children: [
                        Text(options[2]),
                      ],
                    ),
                    value: options[2],
                  ),
                ],
                dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10))),
                value: growthController.selectedPeriod.value,
                onChanged: (value) async {
                  growthController.selectedPeriod.value = value!;
                  growthController.isLoading.value = true;
                  await growthController.getUserGrowth();
                  await growthController.getProductSoldGrowth();
                  await growthController.getOrderGrowth();
                  growthController.isLoading.value = false;

                  print("Selected: $value");
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DashboardRevenueDropdownButton extends StatefulWidget {
  DashboardRevenueDropdownButton();
  @override
  State<DashboardRevenueDropdownButton> createState() =>
      _DashboardRevenueDropdownButtonState();
}

class _DashboardRevenueDropdownButtonState
    extends State<DashboardRevenueDropdownButton> {
  // BrandsController brandsController = Get.find<BrandsController>();
  // UsersController usersController = Ge
  CustomPageController customPageController = Get.find<CustomPageController>();
  GrowthController growthController = Get.find<GrowthController>();
  List<String> options = ['2025', '2024'];
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: customPageController.isCompact.value
            ? customPageController.isMenuOpen.value
                ? Get.width * 0.12
                : Get.width * 0.14
            : Get.width * 0.14,
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.grey.withOpacity(0.5))),
          child: DropdownButton2(
            underline: SizedBox(),
            isExpanded: true,
            hint: Text(
              'Select an Option',
              style: TextStyle(fontSize: 14),
            ),
            style: TextStyle(fontSize: 14),
            items: [
              DropdownMenuItem(
                child: Row(
                  spacing: 10,
                  children: [
                    Text(options[0]),
                  ],
                ),
                value: options[0],
              ),
              DropdownMenuItem(
                child: Row(
                  spacing: 10,
                  children: [
                    Text(options[1]),
                  ],
                ),
                value: options[1],
              ),
            ],
            dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10))),
            value: growthController.selectedRevenueYear.value,
            onChanged: (value) async {
              growthController.selectedRevenueYear.value = value!;
              growthController.isLoading.value = true;
              await growthController.getMonthlySalesRevenue();
              growthController.isLoading.value = false;
              print("Selected: $value");
            },
          ),
        ),
      ),
    );
  }
}

class DashboardProductWiseDropdownButton extends StatefulWidget {
  DashboardProductWiseDropdownButton();
  @override
  State<DashboardProductWiseDropdownButton> createState() =>
      _DashboardProductWiseDropdownButtonState();
}

class _DashboardProductWiseDropdownButtonState
    extends State<DashboardProductWiseDropdownButton> {
  // BrandsController brandsController = Get.find<BrandsController>();
  // UsersController usersController = Ge
  CustomPageController customPageController = Get.find<CustomPageController>();
  GrowthController growthController = Get.find<GrowthController>();
  List<String> options = ['2025', '2024'];
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: customPageController.isCompact.value
            ? customPageController.isMenuOpen.value
                ? Get.width * 0.12
                : Get.width * 0.14
            : Get.width * 0.14,
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.grey.withOpacity(0.5))),
          child: DropdownButton2(
            underline: SizedBox(),
            isExpanded: true,
            hint: Text(
              'Select an Option',
              style: TextStyle(fontSize: 14),
            ),
            style: TextStyle(fontSize: 14),
            items: [
              DropdownMenuItem(
                child: Row(
                  spacing: 10,
                  children: [
                    Text(options[0]),
                  ],
                ),
                value: options[0],
              ),
              DropdownMenuItem(
                child: Row(
                  spacing: 10,
                  children: [
                    Text(options[1]),
                  ],
                ),
                value: options[1],
              ),
            ],
            dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10))),
            value: growthController.selectedProductWiseSaleYear.value,
            onChanged: (value) async {
              growthController.selectedProductWiseSaleYear.value = value!;
              growthController.isLoading.value = true;
              await growthController.getProductWiseSale();
              growthController.isLoading.value = false;
              // print("Selected: $value");
            },
          ),
        ),
      ),
    );
  }
}

class DashboardBrandWiseDropdownButton extends StatefulWidget {
  DashboardBrandWiseDropdownButton();
  @override
  State<DashboardBrandWiseDropdownButton> createState() =>
      _DashboardBrandWiseDropdownButtonState();
}

class _DashboardBrandWiseDropdownButtonState
    extends State<DashboardBrandWiseDropdownButton> {
  // BrandsController brandsController = Get.find<BrandsController>();
  // UsersController usersController = Ge
  CustomPageController customPageController = Get.find<CustomPageController>();
  GrowthController growthController = Get.find<GrowthController>();
  List<String> options = ['2025', '2024'];
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: customPageController.isCompact.value
            ? customPageController.isMenuOpen.value
                ? Get.width * 0.12
                : Get.width * 0.14
            : Get.width * 0.14,
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.grey.withOpacity(0.5))),
          child: DropdownButton2(
            underline: SizedBox(),
            isExpanded: true,
            hint: Text(
              'Select an Option',
              style: TextStyle(fontSize: 14),
            ),
            style: TextStyle(fontSize: 14),
            items: [
              DropdownMenuItem(
                child: Row(
                  spacing: 10,
                  children: [
                    Text(options[0]),
                  ],
                ),
                value: options[0],
              ),
              DropdownMenuItem(
                child: Row(
                  spacing: 10,
                  children: [
                    Text(options[1]),
                  ],
                ),
                value: options[1],
              ),
            ],
            dropdownStyleData: DropdownStyleData(
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10))),
            value: growthController.selectedBrandWiseSaleYear.value,
            onChanged: (value) async {
              growthController.selectedBrandWiseSaleYear.value = value!;
              growthController.isLoading.value = true;
              await growthController.getBrandWiseSale();
              growthController.isLoading.value = false;
              // print("Selected: $value");
            },
          ),
        ),
      ),
    );
  }
}

class CategoryDropdownButton extends StatefulWidget {
  final String label;
  RxString selectedCategroyId;
  final TextEditingController categoryName;
  bool isUpdateDialog;
  CategoryDropdownButton(
      {this.isUpdateDialog = false,
      required this.label,
      required this.categoryName,
      required this.selectedCategroyId});
  @override
  State<CategoryDropdownButton> createState() => _CategoryDropdownButtonState();
}

class _CategoryDropdownButtonState extends State<CategoryDropdownButton> {
  CategoriesController categoriesController = Get.find<CategoriesController>();
  CustomPageController customPageController = Get.find<CustomPageController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Row(
              spacing: 10,
              children: [
                Icon(Iconsax.category),
                widget.label.text.bold.xl.make(),
              ],
            ),
          ),
          SizedBox(
            width: widget.isUpdateDialog
                ? customPageController.isCompact.value
                    ? customPageController.isMenuOpen.value
                        ? Get.width * 0.18
                        : Get.width * 0.2
                    : Get.width * 0.18
                : customPageController.isCompact.value
                    ? customPageController.isMenuOpen.value
                        ? Get.width * 0.32
                        : Get.width * 0.4
                    : Get.width * 0.32,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey.withOpacity(0.5))),
              child: DropdownButton2(
                underline: SizedBox(),
                isExpanded: true,
                hint: Text(
                  'Select an Option',
                  style: TextStyle(fontSize: 16),
                ),
                items: categoriesController.categoriesList.map((category) {
                  return DropdownMenuItem(
                    child: Row(
                      children: [
                        Image.network(
                          category.categoryImage,
                          width: 50,
                          height: 50,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.error_outline,
                                color: Colors.red, size: 50);
                          },
                        ),
                        Text(category.categoryName),
                      ],
                    ),
                    value: category.categoryId,
                  );
                }).toList(),
                dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12))),
                value: widget.selectedCategroyId!.value,
                onChanged: (value) {
                  // setState(() {
                  widget.selectedCategroyId!.value = value!;
                  // });
                  final selectedCategorty = categoriesController.categoriesList
                      .firstWhere((category) => category.categoryId == value);
                  widget.categoryName.text = selectedCategorty.categoryName;
                  print("Selected: $value");
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BrandDropdownButton extends StatefulWidget {
  final String label;
  RxString selectedBrandId;
  final TextEditingController brandName;
  bool isUpdateDialog;
  BrandDropdownButton(
      {this.isUpdateDialog = false,
      required this.label,
      required this.brandName,
      required this.selectedBrandId});
  @override
  State<BrandDropdownButton> createState() => _BrandDropdownButtonState();
}

class _BrandDropdownButtonState extends State<BrandDropdownButton> {
  BrandsController brandsController = Get.find<BrandsController>();
  CustomPageController customPageController = Get.find<CustomPageController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Row(
              spacing: 10,
              children: [
                Icon(
                  Iconsax.shop,
                ),
                widget.label.text.bold.xl.make(),
              ],
            ),
          ),
          SizedBox(
            width: widget.isUpdateDialog
                ? customPageController.isCompact.value
                    ? customPageController.isMenuOpen.value
                        ? Get.width * 0.18
                        : Get.width * 0.2
                    : Get.width * 0.18
                : customPageController.isCompact.value
                    ? customPageController.isMenuOpen.value
                        ? Get.width * 0.32
                        : Get.width * 0.4
                    : Get.width * 0.32,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey.withOpacity(0.5))),
              child: DropdownButton2(
                underline: SizedBox(),
                isExpanded: true,
                hint: Text(
                  'Select an Option',
                  style: TextStyle(fontSize: 16),
                ),
                items: brandsController.brandsList.map((brand) {
                  return DropdownMenuItem(
                    child: Row(
                      spacing: 10,
                      children: [
                        Image.network(
                          brand.brandImage,
                          width: 50,
                          height: 50,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.error_outline,
                                color: Colors.red, size: 50);
                          },
                        ),
                        Text(brand.brandName),
                      ],
                    ),
                    value: brand.brandId,
                  );
                }).toList(),
                dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12))),
                value: widget.selectedBrandId!.value,
                onChanged: (value) {
                  widget.selectedBrandId!.value = value!;

                  // Find the selected brand name
                  final selectedBrand = brandsController.brandsList
                      .firstWhere((brand) => brand.brandId == value);

                  widget.brandName.text = selectedBrand.brandName;

                  print("Selected: $value");
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UserDropdownButton extends StatefulWidget {
  final String label;
  RxBool selectedRole;
  final List<String> options;
  UserDropdownButton(
      {required this.label, required this.selectedRole, required this.options});
  @override
  State<UserDropdownButton> createState() => _UserDropdownButtonState();
}

class _UserDropdownButtonState extends State<UserDropdownButton> {
  // BrandsController brandsController = Get.find<BrandsController>();
  // UsersController usersController = Ge
  CustomPageController customPageController = Get.find<CustomPageController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              widget.label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: customPageController.isCompact.value
                ? customPageController.isMenuOpen.value
                    ? Get.width * 0.18
                    : Get.width * 0.2
                : Get.width * 0.2,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(36),
                  side: BorderSide(color: Colors.grey.withOpacity(0.5))),
              child: DropdownButton2(
                underline: SizedBox(),
                isExpanded: true,
                hint: Text(
                  'Select an Option',
                  style: TextStyle(fontSize: 16),
                ),
                items: [
                  DropdownMenuItem(
                    child: Row(
                      spacing: 10,
                      children: [
                        Text(widget.options[0]),
                      ],
                    ),
                    value: true,
                  ),
                  DropdownMenuItem(
                    child: Row(
                      spacing: 10,
                      children: [
                        Text(widget.options[1]),
                      ],
                    ),
                    value: false,
                  ),
                ],
                dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12))),
                value: widget.selectedRole.value,
                onChanged: (value) {
                  widget.selectedRole.value = value!;
                  print("Selected: $value");
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderDropdownButton extends StatefulWidget {
  final String label;
  RxBool selectedRole;
  final List<String> options;
  OrderDropdownButton(
      {required this.label, required this.selectedRole, required this.options});
  @override
  State<OrderDropdownButton> createState() => _OrderDropdownButtonState();
}

class _OrderDropdownButtonState extends State<OrderDropdownButton> {
  // BrandsController brandsController = Get.find<BrandsController>();
  // UsersController usersController = Ge

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        spacing: 5,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              widget.label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: Get.width * 0.22,
            child: Card(
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(36),
                  side: BorderSide(color: Colors.grey)),
              child: DropdownButton2(
                underline: SizedBox(),
                isExpanded: true,
                hint: Text(
                  'Select an Option',
                  style: TextStyle(fontSize: 16),
                ),
                items: [
                  DropdownMenuItem(
                    child: Row(
                      spacing: 10,
                      children: [
                        Text(widget.options[0]),
                      ],
                    ),
                    value: true,
                  ),
                  DropdownMenuItem(
                    child: Row(
                      spacing: 10,
                      children: [
                        Text(widget.options[1]),
                      ],
                    ),
                    value: false,
                  ),
                ],
                dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12))),
                value: widget.selectedRole.value,
                onChanged: (value) {
                  widget.selectedRole.value = value!;
                  print("Selected: $value");
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
