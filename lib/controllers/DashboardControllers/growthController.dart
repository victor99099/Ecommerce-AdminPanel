import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_adminpanel/controllers/DataControllers/BrandController.dart';
import 'package:ecommerce_adminpanel/controllers/DataControllers/CategoryController.dart';
import 'package:ecommerce_adminpanel/controllers/DataControllers/OrderController.dart';
import 'package:ecommerce_adminpanel/controllers/DataControllers/ProductController.dart';
import 'package:ecommerce_adminpanel/models/order-model.dart';
import 'package:ecommerce_adminpanel/models/user-model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../DataControllers/UserController.dart';

class Growth {
  double rate = 0;
  int value = 0;
  Growth(this.rate, this.value) {}
}

class GrowthController extends GetxController {
  final UsersController userControllers = Get.put(UsersController());
  final OrdersController ordersController = Get.put(OrdersController());
  final ProductsController productsController = Get.put(ProductsController());
  final CategoriesController categoriesController =
      Get.put(CategoriesController());
  final BrandsController brandsController = Get.put(BrandsController());

  RxString selectedPeriod = "Month".obs;
  RxString selectedRevenueYear = "2025".obs;
  RxString selectedProductWiseSaleYear = "2025".obs;
  RxString selectedBrandWiseSaleYear = "2025".obs;

  RxBool isLoading = true.obs;
  RxBool isOrdersFetched = false.obs;

  Rx<Growth> userGrowth = Growth(0, 0).obs;
  Rx<Growth> productSoldGrowth = Growth(0, 0).obs;
  Rx<Growth> orderGrowth = Growth(0, 0).obs;

  RxMap<int, double> monthlySales = <int, double>{}.obs;

  RxDouble phoneCategoryRate = 0.0.obs;
  RxDouble televisionCategoryRate = 0.0.obs;
  RxDouble headphoneCategoryRate = 0.0.obs;
  RxDouble tabletsCategoryRate = 0.0.obs;

  RxMap<String, double> brandRates = <String, double>{}.obs;

  @override
  void onInit() async {
    super.onInit();
    await userControllers.fetchUsers();
    await ordersController.fetchAllOrders();
    await categoriesController.fetchCategories();
    await brandsController.fetchBrands();
    isOrdersFetched.value = true;
    await getOrderGrowth();
    await getUserGrowth();
    await getOrderGrowth();
    await getMonthlySalesRevenue();
    await getProductWiseSale();
    await getBrandWiseSale();
    isLoading.value = false;
  }

  Future<void> getUserGrowth() async {
    while (!isOrdersFetched.value) {
      await Future.delayed(Duration(milliseconds: 100));
    }

    final totalUser = userControllers.usersList.length;

    DateTime now = DateTime.now();
    DateTime periodStart;

    switch (selectedPeriod.value) {
      case 'Week':
        periodStart = now.subtract(Duration(days: now.weekday - 1));
      case 'Month':
        periodStart = DateTime(now.year, now.month, 1);
      case 'Year':
      default:
        periodStart = DateTime(now.year, 1, 1);
    }

    int newUsers = userControllers.usersList.where((user) {
      String createdOnStr =
          user.createdOn; // Firebase timestamp stored as a String

      // Extract seconds from the string
      RegExp regex = RegExp(r"seconds=(\d+)");
      Match? match = regex.firstMatch(createdOnStr);

      if (match != null) {
        int seconds = int.parse(match.group(1)!); // Extracted seconds
        DateTime createdOn = DateTime.fromMillisecondsSinceEpoch(
            seconds * 1000); // Convert to DateTime
        print(createdOn);
        return createdOn.isAfter(periodStart);
      }

      return false; // If format is incorrect, ignore this user
    }).length;

    final rate = (newUsers / totalUser) * 100;

    userGrowth.value = Growth(rate, newUsers);
  }

  Future<void> getProductSoldGrowth() async {
    while (!isOrdersFetched.value) {
      await Future.delayed(Duration(milliseconds: 100));
    }

    DateTime now = DateTime.now();
    DateTime periodStart;

    switch (selectedPeriod.value) {
      case 'Week':
        periodStart = now.subtract(Duration(days: now.weekday - 1));
        break;
      case 'Month':
        periodStart = DateTime(now.year, now.month, 1);
        break;
      case 'Year':
      default:
        periodStart = DateTime(now.year, 1, 1);
    }

    final allCartOrders = ordersController.ordersList
        .expand((mainOrder) => mainOrder.cartOrders)
        .toList();

    final totalProductSold =
        allCartOrders.fold(0, (sum, order) => sum + order.productQuantity);

    final newSells = allCartOrders.where((order) {
      DateTime createdOn = (order.createdAt is Timestamp)
          ? (order.createdAt as Timestamp).toDate()
          : order.createdAt;
      return createdOn.isAfter(periodStart);
    }).toList();

    final newProductSolds =
        newSells.fold(0, (sum, order) => sum + order.productQuantity);

    final rate = (newProductSolds / totalProductSold) * 100;

    productSoldGrowth.value = Growth(rate, newProductSolds);
  }

  Future<void> getOrderGrowth() async {
    while (!isOrdersFetched.value) {
      await Future.delayed(Duration(milliseconds: 100));
    }

    final totalOrders = ordersController.ordersList.length;

    DateTime now = DateTime.now();
    DateTime periodStart;

    switch (selectedPeriod.value) {
      case 'Week':
        periodStart = now.subtract(Duration(days: now.weekday - 1));
      case 'Month':
        periodStart = DateTime(now.year, now.month, 1);
      case 'Year':
      default:
        periodStart = DateTime(now.year, 1, 1);
    }

    int newOrders = ordersController.ordersList.where((order) {
      DateTime createdOn = (order.cartOrders[0].createdAt is Timestamp)
          ? (order.cartOrders[0].createdAt as Timestamp).toDate()
          : order.cartOrders[0].createdAt;

      return createdOn.isAfter(periodStart);
    }).length;

    final rate = (newOrders / totalOrders) * 100;
    orderGrowth.value = Growth(rate, newOrders);
  }

  Future<void> getMonthlySalesRevenue() async {
    while (!isOrdersFetched.value) {
      await Future.delayed(Duration(milliseconds: 100));
    }

    monthlySales.clear();
    RxMap<int, double> monthlyTempSales = <int, double>{}.obs;
    DateTime now = DateTime.now();
    int selectedYear =
        selectedRevenueYear.value == "2025" ? now.year : now.year - 1;

    // Expand the MainOrderModel list and extract OrderModel list from it
    List<OrderModel> selectedYearOrders = ordersController.ordersList
        .expand((mainOrder) => mainOrder.cartOrders)
        .where((order) {
      DateTime createdOn = (order.createdAt is Timestamp)
          ? (order.createdAt as Timestamp).toDate()
          : order.createdAt;
      return createdOn.year == selectedYear;
    }).toList();

    // Calculate revenue for existing months
    for (var order in selectedYearOrders) {
      DateTime createdOn = (order.createdAt is Timestamp)
          ? (order.createdAt as Timestamp).toDate()
          : order.createdAt;
      int monthIndex = createdOn.month; // 1 for Jan, 2 for Feb, etc.

      // Sum up total price of products for that month
      double orderTotalPrice = order.productTotalPrice;
      monthlyTempSales.update(monthIndex, (value) => value + orderTotalPrice,
          ifAbsent: () => orderTotalPrice);
    }

    monthlySales.value = monthlyTempSales;
  }

  Future<void> getProductWiseSale() async {
    while (!isOrdersFetched.value) {
      await Future.delayed(Duration(milliseconds: 100));
    }

    double phoneQuantity = 0;
    double televisionQuantity = 0;
    double headphoneQuantity = 0;
    double tabletQuantity = 0;
    double totalQuantity = 0;
    DateTime now = DateTime.now();
    int selectedYear =
        selectedProductWiseSaleYear.value == "2025" ? now.year : now.year - 1;

    // Expand the MainOrderModel list and extract OrderModel list from it
    List<OrderModel> selectedYearOrders = ordersController.ordersList
        .expand(
            (mainOrder) => mainOrder.cartOrders) // Flattening the orderModels
        .where((order) {
      DateTime createdOn = (order.createdAt is Timestamp)
          ? (order.createdAt as Timestamp).toDate()
          : order.createdAt;
      return createdOn.year == selectedYear;
    }).toList();

    totalQuantity = selectedYearOrders.fold(
        0, (value, order) => value + order.productQuantity);

    // Calculate revenue for existing months
    for (var order in selectedYearOrders) {
      switch (order.categoryName) {
        case "Phones":
          phoneQuantity += order.productQuantity;
          break;
        case "Tablets":
          tabletQuantity += order.productQuantity;
          break;
        case "Televisions":
          televisionQuantity += order.productQuantity;
          break;
        case "Headphones":
          headphoneQuantity += order.productQuantity;
          break;
        default:
      }
    }

    phoneCategoryRate.value = phoneQuantity / totalQuantity;
    tabletsCategoryRate.value = tabletQuantity / totalQuantity;
    headphoneCategoryRate.value = headphoneQuantity / totalQuantity;
    televisionCategoryRate.value = televisionQuantity / totalQuantity;
  }

  Future<void> getBrandWiseSale() async {
    while (!isOrdersFetched.value) {
      await Future.delayed(Duration(milliseconds: 100));
    }

    double totalQuantity = 0;
    DateTime now = DateTime.now();
    int selectedYear =
        selectedBrandWiseSaleYear.value == "2025" ? now.year : now.year - 1;

    // Expand the MainOrderModel list and extract OrderModel list from it
    List<OrderModel> selectedYearOrders = ordersController.ordersList
        .expand(
            (mainOrder) => mainOrder.cartOrders) // Flattening the orderModels
        .where((order) {
      DateTime createdOn = (order.createdAt is Timestamp)
          ? (order.createdAt as Timestamp).toDate()
          : order.createdAt;
      return createdOn.year == selectedYear;
    }).toList();

    totalQuantity = selectedYearOrders.fold(
        0, (value, order) => value + order.productQuantity);

    // ✅ Step 1: Reset brandRates (Initialize with all brands)
    brandRates.clear();
    for (var brand in brandsController.brandsList) {
      brandRates[brand.brandName] = 0; // Initialize each brand with 0
    }

    // ✅ Step 2: Calculate brand-wise sales
    for (var order in selectedYearOrders) {
      brandRates[order.brandName!] =
          (brandRates[order.brandName!] ?? 0) + order.productQuantity;
    }

    // ✅ Step 3: Normalize brand rates
    if (totalQuantity > 0) {
      brandRates.updateAll((key, value) => value / totalQuantity);
    }
  }
}
