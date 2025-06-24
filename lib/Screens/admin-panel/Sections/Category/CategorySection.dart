import 'package:ecommerce_adminpanel/Screens/admin-panel/Widgets/PicUpload.dart';

import 'package:ecommerce_adminpanel/controllers/DataControllers/CategoryController.dart';
import 'package:ecommerce_adminpanel/controllers/PageController.dart';
import 'package:ecommerce_adminpanel/models/categories-model.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import 'package:intl/intl.dart';

import '../../../../controllers/DashboardControllers/growthController.dart';
import '../../../../controllers/SearchController.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({super.key});

  @override
  _CategorySectionState createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  final CustomPageController customPageController =
      Get.find<CustomPageController>();
  final SearcherController searchController = Get.find<SearcherController>();
  final CategoriesController categoriesController =
      Get.put(CategoriesController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: 10,
                      children: [
                        Icon(
                          Iconsax.category_25,
                          size: 30,
                          color: Colors.blue,
                        ),
                        Text(
                          "Categories",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.8),
                              fontSize: 30,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Text(
                      "Organize your products by creating a category",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.6), fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.05,
            ),
            Padding(
              padding: EdgeInsets.only(right: Get.width * 0.035),
              // padding: const EdgeInsets.all(8.0),
              child: Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: Get.width * 0.14,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            padding: WidgetStatePropertyAll(EdgeInsets.all(15)),
                            backgroundColor:
                                WidgetStatePropertyAll(const Color(0xFFf0f1f1)),
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(color: Colors.blue)))),
                        child: Row(
                          spacing: 5,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Delete All",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 16),
                            ),
                          ],
                        )),
                  ),
                  SizedBox(
                    width: Get.width * 0.14,
                    child: ElevatedButton(
                        onPressed: () async {
                          customPageController.SelectedPage.value = 1;
                        },
                        style: ButtonStyle(
                            elevation: WidgetStatePropertyAll(10),
                            padding: WidgetStatePropertyAll(EdgeInsets.all(15)),
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.blue),
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
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
                              "Add Category",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ),
            Obx(
              () => SizedBox(
                width: customPageController.isCompact.value
                    ? customPageController.isMenuOpen.value
                        ? MediaQuery.of(context).size.width * 0.72
                        : MediaQuery.of(context).size.width * 0.92
                    : MediaQuery.of(context).size.width * 0.75,
                // height: MediaQuery.of(context).size.height * 0.61,
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
                      child: categoriesController.categoriesList.isEmpty
                          ? Center(
                              child: CircularProgressIndicator(
                              color: Colors.blue,
                            ))
                          : PaginatedDataTable(
                              // header: Text("Category List"),

                              headingRowColor: WidgetStatePropertyAll(
                                  Colors.blue.withOpacity(0.2)),
                              rowsPerPage: categoriesController
                                          .categoriesList.length >
                                      5
                                  ? 5
                                  : categoriesController.categoriesList
                                      .length, // Adjust the number of rows per page
                              columns: [
                                DataColumn(
                                    label: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.06,
                                        child: Text(
                                          "Id",
                                          style: TextStyle(
                                              color: const Color.fromARGB(
                                                  255, 13, 51, 82),
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ))),
                                DataColumn(
                                    label: Text("Name",
                                        style: TextStyle(
                                            color: const Color.fromARGB(
                                                255, 13, 51, 82),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold))),
                                DataColumn(
                                    label: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        child: Text("Image",
                                            style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 13, 51, 82),
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)))),
                                // DataColumn(label: Text("Description")),
                                DataColumn(
                                    label: SizedBox(
                                  width: Get.width * 0.07,
                                  child: Center(
                                    child: Text("Created On",
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
          ],
        ),
      ),
    );
  }
}

class ProductDataSource extends DataTableSource {
  final CategoriesController categoriesController =
      Get.put(CategoriesController());
  final SearcherController searchController = Get.find<SearcherController>();
  late List<CategoriesModel> categories;
  final BuildContext context;
  ProductDataSource(this.context) {
    categoriesController.fetchCategories();

    categories = searchController.isSearching.value
        ? searchController.filteredcategoriesList
        : categoriesController.categoriesList;
  }

  @override
  DataRow getRow(int index) {
    final category = categories[index];
    // String formattedDate =
    //     DateFormat('dd-MM HH:mm').format(category.createdAt.toDate());
    return DataRow(
      cells: [
        DataCell(SizedBox(
            width: Get.width * 0.06,
            // height: Get.height * 0.2,
            child: Text(
              category.categoryId.toString(),
              overflow: TextOverflow.ellipsis,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ))),
        DataCell(Text(
          category.categoryName,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        )),
        DataCell(Container(
          width: Get.width * 0.03,
          alignment: Alignment.center,
          child: Image.network(
            category.categoryImage,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) =>
                Icon(Icons.broken_image),
          ),
        )),
        // DataCell(Text(category.)),
        DataCell(SizedBox(
          width: Get.width * 0.07,
          child: Center(
            child: Text(
              DateFormat('dd-MM HH:mm').format(category.createdAt.toDate()),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        )),
        DataCell(SizedBox(
            width: Get.width * 0.05,
            child: Center(
                child: IconButton(
              onPressed: () {
                showCategoryDialog(context, category);
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
                              Navigator.pop(context); // Close the dialog
                              await categoriesController
                                  .deleteCategory(category.categoryId);
                              Get.snackbar(
                                  "Deleted", "Category has been removed",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.lightBlueAccent,
                                  colorText: Colors.white);
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
  int get rowCount => categories.length;
  @override
  int get selectedRowCount => 0;
}

void showCategoryDialog(BuildContext context, CategoriesModel category) {
  final CategoriesController categoriesController =
      Get.find<CategoriesController>();

  RxnString imgUrl = RxnString();

  TextEditingController nameController = TextEditingController();
  // File? selectedImage;

  nameController.text = category.categoryName;
  imgUrl.value = category.categoryImage;
  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            child: SizedBox(
              width: Get.width * 0.5,
              child: AlertDialog(
                scrollable: true,
                // backgroundColor: const Color(0xFFf0f1f1),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Update Category",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.close_rounded,
                        ))
                  ],
                ),
                content: SizedBox(
                  width: Get.width * 0.45,
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
                        "Name",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),

                      // Name TextField
                      TextField(
                        style: TextStyle(color: Colors.grey.withOpacity(0.8)),
                        controller: nameController,
                        decoration: InputDecoration(
                          filled: true,
                          // labelText: "Name",
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
                      SizedBox(height: 20),

                      // Pick Image Button
                      Align(
                          alignment: Alignment.center,
                          child: PicUpload(imgUrl: imgUrl)),
                      SizedBox(height: 25),
                      SizedBox(
                        width: Get.width * 0.45,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              elevation: WidgetStatePropertyAll(5),
                              padding: WidgetStatePropertyAll(
                                  EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 11)),
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.blue)),
                          onPressed: () async {
                            // Handle save logic
                            // String id = idController.text;
                            String name = nameController.text;
                            if (name.isNotEmpty && !(imgUrl.value == null)) {
                              await categoriesController
                                  .updateCategory(category.categoryId, {
                                "categoryName": name,
                                "categoryImage": imgUrl.value,
                                "createdAt": category.createdAt,
                                "updatedAt": DateTime.now()
                              });
                              Get.snackbar(
                                  "Update", "Category has been updated",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.lightBlueAccent,
                                  colorText: Colors.white);
                              Navigator.pop(context);
                            } else {
                              Get.snackbar("Error", "Please fill all details",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.lightBlueAccent,
                                  colorText: Colors.white);
                            }
                          },
                          child: Text(
                            "Update",
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                actions: [
                  // TextButton(
                  //   child: Text("Cancel",
                  //       style: TextStyle(color: Colors.blue, fontSize: 18)),
                  // ),
                  // TextButton(
                  //   onPressed: () async {
                  //     // Handle save logic
                  //     // String id = idController.text;
                  //     String name = nameController.text;
                  //     if (name.isNotEmpty && !(imgUrl.value == null)) {
                  //       await categoriesController
                  //           .updateCategory(category.categoryId, {
                  //         "categoryName": name,
                  //         "categoryImage": imgUrl.value,
                  //         "createdAt": category.createdAt,
                  //         "updatedAt": DateTime.now()
                  //       });
                  //       Get.snackbar("Update", "Category has been updated",
                  //           snackPosition: SnackPosition.BOTTOM,
                  //           backgroundColor: Colors.lightBlueAccent,
                  //           colorText: Colors.white);
                  //       Navigator.pop(context);
                  //     } else {
                  //       Get.snackbar("Error", "Please fill all details",
                  //           snackPosition: SnackPosition.BOTTOM,
                  //           backgroundColor: Colors.lightBlueAccent,
                  //           colorText: Colors.white);
                  //     }
                  //   },
                  //   child: Text(
                  //     "Update",
                  //     style: TextStyle(color: Colors.blue, fontSize: 18),
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
