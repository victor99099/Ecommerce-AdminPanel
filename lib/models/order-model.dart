// // ignore_for_file: file_names

// class OrderModel {
//   final String orderId;
//   final String brandId;
//   final String brandName;
//   final String categoryId;
//   final String categoryName;
//   final String payOption;
//   final dynamic createdAt;
//   final String customerAddress;
//   final String customerStreet;
//   final String noteToRider;
//   final String customerDeviceToken;
//   final String customerId;
//   final String customerName;
//   final String customerPhone;
//   final String deliveryTime;
//   final String fullPrice;
//   final bool isSale;
//   final String productDescription;
//   final String productId;
//   final List productImages;
//   final String productColor;
//   final String productName;
//   final int productQuantity;
//   final double productTotalPrice;
//   final String salePrice;
//   final bool status;
//   final dynamic updatedAt;

//   OrderModel({
//     required this.orderId,
//     required this.brandId,
//     required this.brandName,
//     required this.categoryId,
//     required this.categoryName,
//     required this.payOption,
//     required this.createdAt,
//     required this.customerAddress,
//     required this.customerStreet,
//     required this.noteToRider,
//     required this.customerDeviceToken,
//     required this.customerId,
//     required this.customerName,
//     required this.customerPhone,
//     required this.deliveryTime,
//     required this.fullPrice,
//     required this.isSale,
//     required this.productDescription,
//     required this.productId,
//     required this.productImages,
//     required this.productColor,
//     required this.productName,
//     required this.productQuantity,
//     required this.productTotalPrice,
//     required this.salePrice,
//     required this.status,
//     required this.updatedAt,
//   });

// // Convert the object to a map
//   Map<String, dynamic> toJson() {
//     return {
//       'orderId': orderId,
//       'brandId': brandId,
//       'brandName': brandName,
//       'categoryId': categoryId,
//       'categoryName': categoryName,
//       'payOption': payOption,
//       'createdAt': createdAt,
//       'customerAddress': customerAddress,
//       'customerStreet': customerStreet,
//       'noteToRider': noteToRider,
//       'customerDeviceToken': customerDeviceToken,
//       'customerId': customerId,
//       'customerName': customerName,
//       'customerPhone': customerPhone,
//       'deliveryTime': deliveryTime,
//       'fullPrice': fullPrice,
//       'isSale': isSale,
//       'productDescription': productDescription,
//       'productId': productId,
//       'productImages': productImages,
//       'productColor': productColor,
//       'productName': productName,
//       'productQuantity': productQuantity,
//       'productTotalPrice': productTotalPrice,
//       'salePrice': salePrice,
//       'status': status,
//       'updatedAt': updatedAt,
//     };
//   }

//   // Create an instance of the class from a map
//   factory OrderModel.fromJson(Map<String, dynamic> json) {
//     return OrderModel(
//       orderId: json['orderId'],
//       brandId: json['brandId'],
//       brandName: json['brandName'],
//       categoryId: json['categoryId'],
//       categoryName: json['categoryName'],
//       createdAt: json['createdAt'],
//       payOption: json['payOption'],
//       customerAddress: json['customerAddress'],
//       customerStreet: json['customerStreet'],
//       noteToRider: json['noteToRider'],
//       customerDeviceToken: json['customerDeviceToken'],
//       customerId: json['customerId'],
//       customerName: json['customerName'],
//       customerPhone: json['customerPhone'],
//       deliveryTime: json['deliveryTime'],
//       fullPrice: json['fullPrice'],
//       isSale: json['isSale'],
//       productDescription: json['productDescription'],
//       productId: json['productId'],
//       productImages: json['productImages'],
//       productColor: json['productColor'],
//       productName: json['productName'],
//       productQuantity: json['productQuantity'],
//       productTotalPrice: json['productTotalPrice'],
//       salePrice: json['salePrice'],
//       status: json['status'],
//       updatedAt: json['updatedAt'],
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String orderId;
  final String brandId;
  final String brandName;
  final String categoryId;
  final String categoryName;
  final String payOption;
  final dynamic createdAt;
  final String customerAddress;
  final String customerStreet;
  final String noteToRider;
  final String customerDeviceToken;
  final String customerId;
  final String customerName;
  final String customerPhone;
  final String deliveryTime;
  final String fullPrice;
  final bool isSale;
  final String productDescription;
  final String productId;
  final List productImages;
  final String productColor;
  final String productName;
  final int productQuantity;
  final double productTotalPrice;
  final String salePrice;
  final bool status;
  final dynamic updatedAt;

  OrderModel({
    required this.orderId,
    required this.brandId,
    required this.brandName,
    required this.categoryId,
    required this.categoryName,
    required this.payOption,
    required this.createdAt,
    required this.customerAddress,
    required this.customerStreet,
    required this.noteToRider,
    required this.customerDeviceToken,
    required this.customerId,
    required this.customerName,
    required this.customerPhone,
    required this.deliveryTime,
    required this.fullPrice,
    required this.isSale,
    required this.productDescription,
    required this.productId,
    required this.productImages,
    required this.productColor,
    required this.productName,
    required this.productQuantity,
    required this.productTotalPrice,
    required this.salePrice,
    required this.status,
    required this.updatedAt,
  });

// Convert the object to a map
  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'brandId': brandId,
      'brandName': brandName,
      'categoryId': categoryId,
      'categoryName': categoryName,
      'payOption': payOption,
      'createdAt': createdAt,
      'customerAddress': customerAddress,
      'customerStreet': customerStreet,
      'noteToRider': noteToRider,
      'customerDeviceToken': customerDeviceToken,
      'customerId': customerId,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'deliveryTime': deliveryTime,
      'fullPrice': fullPrice,
      'isSale': isSale,
      'productDescription': productDescription,
      'productId': productId,
      'productImages': productImages,
      'productColor': productColor,
      'productName': productName,
      'productQuantity': productQuantity,
      'productTotalPrice': productTotalPrice,
      'salePrice': salePrice,
      'status': status,
      'updatedAt': updatedAt,
    };
  }

  // Create an instance of the class from a map
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['orderId'],
      brandId: json['brandId'],
      brandName: json['brandName'],
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      createdAt: json['createdAt'],
      payOption: json['payOption'],
      customerAddress: json['customerAddress'],
      customerStreet: json['customerStreet'],
      noteToRider: json['noteToRider'],
      customerDeviceToken: json['customerDeviceToken'],
      customerId: json['customerId'],
      customerName: json['customerName'],
      customerPhone: json['customerPhone'],
      deliveryTime: json['deliveryTime'],
      fullPrice: json['fullPrice'],
      isSale: json['isSale'],
      productDescription: json['productDescription'],
      productId: json['productId'],
      productImages: json['productImages'],
      productColor: json['productColor'],
      productName: json['productName'],
      productQuantity: json['productQuantity'],
      productTotalPrice: json['productTotalPrice'],
      salePrice: json['salePrice'],
      status: json['status'],
      updatedAt: (json['updatedAt'] as Timestamp?)?.toDate() ?? 'N/A',
    );
  }
}

class MainOrderModel {
  final String orderId;
  final double amount;
  final DateTime createdAt;
  final String customerAddress;
  final String customerStreet;
  final String customerDeviceToken;
  final String customerName;
  final String customerPhone;
  final String noteToRider;
  final String payOption;
  final String uId;
  final String? transactionId;
  final List<OrderModel> cartOrders;

  MainOrderModel({
    required this.orderId,
    required this.amount,
    required this.createdAt,
    required this.customerAddress,
    required this.customerStreet,
    required this.customerDeviceToken,
    required this.customerName,
    required this.customerPhone,
    required this.noteToRider,
    required this.payOption,
    required this.uId,
    this.transactionId,
    required this.cartOrders,
  });

  factory MainOrderModel.fromJson(
      Map<String, dynamic> json, List<OrderModel> orders) {
    return MainOrderModel(
      orderId: json['orderId'],
      amount: (json['amount'] as num).toDouble(),
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      customerAddress: json['customerAddress'],
      customerStreet: json['customerStreet'],
      customerDeviceToken: json['customerDeviceToken'],
      customerName: json['customerName'],
      customerPhone: json['customerPhone'],
      noteToRider: json['noteToRider'],
      payOption: json['payOption'],
      uId: json['uId'],
      transactionId: json['transactionId'] as String? ,
      cartOrders: orders,
    );
  }
}
