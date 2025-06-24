import 'package:ecommerce_adminpanel/Screens/admin-panel/Sections/Brand/AddBrand.dart';
import 'package:ecommerce_adminpanel/Screens/admin-panel/Sections/Brand/BrandSection.dart';
import 'package:ecommerce_adminpanel/Screens/admin-panel/Sections/Category/CategorySection.dart';
import 'package:ecommerce_adminpanel/Screens/admin-panel/Sections/Orders/OrderSection.dart';
import 'package:ecommerce_adminpanel/Screens/admin-panel/Sections/Products.dart/AddPrdocut.dart';
import 'package:ecommerce_adminpanel/Screens/admin-panel/Sections/Products.dart/ProductSection.dart';
import 'package:ecommerce_adminpanel/Screens/admin-panel/Sections/Users/UserSection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Screens/admin-panel/Sections/Category/AddCategory.dart';
import '../Screens/admin-panel/Sections/Dashboard/DashboardSection.dart';
import '../Screens/admin-panel/Sections/Promotions/PromotionSection.dart';

class CustomPageController extends GetxController {
  final PageController pageViewController = PageController();
  void changePage(int index) {
    SelectedPage.value = index;
    pageViewController.animateToPage(
      index,
      duration: Duration(milliseconds: 300), // Smooth animation
      curve: Curves.easeInOut,
    );
  }

  RxInt SelectedPage = 9.obs;
  RxBool isMenuOpen = false.obs;
  RxBool isCompact = false.obs;
  final screens = [
    CategorySection(),
    AddCategoryPage(),
    BrandSection(),
    AddBrandPage(),
    ProductSection(),
    AddProductPage(),
    UserSection(),
    OrderSection(),
    PromotionSection(),
    DashboardSection()
  ];
}
