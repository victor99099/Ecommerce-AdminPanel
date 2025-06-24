import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/product-model.dart';

class ProductsController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Observable list of products
  RxList<ProductModel> productsList = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  // Fetch all products from Firestore
  Future<void> fetchProducts() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('products').get();

      productsList.value = querySnapshot.docs.map((doc) {
        return ProductModel.fromMap(doc.data()
            as Map<String, dynamic>); // Assign Firestore auto-generated ID
      }).toList();
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  // Add a new product and refetch products
  Future<void> addProduct(ProductModel product) async {
    try {
      await _firestore
          .collection('products')
          .doc(product.productId)
          .set(product.toMap());
      fetchProducts(); // Refetch after adding
    } catch (e) {
      print("Error adding product: $e");
    }
  }

  // Update an existing product and refetch products
  Future<void> updateProduct(
      String productId, Map<String, dynamic> updatedData) async {
    try {
      await _firestore
          .collection('products')
          .doc(productId)
          .update(updatedData);
      fetchProducts(); // Refetch after updating
    } catch (e) {
      print("Error updating product: $e");
    }
  }

  // Delete a product and refetch products
  Future<void> deleteProduct(String productId) async {
    try {
      await _firestore.collection('products').doc(productId).delete();
      fetchProducts(); // Refetch after deleting
    } catch (e) {
      print("Error deleting product: $e");
    }
  }

  Future<void> toggleIsBest(String productId, bool newValue) async {
    try {
      await _firestore.collection('products').doc(productId).update({
        'isBest': newValue,
        'updatedAt': FieldValue.serverTimestamp(), // Update timestamp
      });
      fetchProducts(); // Refresh product list
    } catch (e) {
      print("Error updating isBest status: $e");
    }
  }
}
