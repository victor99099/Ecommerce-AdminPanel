import 'package:ecommerce_adminpanel/Screens/admin-panel/Sections/Users/UserInfo.dart';
import 'package:ecommerce_adminpanel/Screens/admin-panel/Sections/Users/UserUpdate.dart';
import 'package:ecommerce_adminpanel/controllers/DataControllers/BrandController.dart';
import 'package:ecommerce_adminpanel/controllers/DataControllers/UserController.dart';

import 'package:ecommerce_adminpanel/models/user-model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:velocity_x/velocity_x.dart';

import '../../../../controllers/DataControllers/CategoryController.dart';

import '../../../../controllers/PageController.dart';
import '../../../../controllers/SearchController.dart';

class UserSection extends StatefulWidget {
  const UserSection({super.key});

  @override
  _UserSectionState createState() => _UserSectionState();
}

class _UserSectionState extends State<UserSection> {
  final CustomPageController customPageController =
      Get.find<CustomPageController>();
  // final ProductsController productsController = Get.put(ProductsController());
  final UsersController usersController = Get.put(UsersController());
  BrandsController brandsController = Get.put(BrandsController());
  CategoriesController categoriesController = Get.put(CategoriesController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 1.2,
        color: const Color(0xFFf0f1f1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: Get.height * 0.05,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: Get.width * 0.035),
                // child: Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                child: Row(
                  spacing: 10,
                  children: [
                    Icon(
                      Iconsax.profile_2user5,
                      size: 30,
                      color: Colors.blue,
                    ),
                    Text(
                      "Users",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.8),
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                // Text(
                //   "Showcase brands for better trust",
                //   style: TextStyle(
                //       color: Colors.black.withOpacity(0.6), fontSize: 16),
                // ),
                //   ],
                // ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.05,
            ),
            Obx(
              () => SizedBox(
                width: customPageController.isCompact.value
                    ? customPageController.isMenuOpen.value
                        ? MediaQuery.of(context).size.width * 0.72
                        : MediaQuery.of(context).size.width * 0.92
                    : MediaQuery.of(context).size.width * 0.75,
                // height: MediaQuery.of(context).size.height * 1.4,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        dividerTheme: DividerThemeData(
                          color: Colors.grey
                              .withOpacity(0.6), // Set the row border color
                          thickness: 1.5, // Adjust border thickness
                        ),
                        dataTableTheme: DataTableThemeData(
                          // headingRowAlignment: MainAxisAlignment.center,
                          columnSpacing: 0,

                          dividerThickness:
                              1.5, // Ensures row borders are visible
                        ),
                        cardTheme: CardTheme(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: const Color.fromARGB(255, 221, 220, 220),
                                width: 1.0), // Border color and width
                            borderRadius:
                                BorderRadius.circular(12.0), // Border radius
                          ),
                          color: Colors.white, // Card background color
                          elevation: 4.0, // Card elevation
                        ),
                      ),
                      child: Obx(
                        () => usersController.usersList.length == 0
                            ? Center(
                                child: CircularProgressIndicator(
                                color: Colors.blue,
                              ))
                            : PaginatedDataTable(
                                columnSpacing: 0,
                                showCheckboxColumn: false,
                                dataRowHeight: Get.height * 0.1,
                                headingRowHeight: Get.height * 0.1,
                                // header: Text("Category List"),
                                // horizontalMargin: 0,
                                headingRowColor: WidgetStatePropertyAll(
                                    Colors.blue.withOpacity(0.2)),
                                rowsPerPage:
                                    6, // Adjust the number of rows per page
                                columns: [
                                  DataColumn(
                                      label: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.02,
                                          child: Icon(
                                            Iconsax.profile_2user,
                                            color: const Color.fromARGB(
                                                255, 13, 51, 82),
                                          ))),
                                  DataColumn(
                                      label: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          child: Text(
                                            "Name",
                                            style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 13, 51, 82),
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ))),
                                  DataColumn(
                                      label: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.14,
                                    child: Center(
                                      child: Text("Email",
                                          style: TextStyle(
                                              color: const Color.fromARGB(
                                                  255, 13, 51, 82),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  )),
                                  DataColumn(
                                      label: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.08,
                                          child: Center(
                                            child: Text("Phone",
                                                style: TextStyle(
                                                    color: const Color.fromARGB(
                                                        255, 13, 51, 82),
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ))),
                                  // DataColumn(label: Text("Description")),
                                  DataColumn(
                                      label: SizedBox(
                                    width: Get.width * 0.06,
                                    child: Center(
                                      child: Text("Country",
                                          style: TextStyle(
                                              color: const Color.fromARGB(
                                                  255, 13, 51, 82),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  )),
                                  DataColumn(
                                      label: SizedBox(
                                    width: Get.width * 0.06,
                                    child: Center(
                                      child: Text("City",
                                          softWrap: true,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: const Color.fromARGB(
                                                  255, 13, 51, 82),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  )),
                                  DataColumn(
                                      label: SizedBox(
                                    width: Get.width * 0.06,
                                    child: Center(
                                      child: Text("Role",
                                          style: TextStyle(
                                              color: const Color.fromARGB(
                                                  255, 13, 51, 82),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  )),
                                  // DataColumn(
                                  //     label: SizedBox(
                                  //   width: Get.width * 0.06,
                                  //   child: Center(
                                  //     child: Text("Active",
                                  //         style: TextStyle(
                                  //             color: const Color.fromARGB(
                                  //                 255, 13, 51, 82),
                                  //             fontSize: 16,
                                  //             fontWeight: FontWeight.bold)),
                                  //   ),
                                  // )),
                                  // DataColumn(
                                  //     label: SizedBox(
                                  //   width: Get.width * 0.08,
                                  //   child: Center(
                                  //     child: Text("Created On",
                                  //         style: TextStyle(
                                  //             color: const Color.fromARGB(
                                  //                 255, 13, 51, 82),
                                  //             fontSize: 16,
                                  //             fontWeight: FontWeight.bold)),
                                  //   ),
                                  // )),

                                  DataColumn(
                                      label: SizedBox(
                                    width: Get.width * 0.02,
                                    child: Center(
                                      child: Text("Edit",
                                          style: TextStyle(
                                              color: const Color.fromARGB(
                                                  255, 13, 51, 82),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  )),
                                  DataColumn(
                                      label: SizedBox(
                                    width: Get.width * 0.05,
                                    child: Center(
                                      child: Text("Delete",
                                          style: TextStyle(
                                              color: const Color.fromARGB(
                                                  255, 13, 51, 82),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  )),
                                ],
                                source: ProductDataSource(
                                    context), // Custom data source
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductDataSource extends DataTableSource {
  // final ProductsController productsController = Get.put(ProductsController());
  // late List<ProductModel> products;
  final UsersController usersController = Get.find<UsersController>();
  late List<UserModel> users;
  final SearcherController searchController = Get.find<SearcherController>();
  final BuildContext context;
  final RxMap<int, bool> isActiveValues = <int, bool>{}.obs;
  final RxMap<int, bool> isAdminValues = <int, bool>{}.obs;
  ProductDataSource(this.context) {
    usersController.fetchUsers();
    users = searchController.isSearching.value
        ? searchController.filteredusersList
        : usersController.usersList;
    // productsController.fetchProducts();
    // products = productsController.productsList;
  }

  @override
  DataRow getRow(int index) {
    final user = users[index];
    isActiveValues[index] ??= user.isActive;
    isActiveValues[index] ??= user.isAdmin;
    // String formattedDate =
    //     DateFormat('dd-MM HH:mm').format(product.brandIdcreatedAt.toDate());
    return DataRow(
      onSelectChanged: (value) {
        if (value!) {
          showUserInfoDialog(context, user);
        }
      },
      cells: [
        DataCell(SizedBox(
            width: Get.width * 0.02,
            // height: Get.height * 0.2,
            child: CircleAvatar(
                child: user.userImg.isEmpty
                    ? Text(user.username[0].firstLetterUpperCase())
                    : Image.network(
                        user.userImg,
                        width: 40,
                        height: 40,
                        errorBuilder: (context, error, stackTrace) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(Icons.error_outline,
                                color: Colors.red, size: 30),
                          );
                        },
                      )))),
        DataCell(SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
          child: Text(
            user.username,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        )),
        DataCell(SizedBox(
          width: MediaQuery.of(context).size.width * 0.14,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                user.email,
                textAlign: TextAlign.center,
                // overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 11,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        )),
        DataCell(SizedBox(
          width: MediaQuery.of(context).size.width * 0.08,
          child: Center(
            child: Text(
              user.phone.isEmpty ? "null" : user.phone,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
          ),
        )),
        DataCell(SizedBox(
          width: MediaQuery.of(context).size.width * 0.06,
          child: Center(
            child: Text(
              user.country.isEmpty ? "null" : user.country,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
          ),
        )),
        DataCell(SizedBox(
          width: MediaQuery.of(context).size.width * 0.06,
          child: Center(
            child: Text(
              user.city.isEmpty ? "null" : user.city,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
          ),
        )),
        DataCell(SizedBox(
          width: MediaQuery.of(context).size.width * 0.06,
          child: Center(
            child: Text(
              user.isAdmin ? "Admin" : "User",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
          ),
        )),
        // DataCell(SizedBox(
        //   width: MediaQuery.of(context).size.width * 0.06,
        //   child: Center(
        //     child: Text(
        //       user.isActive ? "Active" : "Inactive",
        //       style: TextStyle(
        //           color: Colors.black,
        //           fontWeight: FontWeight.bold,
        //           fontSize: 13),
        //     ),
        //   ),
        // )),

        // DataCell(SizedBox(
        //   width: Get.width * 0.07,
        //   child: Center(
        //     child: Text(
        //       "",
        //       style:
        //           TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        //     ),
        //   ),
        // )),

        DataCell(SizedBox(
            width: Get.width * 0.02,
            child: Center(
                child: IconButton(
              onPressed: () {
                showUserUpdateDialog(context, user);
              },
              icon: Icon(Iconsax.edit,
                  weight: 10, color: const Color.fromARGB(255, 9, 46, 77)),
            )))), // Edit icon
        DataCell(SizedBox(
            width: Get.width * 0.05,
            child: Center(
              child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Confirm Deletion"),
                        content: Text(
                            "Are you sure you want to delete this product?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Close the dialog
                            },
                            child: Text("Cancel",
                                style: TextStyle(color: Colors.grey)),
                          ),
                          TextButton(
                            onPressed: () async {
                              await usersController.deleteUser(user.uId);
                              Get.snackbar("Deleted", "User has been removed",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.lightBlueAccent,
                                  colorText: Colors.white);
                              Navigator.pop(context); // Close the dialog
                            },
                            child: Text("Delete",
                                style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(Iconsax.trash,
                    weight: 19, color: const Color.fromARGB(255, 167, 28, 15)),
              ),
            ))), // Delete icon
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => users.length;
  @override
  int get selectedRowCount => 0;
}
