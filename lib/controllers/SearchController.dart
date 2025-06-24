import 'package:ecommerce_adminpanel/controllers/DataControllers/BrandController.dart';
import 'package:ecommerce_adminpanel/controllers/DataControllers/CategoryController.dart';
import 'package:ecommerce_adminpanel/controllers/DataControllers/OrderController.dart';
import 'package:ecommerce_adminpanel/controllers/DataControllers/ProductController.dart';
import 'package:ecommerce_adminpanel/controllers/DataControllers/UserController.dart';
import 'package:ecommerce_adminpanel/controllers/PageController.dart';
import 'package:ecommerce_adminpanel/models/order-model.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/brand-model.dart';
import '../models/categories-model.dart';
import '../models/product-model.dart';
import '../models/user-model.dart';

class SearcherController extends GetxController {
  RxString searchText = ''.obs;
  RxBool isSearching = false.obs;
  CategoriesController categoriesController = Get.put(CategoriesController());
  BrandsController brandsController = Get.put(BrandsController());
  ProductsController productsController = Get.put(ProductsController());
  UsersController usersController = Get.put(UsersController());
  OrdersController ordersController = Get.put(OrdersController());
  CustomPageController customPageController = Get.find<CustomPageController>();

  RxList<BrandModel> filteredbrandsList = <BrandModel>[].obs;
  RxList<CategoriesModel> filteredcategoriesList = <CategoriesModel>[].obs;
  RxList<MainOrderModel> filteredordersList = <MainOrderModel>[].obs;
  RxList<ProductModel> filteredproductsList = <ProductModel>[].obs;
  RxList<UserModel> filteredusersList = <UserModel>[].obs;

  void filterList() {
    if (searchText.isNotEmpty) {
      isSearching.value = true;
      if (customPageController.SelectedPage.value == 0) {
        filteredcategoriesList.value =
            categoriesController.categoriesList.where((category) {
          return category.categoryName
                  .toLowerCase()
                  .contains(searchText.value) ||
              category.categoryId.toLowerCase().contains(searchText.value);
        }).toList();
      } else if (customPageController.SelectedPage.value == 2) {
        filteredbrandsList.value = brandsController.brandsList.where((brand) {
          return brand.brandName.toLowerCase().contains(searchText.value) ||
              brand.brandId.toLowerCase().contains(searchText.value);
        }).toList();
      } else if (customPageController.SelectedPage.value == 4) {
        filteredproductsList.value =
            productsController.productsList.where((product) {
          return product.brandName.toLowerCase().contains(searchText.value) ||
              product.brandId.toLowerCase().contains(searchText.value) ||
              product.categoryName.toLowerCase().contains(searchText.value) ||
              product.categoryId.toLowerCase().contains(searchText.value) ||
              product.productName.toLowerCase().contains(searchText.value) ||
              product.productId.toLowerCase().contains(searchText.value);
        }).toList();
      } else if (customPageController.SelectedPage.value == 6) {
        filteredusersList.value = usersController.usersList.where((user) {
          return user.username.toLowerCase().contains(searchText.value) ||
              user.uId.toLowerCase().contains(searchText.value) ||
              user.email.toLowerCase().contains(searchText.value) ||
              user.country.toLowerCase().contains(searchText.value) ||
              user.phone.toLowerCase().contains(searchText.value);
        }).toList();
      } else if (customPageController.SelectedPage.value == 7) {
        filteredordersList.value = ordersController.ordersList.where((order) {
          return order.customerName.toLowerCase().contains(searchText.value) ||
              order.uId.toLowerCase().contains(searchText.value) ||
              order.cartOrders[0].productName
                  .toLowerCase()
                  .contains(searchText.value) ||
              order.orderId.toLowerCase().contains(searchText.value);
        }).toList();
      }
    } else {
      isSearching.value = false;
    }
  }
}
