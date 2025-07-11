import 'package:ecommerce_adminpanel/Screens/admin-panel/Widgets/PicUpload.dart';
import 'package:ecommerce_adminpanel/controllers/DataControllers/BrandController.dart';
import 'package:ecommerce_adminpanel/models/brand-model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../../controllers/PageController.dart';
import '../../../../controllers/SearchController.dart';

class BrandSection extends StatefulWidget {
  const BrandSection({super.key});

  @override
  _BrandSectionState createState() => _BrandSectionState();
}

class _BrandSectionState extends State<BrandSection> {
  final CustomPageController customPageController =
      Get.find<CustomPageController>();
  final BrandsController brandsController = Get.put(BrandsController());
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
                          Iconsax.shop5,
                          size: 30,
                          color: Colors.blue,
                        ),
                        Text(
                          "Brands",
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.8),
                              fontSize: 30,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Text(
                      "Showcase brands for better trust",
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
                        onPressed: () {
                          customPageController.SelectedPage.value = 3;
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
                              "Add Brand",
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
                      child: Obx(
                        () => brandsController.brandsList.isEmpty
                            ? Center(
                                child: CircularProgressIndicator(
                                color: Colors.blue,
                              ))
                            : PaginatedDataTable(
                                // header: Text("Category List"),

                                headingRowColor: WidgetStatePropertyAll(
                                    Colors.blue.withOpacity(0.2)),
                                rowsPerPage: brandsController
                                            .brandsList.length >
                                        5
                                    ? 5
                                    : brandsController.brandsList
                                        .length, // Adjust the number of rows per page
                                columns: [
                                  DataColumn(
                                      label: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
                                          child: Text("Image",
                                              style: TextStyle(
                                                  color: const Color.fromARGB(
                                                      255, 13, 51, 82),
                                                  fontSize: 16,
                                                  fontWeight:
                                                      FontWeight.bold)))),
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
                                source: BrandDataSource(
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

class BrandDataSource extends DataTableSource {
  final BrandsController brandsController = Get.put(BrandsController());
  late List<BrandModel> brands;
  final SearcherController searchController = Get.find<SearcherController>();
  final BuildContext context;
  BrandDataSource(this.context) {
    brandsController.fetchBrands();
    brands = searchController.isSearching.value
        ? searchController.filteredbrandsList
        : brandsController.brandsList;
  }

  @override
  DataRow getRow(int index) {
    final brand = brands[index];
    // String formattedDate =
    //     DateFormat('dd-MM HH:mm').format(brand.createdAt.toDate());
    return DataRow(
      cells: [
        DataCell(SizedBox(
            width: Get.width * 0.06,
            // height: Get.height * 0.2,
            child: Text(
              brand.brandId.toString(),
              overflow: TextOverflow.ellipsis,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ))),
        DataCell(Text(
          brand.brandName,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        )),
        DataCell(Container(
          width: Get.width * 0.03,
          alignment: Alignment.center,
          child: Image.network(
            brand.brandImage,
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
              DateFormat('dd-MM HH:mm').format(brand.createdAt.toDate()),
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
                showBrandDialog(context, brand);
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
                              await brandsController.deleteBrand(brand.brandId);
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
  int get rowCount => brands.length;
  @override
  int get selectedRowCount => 0;
}

void showBrandDialog(BuildContext context, BrandModel brand) {
  final BrandsController brandsController = Get.find<BrandsController>();

  RxnString imgUrl = RxnString();

  TextEditingController nameController = TextEditingController();
  // File? selectedImage;

  nameController.text = brand.brandName;
  imgUrl.value = brand.brandImage;
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
                      "Update Brand",
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
                              await brandsController
                                  .updateBrand(brand.brandId, {
                                "brandName": name,
                                "brandImage": imgUrl.value,
                                "createdAt": brand.createdAt,
                                "updatedAt": DateTime.now()
                              });
                              Get.snackbar("Update", "Brand has been updated",
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
              ),
            ),
          );
        },
      );
    },
  );
}
