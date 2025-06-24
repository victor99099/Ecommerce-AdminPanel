import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import 'package:velocity_x/velocity_x.dart';

import '../../../../controllers/DataControllers/ReviewController.dart';
import '../../../../models/product-model.dart';
import '../../../../models/product-review-model.dart';
import '../../../../utils/ProductColors.dart';

void showProductInfoDialog(BuildContext context, ProductModel product) async {
  final ReviewsController reviewsController = Get.put(ReviewsController());
  final InfoColorSelectionController infoColorSelectionController =
      Get.put(InfoColorSelectionController());
  infoColorSelectionController.selectedColors.value = product.productColors;
  RxBool isReview = false.obs;
  final reviews = await reviewsController
      .calculateAverageRatingAndReviewCount(product.productId);
  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            child: SizedBox(
              width: Get.width * 0.5,
              child: Obx(
                () => Stack(
                  children: [
                    AlertDialog(
                      scrollable: true,
                      // backgroundColor: const Color(0xFFf0f1f1),
                      title: Text(
                        isReview.value
                            ? "Reviews -  ${reviews['averageRating'].toStringAsFixed(1)}  (${reviews['reviewCount']})"
                            : "Product Info",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),

                      content: isReview.value
                          ? SizedBox(
                              width: Get.width * 0.45,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Divider(
                                    endIndent: 0,
                                    indent: 0,
                                    color: Colors.grey.withOpacity(0.8),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    height: Get.height * 0.5,
                                    child: FutureBuilder(
                                        future: reviewsController
                                            .fetchProductReviews(
                                                product.productId),
                                        builder:
                                            (BuildContext context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else if (snapshot.hasError) {
                                            return Center(
                                                child: Text(
                                                    "Error fetching reviews: ${snapshot.error}"));
                                          } else if (!snapshot.hasData ||
                                              snapshot.data!.isEmpty) {
                                            return const Center(
                                                child: Text(
                                                    "No reviews available."));
                                          } else {
                                            // Reviews are successfully fetched
                                            List<ProductReviewModel> reviews =
                                                snapshot.data!;

                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 8),
                                              child: ListView.builder(
                                                // physics:
                                                //     const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,

                                                itemCount: reviews.length,
                                                itemBuilder: (context, index) {
                                                  final review = reviews[index];
                                                  return SizedBox(
                                                    // width: Get.width * 0.9,
                                                    // height: Get.height / 4.5,
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                SizedBox(
                                                                  width: 40,
                                                                  height: 40,
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50),
                                                                    child:
                                                                        CachedNetworkImage(
                                                                      imageUrl:
                                                                          review
                                                                              .userImage, // The Google profile image URL
                                                                      placeholder:
                                                                          (context, url) =>
                                                                              CircularProgressIndicator(), // Show loading
                                                                      errorWidget: (context,
                                                                              url,
                                                                              error) =>
                                                                          Icon(Icons
                                                                              .person), // Fallback image
                                                                    ),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  review
                                                                      .userName,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ).pOnly(
                                                                    left: 15)
                                                              ],
                                                            ),
                                                            IconButton(
                                                                onPressed: () {
                                                                  reviewsController
                                                                      .deleteReview(
                                                                          product
                                                                              .productId,
                                                                          review
                                                                              .feedback);
                                                                },
                                                                icon: Icon(
                                                                  Iconsax.trash,
                                                                  color: Colors
                                                                      .red,
                                                                ))
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            RatingBar.builder(
                                                                itemSize: 20,
                                                                ignoreGestures:
                                                                    true,
                                                                glow: false,
                                                                itemPadding:
                                                                    const EdgeInsets.all(
                                                                        0),
                                                                // glowColor: Colors.transparent,
                                                                initialRating:
                                                                    review
                                                                        .rating,
                                                                minRating: 1,
                                                                direction: Axis
                                                                    .horizontal,
                                                                allowHalfRating:
                                                                    true,
                                                                itemBuilder:
                                                                    (context,
                                                                        _) {
                                                                  return Icon(
                                                                    Icons.star,
                                                                    color: Colors
                                                                        .blue,
                                                                  );
                                                                },
                                                                onRatingUpdate:
                                                                    (rating) {}),
                                                            Text(
                                                              DateFormat(
                                                                      'dd-MMM-yyyy')
                                                                  .format(review
                                                                      .updatedAt
                                                                      .toDate()),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                            ).pOnly(left: 10)
                                                          ],
                                                        ).pOnly(top: 10),
                                                        SizedBox(
                                                                width: Get
                                                                        .width *
                                                                    0.9,
                                                                height: Get
                                                                        .height /
                                                                    12,
                                                                child: Text(
                                                                  review
                                                                      .feedback,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .fade,
                                                                ))
                                                            .pOnly(
                                                                top: 12,
                                                                left: 3),
                                                        // Divider(endIndent: 20,indent: 20,color: currentTheme.colorScheme.onTertiary,)
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            );
                                          }
                                        }),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(
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
                                    "Product Name",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5),

                                  // Name TextField
                                  TextField(
                                    style: TextStyle(
                                        color: Colors.grey.withOpacity(0.8)),
                                    // controller: nameController,

                                    enabled: false,
                                    decoration: InputDecoration(
                                      hintText: product.productName,
                                      filled: true,
                                      // labelText: "Name",
                                      fillColor: Colors.white,
                                      labelStyle: TextStyle(fontSize: 20),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(36),
                                        borderSide: BorderSide(
                                            color: Colors.grey.withOpacity(0.5),
                                            width: 1),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.withOpacity(0.5),
                                            width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.withOpacity(0.5),
                                            width: 2),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    "Description",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5),

                                  // Name TextField
                                  TextField(
                                    style: TextStyle(
                                        color: Colors.grey.withOpacity(0.8)),
                                    // controller: nameController,

                                    enabled: false,
                                    decoration: InputDecoration(
                                      hintText: product.productDescription,
                                      hintMaxLines: 5,
                                      hintStyle: TextStyle(fontSize: 12),
                                      filled: true,
                                      // labelText: "Name",
                                      fillColor: Colors.white,
                                      labelStyle: TextStyle(fontSize: 20),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.withOpacity(0.5),
                                            width: 1),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.withOpacity(0.5),
                                            width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.withOpacity(0.5),
                                            width: 2),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InfoColumn(
                                        isSmall: false,
                                        title: "Category",
                                        body: product.categoryName,
                                      ),
                                      InfoColumn(
                                        isSmall: false,
                                        title: "Brand",
                                        body: product.brandName,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InfoColumn(
                                        isSmall: false,
                                        title: "Originale Price",
                                        body: product.fullPrice,
                                      ),
                                      InfoColumn(
                                        isSmall: false,
                                        title: "Sale Price",
                                        body: product.isSale
                                            ? product.salePrice
                                            : "-",
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InfoColumn(
                                        isSmall: false,
                                        title: "Created At",
                                        body: DateFormat('dd-MMM-yyyy')
                                            .format(product.createdAt.toDate()),
                                      ),
                                      InfoColumn(
                                        isSmall: false,
                                        title: "Updated At",
                                        body: DateFormat('dd-MMM-yyyy')
                                            .format(product.updatedAt.toDate()),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InfoColumn(
                                        isSmall: true,
                                        title: "Delivery Time",
                                        body: product.deliveryTime,
                                      ),
                                      InfoColumn(
                                        isSmall: true,
                                        title: "Best selling",
                                        body: product.isBest ? "True" : "False",
                                      ),
                                      InfoColumn(
                                        isSmall: true,
                                        title: "On Sale",
                                        body: product.isSale ? "True" : "False",
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  SizedBox(
                                      height: Get.height * 0.13,
                                      child: InfoColorSelectionWidget()),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                              side: BorderSide(
                                                  color: Colors.grey
                                                      .withOpacity(0.5))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Image.network(
                                              product.productImages[0],
                                              width: Get.width * 0.12,
                                              height: Get.height * 0.25,
                                            ),
                                          )),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            side: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.5))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.network(
                                            product.productImages[1],
                                            width: Get.width * 0.12,
                                            height: Get.height * 0.25,
                                          ),
                                        ),
                                      ),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            side: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.5))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.network(
                                            product.productImages[2],
                                            width: Get.width * 0.12,
                                            height: Get.height * 0.25,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 20),
                                ],
                              ),
                            ),
                      actionsPadding: EdgeInsets.only(top: 10),
                      actions: [
                        SizedBox(
                          width: Get.width * 0.45,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll(Colors.blue)),
                            onPressed: () async {
                              isReview.value = !isReview.value;
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                isReview.value ? "Back" : "See Reviews",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                        right: Get.width * 0.015,
                        top: Get.width * 0.015,
                        child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.close_rounded,
                              color: Colors.grey,
                            ))),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

class InfoColumn extends StatelessWidget {
  final String title;
  final String body;
  final bool isSmall;
  const InfoColumn(
      {super.key,
      required this.title,
      required this.body,
      required this.isSmall});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isSmall ? Get.width * 0.12 : Get.width * 0.18,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 5),

          // Name TextField
          TextField(
            style: TextStyle(color: Colors.grey.withOpacity(0.8)),
            // controller: nameController,

            enabled: false,
            decoration: InputDecoration(
              hintText: body,
              // hintMaxLines: 5,
              filled: true,
              // labelText: "Name",
              fillColor: Colors.white,
              labelStyle: TextStyle(fontSize: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
                borderSide:
                    BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
                borderSide:
                    BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
                borderSide:
                    BorderSide(color: Colors.grey.withOpacity(0.5), width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoColorSelectionController extends GetxController {
  RxList<dynamic> selectedColors = <dynamic>[].obs;
  RxString hoveredColor = ''.obs;

  void toggleColor(String colorName) {
    if (selectedColors.contains(colorName)) {
      selectedColors.remove(colorName);
    } else {
      selectedColors.add(colorName);
    }
  }
}

class InfoColorSelectionWidget extends StatelessWidget {
  final InfoColorSelectionController controller =
      Get.put(InfoColorSelectionController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Colors",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                Text(
                  controller.hoveredColor.value,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            )),
        Obx(() {
          if (controller.selectedColors.isEmpty) {
            return "No colors selected.".text.makeCentered();
          }
          return Wrap(
            runSpacing: 10,
            spacing: 10,
            children: controller.selectedColors.map((colorName) {
              final color = ColorUtils.getColorFromName(
                  colorName.toString().toUpperCase());
              return MouseRegion(
                onEnter: (_) => controller.hoveredColor.value = colorName,
                onExit: (_) => controller.hoveredColor.value = '',
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.5),
                      width: 1,
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () => controller.toggleColor(colorName),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        }),
      ],
    );
  }
}
