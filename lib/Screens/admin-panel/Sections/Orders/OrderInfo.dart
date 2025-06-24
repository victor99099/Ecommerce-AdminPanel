import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../models/order-model.dart';

void showOrderInfoDialog(BuildContext context, MainOrderModel order) async {
  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            child: SizedBox(
              width: Get.width * 0.55,
              height: Get.height,
              child: Stack(
                children: [
                  AlertDialog(
                    scrollable: true,
                    // backgroundColor: const Color(0xFFf0f1f1),
                    content: DefaultTabController(
                      length: 3,
                      child: SizedBox(
                        width: Get.width * 0.5,
                        height: Get.height * 0.95,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Material(
                              color: Colors.transparent,
                              elevation: 0,
                              borderRadius: BorderRadius.circular(10),
                              child: TabBar(
                                indicatorColor: Colors.blue,
                                labelStyle: const TextStyle(
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w500),
                                padding: EdgeInsets.zero,
                                labelPadding: const EdgeInsets.all(5),
                                indicatorPadding: const EdgeInsets.all(0),
                                dividerHeight: 1,
                                dividerColor: Colors.grey.withOpacity(0.8),
                                tabs: const [
                                  Padding(
                                      padding:
                                          EdgeInsets.only(left: 40, right: 40),
                                      child: Tab(text: 'Order Details')),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 40, right: 40),
                                    child: Tab(text: 'Customer Details'),
                                  ),
                                  Padding(
                                      padding:
                                          EdgeInsets.only(left: 40, right: 40),
                                      child: Tab(text: 'Product Details')),
                                ],
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.blue.withOpacity(0.1),
                                ),
                                labelColor: Colors.black,
                                unselectedLabelColor:
                                    Colors.black.withOpacity(0.5),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.82,
                              child: TabBarView(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(height: Get.height * 0.05),
                                      InfoLine(
                                          title: "Order Id",
                                          body: order.orderId,
                                          isMultiline: false),
                                      SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InfoColumn(
                                            title: "Status",
                                            body: order.cartOrders[0].status
                                                ? "Delivered"
                                                : "In Progress",
                                          ),
                                          InfoColumn(
                                            title: "Updated At",
                                            body: DateFormat("dd-MMM-yyyy")
                                                .format((order.cartOrders[0]
                                                        .updatedAt is Timestamp)
                                                    ? (order.cartOrders[0]
                                                                .updatedAt
                                                            as Timestamp)
                                                        .toDate()
                                                    : order.cartOrders[0]
                                                        .updatedAt),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InfoColumn(
                                            title: "Placed On",
                                            body: DateFormat("dd-MMM-yyyy")
                                                .format((order.createdAt
                                                        is Timestamp)
                                                    ? (order.createdAt
                                                            as Timestamp)
                                                        .toDate()
                                                    : order.createdAt),
                                          ),
                                          InfoColumn(
                                            title: "Deliivery Time",
                                            body: order
                                                .cartOrders[0].deliveryTime,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InfoColumn(
                                            title: "Sub Total",
                                            body:
                                                order.amount.toStringAsFixed(2),
                                          ),
                                          InfoColumn(
                                            title: "Payment Method",
                                            body: order.payOption,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(height: Get.height * 0.05),
                                      InfoLine(
                                          title: "Customer Id",
                                          body: order.uId,
                                          isMultiline: false),
                                      SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InfoColumn(
                                            title: "Customer Name",
                                            body: order.customerName,
                                          ),
                                          InfoColumn(
                                            title: "Phone no",
                                            body: order.customerPhone,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      InfoLine(
                                          title: "Street",
                                          isMultiline: false,
                                          body: order.customerStreet),
                                      SizedBox(height: 15),
                                      InfoLine(
                                        title: "Address",
                                        body: order.customerAddress,
                                        isMultiline: true,
                                      ),
                                      SizedBox(height: 8),
                                      InfoLine(
                                        title: "Note To Rider",
                                        body: order.noteToRider,
                                        isMultiline: false,
                                      ),
                                    ],
                                  ),
                                  ListView.builder(
                                      itemCount: order.cartOrders.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        final product = order.cartOrders[index];
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(height: Get.height * 0.05),
                                            Text(
                                              "Product # ${index + 1}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: Get.height * 0.01),
                                            InfoLine(
                                                title: "Product Name",
                                                body: product.productName,
                                                isMultiline: false),
                                            SizedBox(height: 15),
                                            InfoLine(
                                                title: "Description",
                                                body:
                                                    product.productDescription,
                                                isMultiline: true),
                                            SizedBox(height: 15),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InfoColumn(
                                                    title: "Category",
                                                    body: product.categoryName),
                                                InfoColumn(
                                                    title: "Brand",
                                                    body: product.brandName)
                                              ],
                                            ),
                                            SizedBox(height: 15),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InfoColumn(
                                                    title: "Original Price",
                                                    body: product.fullPrice),
                                                InfoColumn(
                                                    title: "Sale Price",
                                                    body: product.isSale
                                                        ? product.salePrice
                                                        : "-"),
                                              ],
                                            ),
                                            SizedBox(height: 15),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InfoColumn(
                                                    title: "Quantity",
                                                    body: product
                                                        .productQuantity
                                                        .toString()),
                                                InfoColumn(
                                                    title: "Color",
                                                    body: product.productColor)
                                              ],
                                            )
                                          ],
                                        );
                                      })
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
          );
        },
      );
    },
  );
}

class InfoLine extends StatelessWidget {
  final String title;
  final String body;
  final bool isMultiline;

  const InfoLine(
      {super.key,
      required this.title,
      required this.body,
      required this.isMultiline});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          // padding: const EdgeInsets.all(8.0),
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
          maxLines: isMultiline ? 3 : 1,
          enabled: false,
          decoration: InputDecoration(
            hintText: body,
            hintMaxLines: isMultiline ? 3 : 1,
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
              borderSide:
                  BorderSide(color: Colors.grey.withOpacity(0.5), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.grey.withOpacity(0.5), width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

class InfoColumn extends StatelessWidget {
  final String title;
  final String body;
  const InfoColumn({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.22,
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
