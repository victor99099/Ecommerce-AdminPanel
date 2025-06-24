import 'package:ecommerce_adminpanel/Screens/admin-panel/Widgets/DropDownButtons.dart';
import 'package:ecommerce_adminpanel/controllers/DataControllers/OrderController.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:intl/intl.dart';

import '../../../../models/order-model.dart';

void showOrderUpdateDialog(BuildContext context, MainOrderModel order) async {
  final TextEditingController customerNameContrller =
      TextEditingController(text: order.customerName);
  final TextEditingController customerPhoneContrller =
      TextEditingController(text: order.customerPhone);
  final TextEditingController customerStreetContrller =
      TextEditingController(text: order.customerStreet);
  final TextEditingController customerAddressContrller =
      TextEditingController(text: order.customerAddress);
  final TextEditingController noteToRiderController =
      TextEditingController(text: order.noteToRider);

  // final TextEditingController statusController = TextEditingController();
  final TextEditingController deliveryDaysController = TextEditingController(
      text: order.cartOrders[0].deliveryTime.split('days').first);

  RxBool status = order.cartOrders[0].status.obs;
  RxBool payOption = (order.payOption == "Cash" ? true : false).obs;

  RxDouble subtotal = (order.amount).obs;

  final OrdersController ordersController = Get.find<OrdersController>();

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            child: SizedBox(
              width: Get.width * 0.55,
              height: Get.height * 0.9,
              child: Stack(
                children: [
                  AlertDialog(
                    scrollable: true,
                    // backgroundColor: const Color(0xFFf0f1f1),
                    actionsPadding: EdgeInsets.only(top: 10),
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
                                      child: Tab(text: 'Update Order')),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 40, right: 40),
                                    child: Tab(text: 'Update Customer'),
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
                                          // InfoColumn(
                                          //   title: "Status",
                                          //   body: order.status
                                          //       ? "In Progress"
                                          //       : "Delivered",
                                          // ),
                                          OrderDropdownButton(
                                              label: "Status",
                                              selectedRole: status,
                                              options: [
                                                "Delivered",
                                                "In Progress"
                                              ]),
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
                                                .format(order.createdAt),
                                          ),
                                          ButtonsUpdateColumn(
                                              controller:
                                                  deliveryDaysController,
                                              title: "Delivery Time In Days",
                                              body: "")
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Obx(
                                            () => InfoColumn(
                                              title: "Sub Total",
                                              body: subtotal.value.toString(),
                                            ),
                                          ),
                                          OrderDropdownButton(
                                              label: "Payment Method",
                                              selectedRole: payOption,
                                              options: ["Cash", "Card"]),
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
                                          UpdateColumn(
                                            title: "Customer Name",
                                            controller: customerNameContrller,
                                            body: order.customerName,
                                          ),
                                          UpdateColumn(
                                            title: "Phone no",
                                            controller: customerPhoneContrller,
                                            body: order.customerPhone,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      UpdateLine(
                                          title: "Street",
                                          controller: customerStreetContrller,
                                          isMultiline: false,
                                          body: order.customerStreet),
                                      SizedBox(height: 15),
                                      UpdateLine(
                                        title: "Address",
                                        controller: customerAddressContrller,
                                        body: order.customerAddress,
                                        isMultiline: true,
                                      ),
                                      SizedBox(height: 8),
                                      UpdateLine(
                                        title: "Note To Rider",
                                        controller: noteToRiderController,
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
                    actionsAlignment: MainAxisAlignment.center,
                    actions: [
                      SizedBox(
                        width: Get.width * 0.5,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.blue)),
                          onPressed: () async {
                            if (customerNameContrller.text.isNotEmpty &&
                                customerPhoneContrller.text.isNotEmpty &&
                                customerStreetContrller.text.isNotEmpty &&
                                customerAddressContrller.text.isNotEmpty &&
                                ((int.tryParse(deliveryDaysController.text)) !=
                                    0)) {
                              MainOrderModel mainOrderModel = MainOrderModel(
                                  orderId: order.orderId,
                                  amount: order.amount,
                                  createdAt: order.createdAt,
                                  customerAddress:
                                      customerAddressContrller.text,
                                  customerStreet: customerStreetContrller.text,
                                  customerDeviceToken:
                                      order.customerDeviceToken,
                                  customerName: customerNameContrller.text,
                                  customerPhone: customerPhoneContrller.text,
                                  noteToRider: noteToRiderController.text,
                                  payOption: payOption.value ? "Cash" : "Card",
                                  uId: order.uId,
                                  cartOrders: order.cartOrders);
                              if (status.value) {
                                ordersController.markAllCartOrdersAsDelivered(
                                    order.orderId);
                              }
                              // OrderModel orderModel = OrderModel(
                              //     orderId: order.orderId,
                              //     brandId: order.brandId,
                              //     brandName: order.brandName,
                              //     categoryId: order.categoryId,
                              //     categoryName: order.categoryName,
                              //     payOption: payOption.value ? "Cash" : "Card",
                              //     createdAt: order.createdAt,
                              //     customerAddress:
                              //         customerAddressContrller.text,
                              //     customerStreet: customerStreetContrller.text,
                              // noteToRider: noteToRiderController.text,
                              //     customerDeviceToken:
                              //         order.customerDeviceToken,
                              //     customerId: order.customerId,
                              // customerName: customerNameContrller.text,
                              // customerPhone: customerPhoneContrller.text,
                              //     deliveryTime: deliveryDaysController.text,
                              //     fullPrice: order.fullPrice,
                              //     isSale: order.isSale,
                              //     productDescription: order.productDescription,
                              //     productId: order.productId,
                              //     productImages: order.productImages,
                              //     productColor: order.productColor,
                              //     productName: order.productName,
                              //     productQuantity:
                              //         int.tryParse(quantityController.text)!,
                              //     productTotalPrice: subtotal.value,
                              //     salePrice: order.salePrice,
                              //     status: status.value,
                              //     updatedAt: DateTime.now());
                              ordersController.updateOrder(mainOrderModel);
                              Get.snackbar("Updated", "Order has been updated",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.lightBlueAccent,
                                  colorText: Colors.white);
                              Navigator.pop(context);
                            } else {
                              Get.snackbar(
                                  "Error", "Please fill all necessary details",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.lightBlueAccent,
                                  colorText: Colors.white);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Update",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
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
              borderSide: BorderSide(
                  color:
                      const Color.fromARGB(255, 224, 224, 224).withOpacity(0.1),
                  width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color:
                      const Color.fromARGB(255, 224, 224, 224).withOpacity(0.1),
                  width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color:
                      const Color.fromARGB(255, 224, 224, 224).withOpacity(0.1),
                  width: 2),
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
                borderSide: BorderSide(
                    color: const Color.fromARGB(255, 224, 224, 224)
                        .withOpacity(0.1),
                    width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
                borderSide: BorderSide(
                    color: const Color.fromARGB(255, 224, 224, 224)
                        .withOpacity(0.1),
                    width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
                borderSide: BorderSide(
                    color: const Color.fromARGB(255, 224, 224, 224)
                        .withOpacity(0.1),
                    width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UpdateLine extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String body;
  final bool isMultiline;

  const UpdateLine(
      {super.key,
      required this.controller,
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
          style: TextStyle(color: Colors.black),
          controller: controller,
          maxLines: isMultiline ? 3 : 1,
          enabled: true,
          decoration: InputDecoration(
            hintText: body,
            hintMaxLines: isMultiline ? 3 : 1,
            filled: true,

            // labelText: "Name",
            fillColor: Colors.white,
            labelStyle: TextStyle(fontSize: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(36),
              borderSide: BorderSide(color: Colors.grey, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

class UpdateColumn extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String body;
  const UpdateColumn(
      {super.key,
      required this.controller,
      required this.title,
      required this.body});

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
            style: TextStyle(color: Colors.black),
            // controller: nameController,
            controller: controller,
            enabled: true,
            decoration: InputDecoration(
              hintText: body,
              // hintMaxLines: 5,
              filled: true,
              // labelText: "Name",
              fillColor: Colors.white,
              labelStyle: TextStyle(fontSize: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
                borderSide: BorderSide(color: Colors.grey, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonsUpdateColumn extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final String body;
  const ButtonsUpdateColumn(
      {super.key,
      required this.controller,
      required this.title,
      required this.body});

  @override
  State<ButtonsUpdateColumn> createState() => _ButtonsUpdateColumnState();
}

class _ButtonsUpdateColumnState extends State<ButtonsUpdateColumn> {
  void _increment() {
    int currentValue = int.tryParse(widget.controller.text) ?? 0;
    widget.controller.text = (currentValue + 1).toString();
  }

  void _decrement() {
    int currentValue = int.tryParse(widget.controller.text) ?? 0;
    widget.controller.text = (currentValue - 1).toString();
  }

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
              widget.title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 5),

          // Name TextField
          TextFormField(
            style: TextStyle(color: Colors.black),
            // controller: nameController,
            controller: widget.controller,
            enabled: true,
            decoration: InputDecoration(
              hintText: widget.body,
              // hintMaxLines: 5,
              suffixIcon: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () => _increment(),
                        child: Icon(
                          Icons.arrow_drop_up,
                          size: 20,
                        )),
                    GestureDetector(
                        onTap: () => _decrement(),
                        child: Icon(
                          Icons.arrow_drop_down,
                          size: 20,
                        ))
                  ],
                ),
              ),
              filled: true,
              // labelText: "Name",
              fillColor: Colors.white,
              labelStyle: TextStyle(fontSize: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
                borderSide: BorderSide(color: Colors.grey, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class QuantityButtonsUpdateColumn extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final String body;
  final RxDouble subtotal;
  final double? originalPrice;
  const QuantityButtonsUpdateColumn(
      {super.key,
      required this.originalPrice,
      required this.subtotal,
      required this.controller,
      required this.title,
      required this.body});

  @override
  State<QuantityButtonsUpdateColumn> createState() =>
      _QuantityButtonsUpdateColumnState();
}

class _QuantityButtonsUpdateColumnState
    extends State<QuantityButtonsUpdateColumn> {
  void _increment() {
    int currentValue = int.tryParse(widget.controller.text) ?? 0;
    widget.controller.text = (currentValue + 1).toString();
    final newValue = currentValue + 1;
    widget.subtotal.value = widget.originalPrice! * newValue;
  }

  void _decrement() {
    int currentValue = int.tryParse(widget.controller.text) ?? 0;
    widget.controller.text = (currentValue - 1).toString();
    final newValue = currentValue - 1;
    widget.subtotal.value = widget.originalPrice! * newValue;
  }

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
              widget.title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 5),

          // Name TextField
          TextFormField(
            style: TextStyle(color: Colors.black),
            // controller: nameController,
            controller: widget.controller,
            enabled: true,
            decoration: InputDecoration(
              hintText: widget.body,
              // hintMaxLines: 5,
              suffixIcon: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () => _increment(),
                        child: Icon(
                          Icons.arrow_drop_up,
                          size: 20,
                        )),
                    GestureDetector(
                        onTap: () => _decrement(),
                        child: Icon(
                          Icons.arrow_drop_down,
                          size: 20,
                        ))
                  ],
                ),
              ),
              filled: true,
              // labelText: "Name",
              fillColor: Colors.white,
              labelStyle: TextStyle(fontSize: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(36),
                borderSide: BorderSide(color: Colors.grey, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
