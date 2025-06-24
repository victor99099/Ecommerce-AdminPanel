import 'package:ecommerce_adminpanel/Screens/admin-panel/Sections/Products.dart/ProductInfo.dart';
import 'package:ecommerce_adminpanel/Screens/admin-panel/Sections/Products.dart/ProductUpdate.dart';
import 'package:ecommerce_adminpanel/controllers/DataControllers/BrandController.dart';
import 'package:ecommerce_adminpanel/controllers/DataControllers/ProductController.dart';

import 'package:ecommerce_adminpanel/models/product-model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../controllers/DataControllers/CategoryController.dart';

import '../../../../controllers/PageController.dart';
import '../../../../controllers/SearchController.dart';

class ProductSection extends StatefulWidget {
  const ProductSection({super.key});

  @override
  _ProductSectionState createState() => _ProductSectionState();
}

class _ProductSectionState extends State<ProductSection> {
  final CustomPageController customPageController =
      Get.find<CustomPageController>();
  final ProductsController productsController = Get.put(ProductsController());
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      spacing: 10,
                      children: [
                        Icon(
                          Iconsax.shopping_bag5,
                          size: 30,
                          color: Colors.blue,
                        ),
                        Text(
                          "Products",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.8),
                              fontSize: 30,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: Get.width * 0.035),
                      // padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: Get.width * 0.14,
                        child: ElevatedButton(
                            onPressed: () {
                              customPageController.SelectedPage.value = 5;
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
                            child: Row(
                              spacing: 5,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Stack(
                                  children: [
                                    Icon(
                                      Icons.add,
                                      weight: 2,
                                    ),
                                    Icon(
                                      Icons.add,
                                      weight: 2,
                                    ),
                                    Icon(
                                      Icons.add,
                                      weight: 2,
                                    ),
                                  ],
                                ),
                                Text(
                                  "Add Product",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            )),
                      ),
                    )
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
                        () => productsController.productsList.length == 0
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
                                              0.02,
                                          child: Icon(
                                            Iconsax.shopping_bag,
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
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                    child: Center(
                                      child: Text("Description",
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
                                              0.06,
                                          child: Center(
                                            child: Text("Brand",
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
                                      child: Text("Category",
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
                                      child: Text("Original Price",
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
                                      child: Text("Sale Price",
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
                                      child: Text("Best Selling",
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
  final ProductsController productsController = Get.put(ProductsController());
  late List<ProductModel> products;
  final SearcherController searchController = Get.find<SearcherController>();
  final BuildContext context;
  final RxMap<int, bool> isBestValues = <int, bool>{}.obs;
  ProductDataSource(this.context) {
    productsController.fetchProducts();
    products = searchController.isSearching.value
        ? searchController.filteredproductsList
        : productsController.productsList;
  }

  @override
  DataRow getRow(int index) {
    final product = products[index];
    isBestValues[index] ??= product.isBest;
    // String formattedDate =
    //     DateFormat('dd-MM HH:mm').format(product.brandIdcreatedAt.toDate());
    return DataRow(
      onSelectChanged: (value) {
        if (value!) {
          showProductInfoDialog(context, product);
        }
      },
      cells: [
        DataCell(SizedBox(
            width: Get.width * 0.02,
            // height: Get.height * 0.2,
            child:
                CircleAvatar(child: Image.network(product.productImages[0])))),
        DataCell(SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
          child: Text(
            product.productName,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        )),
        DataCell(SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.productDescription,
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
              product.brandName,
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
              product.categoryName,
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
              product.fullPrice,
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
              product.isSale ? product.salePrice : "-",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
          ),
        )),
        // DataCell(Text(category.)),
        // DataCell(SizedBox(
        //   width: Get.width * 0.07,
        //   child: Center(
        //     child: Text(
        //       DateFormat('dd-MM HH:mm').format(product.brandIdcreatedAt.toDate()),
        //       style:
        //           TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        //     ),
        //   ),
        // )),
        DataCell(SizedBox(
          width: Get.width * 0.06,
          child: Center(
              child: Obx(
            () => Switch(
                value: isBestValues[index]!,
                onChanged: (value) {
                  isBestValues[index] = value;
                  productsController.toggleIsBest(product.productId, value);
                }),
          )),
        )),
        DataCell(SizedBox(
            width: Get.width * 0.02,
            child: Center(
                child: IconButton(
              onPressed: () {
                showProductDialog(context, product);
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
                            "Are you sure you want to delete this category?"),
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
                              await productsController
                                  .deleteProduct(product.productId);
                              Get.snackbar(
                                  "Deleted", "Product has been removed",
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
  int get rowCount => products.length;
  @override
  int get selectedRowCount => 0;
}
