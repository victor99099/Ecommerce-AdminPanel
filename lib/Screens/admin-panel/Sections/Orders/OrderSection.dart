import 'package:ecommerce_adminpanel/Screens/admin-panel/Sections/Orders/OrderInfo.dart';
import 'package:ecommerce_adminpanel/controllers/DataControllers/OrderController.dart';
import 'package:ecommerce_adminpanel/models/order-model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../../controllers/PageController.dart';
import '../../../../controllers/SearchController.dart';
import 'OrderUpdate.dart';

class OrderSection extends StatefulWidget {
  const OrderSection({super.key});

  @override
  _OrderSectionState createState() => _OrderSectionState();
}

class _OrderSectionState extends State<OrderSection> {
  final CustomPageController customPageController =
      Get.find<CustomPageController>();
  // final ProductsController productsController = Get.put(ProductsController());
  // final UsersController usersController = Get.put(UsersController());
  // BrandsController brandsController = Get.put(BrandsController());
  // CategoriesController categoriesController = Get.put(CategoriesController());
  final OrdersController ordersController = Get.put(OrdersController());
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
                      Iconsax.receipt_15,
                      size: 30,
                      color: Colors.blue,
                    ),
                    Text(
                      "Orders",
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
                        ? MediaQuery.of(context).size.width * 0.78
                        : MediaQuery.of(context).size.width * 0.95
                    : MediaQuery.of(context).size.width * 0.78,
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
                        () => ordersController.ordersList.length == 0
                            ? Center(
                                child: CircularProgressIndicator(
                                color: Colors.blue,
                              ))
                            : PaginatedDataTable(
                                columnSpacing: 0,
                                showCheckboxColumn: false,
                                dataRowHeight: Get.height * 0.1,
                                headingRowHeight: Get.height * 0.14,
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
                                              0.03,
                                          child: Text(
                                            "Id",
                                            style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 13, 51, 82),
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ))),
                                  DataColumn(
                                      label: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.07,
                                          child: Text(
                                            "Customer Name",
                                            softWrap: true,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 13, 51, 82),
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ))),
                                  DataColumn(
                                      label: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.07,
                                    child: Center(
                                      child: Text("Customer Number",
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text("Customer Address",
                                                  softWrap: true,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 13, 51, 82),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ))),
                                  // DataColumn(label: Text("Description")),

                                  DataColumn(
                                      label: SizedBox(
                                    width: Get.width * 0.06,
                                    child: Center(
                                      child: Text("Items",
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
                                      child: Text("Total Price",
                                          textAlign: TextAlign.center,
                                          softWrap: true,
                                          style: TextStyle(
                                              color: const Color.fromARGB(
                                                  255, 13, 51, 82),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  )),
                                  DataColumn(
                                      label: SizedBox(
                                    width: Get.width * 0.07,
                                    child: Center(
                                      child: Text("Placed On",
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
                                    width: Get.width * 0.07,
                                    child: Center(
                                      child: Text("Status",
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
  final OrdersController ordersController = Get.find<OrdersController>();
  late List<MainOrderModel> orders;
  final BuildContext context;
  final SearcherController searchController = Get.find<SearcherController>();
  // final RxMap<int, bool> isActiveValues = <int, bool>{}.obs;
  // final RxMap<int, bool> isAdminValues = <int, bool>{}.obs;
  ProductDataSource(this.context) {
    ordersController.fetchAllOrders();
    orders = searchController.isSearching.value
        ? searchController.filteredordersList
        : ordersController.ordersList;
    // productsController.fetchProducts();
    // products = productsController.productsList;
  }

  @override
  DataRow getRow(int index) {
    final order = orders[index];
    // isActiveValues[index] ??= user.isActive;
    // isActiveValues[index] ??= user.isAdmin;
    // String formattedDate =
    //     DateFormat('dd-MM HH:mm').format(product.brandIdcreatedAt.toDate());
    return DataRow(
      onSelectChanged: (value) {
        if (value!) {
          showOrderInfoDialog(context, order);
        }
      },
      cells: [
        DataCell(SizedBox(
          width: MediaQuery.of(context).size.width * 0.03,
          child: Text(
            order.orderId,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13),
          ),
        )),
        DataCell(SizedBox(
          width: MediaQuery.of(context).size.width * 0.07,
          child: Text(
            order.customerName,
            softWrap: false,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13),
          ),
        )),
        DataCell(SizedBox(
          width: MediaQuery.of(context).size.width * 0.07,
          child: Text(
            order.customerPhone,
            softWrap: false,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13),
          ),
        )),
        DataCell(SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                order.customerAddress,
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
          width: MediaQuery.of(context).size.width * 0.06,
          child: Center(
            child: Text(
              order.cartOrders.length.toString(),
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
              order.amount.toStringAsFixed(1),
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
          ),
        )),
        DataCell(SizedBox(
          width: MediaQuery.of(context).size.width * 0.07,
          child: Center(
            child: Text(
              DateFormat('dd-MM-yyyy').format(order.createdAt),
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
          ),
        )),
        DataCell(SizedBox(
          width: MediaQuery.of(context).size.width * 0.07,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                order.cartOrders[0].status ? "Delivered" : "In Progress",
                style: TextStyle(
                    backgroundColor: order.cartOrders[0].status
                        ? const Color.fromRGBO(184, 255, 186, 1)
                        : const Color.fromARGB(255, 255, 250, 207),
                    color: order.cartOrders[0].status
                        ? const Color.fromARGB(255, 36, 97, 38)
                        : const Color.fromARGB(255, 202, 185, 33),
                    fontWeight: FontWeight.bold,
                    fontSize: 13),
              ),
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
                showOrderUpdateDialog(context, order);
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
                              await ordersController.deleteOrder(order.orderId);
                              Get.snackbar("Deleted", "Order has been removed",
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
  int get rowCount => orders.length;
  @override
  int get selectedRowCount => 0;
}
