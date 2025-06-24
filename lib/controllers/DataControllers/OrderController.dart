import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/order-model.dart';

class OrdersController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Observable list of all orders
  RxList<MainOrderModel> ordersList = <MainOrderModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllOrders();
  }

  // Fetch all orders from all users
  Future<void> fetchAllOrders() async {
    try {
      
      QuerySnapshot mainOrdersSnapshot = await _firestore
          .collection('orders')
          .orderBy('createdAt', descending: false)
          .get();

      List<MainOrderModel> tempList = [];

      for (var doc in mainOrdersSnapshot.docs) {
        // Get cartOrders subcollection for each main order
        QuerySnapshot cartOrdersSnapshot =
            await doc.reference.collection('cartOrders').get();

        // Convert each cart order document to OrderModel
        List<OrderModel> cartOrders = cartOrdersSnapshot.docs
            .map((orderDoc) =>
                OrderModel.fromJson(orderDoc.data() as Map<String, dynamic>))
            .toList();

        // Convert the main order document into MainOrderModel
        MainOrderModel mainOrder = MainOrderModel.fromJson(
          doc.data() as Map<String, dynamic>,
          cartOrders,
        );

        tempList.add(mainOrder);
      }

      ordersList.value = tempList;
    } catch (e) {
      print('Error fetching orders: $e');
    }
  }
  // Get userId from orderId
  // Future<String?> _getUserIdFromOrder(String orderId) async {
  //   try {
  //     QuerySnapshot userOrdersSnapshot =
  //         await _firestore.collection('orders').get();

  //     for (var userDoc in userOrdersSnapshot.docs) {
  //       QuerySnapshot cartOrdersSnapshot = await userDoc.reference
  //           .collection('cartOrders')
  //           .where('orderId', isEqualTo: orderId)
  //           .get();

  //       if (cartOrdersSnapshot.docs.isNotEmpty) {
  //         print(userDoc.id);
  //         return userDoc.id;
  //       }
  //     }
  //   } catch (e) {
  //     print("Error finding userId for order: $e");
  //   }
  //   return null;
  // }

  // Update order details using only orderId
  Future<void> updateOrder(MainOrderModel mainOrder) async {
    // String? userId = await _getUserIdFromOrder(orderModel.orderId);
    // if (userId == null) return;
    try {
      // Update the main order document
      await _firestore.collection('orders').doc(mainOrder.orderId).update({
        'orderId': mainOrder.orderId,
        'amount': mainOrder.amount,
        'createdAt': Timestamp.fromDate(mainOrder.createdAt),
        'customerAddress': mainOrder.customerAddress,
        'customerStreet': mainOrder.customerStreet,
        'customerDeviceToken': mainOrder.customerDeviceToken,
        'customerName': mainOrder.customerName,
        'customerPhone': mainOrder.customerPhone,
        'noteToRider': mainOrder.noteToRider,
        'payOption': mainOrder.payOption,
        'uId': mainOrder.uId,
        'transactionId': mainOrder.transactionId,
      });

      // Update each cart order inside the subcollection
      for (var order in mainOrder.cartOrders) {
        await _firestore
            .collection('orders')
            .doc(mainOrder.orderId)
            .collection('cartOrders')
            .doc(order
                .orderId) // you can change this to productId or a unique ID
            .set(order.toJson());
      }

      Get.snackbar('Success', 'Order updated successfully');
    } catch (e) {
      print("Error updating order: $e");
      Get.snackbar('Error', 'Failed to update order');
    }
  }

  // Delete an order using only orderId
  Future<void> deleteOrder(String orderId) async {
    // String? userId = await _getUserIdFromOrder(orderId);
    // if (userId == null) return;

    try {
      await _firestore.collection('orders').doc(orderId).delete();
      fetchAllOrders();
    } catch (e) {
      print("Error deleting order: $e");
    }
  }

  // Mark order as delivered using only orderId
  Future<void> markAllCartOrdersAsDelivered(String orderId) async {
    // String? userId = await _getUserIdFromOrder(orderId);
    // if (userId == null) return;

    try {
      final cartOrdersRef =
          _firestore.collection('orders').doc(orderId).collection('cartOrders');

      final querySnapshot = await cartOrdersRef.get();

      for (var doc in querySnapshot.docs) {
        await cartOrdersRef.doc(doc.id).update({
          'status': true,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }

      fetchAllOrders();
    } catch (e) {
      print("❌ Error updating cart orders: $e");
    }
  }
}
