import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/categories-model.dart';
// import '../models/categories_model.dart'; // Ensure correct path

class CategoriesController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Observable RxList of categories
  RxList<CategoriesModel> categoriesList = <CategoriesModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories(); // Fetch categories when the controller initializes
  }

  // Fetch all categories from Firestore
  Future<void> fetchCategories() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('categories').get();

      // Convert Firestore documents to CategoriesModel and update RxList
      categoriesList.value = querySnapshot.docs.map((doc) {
        return CategoriesModel.fromMap(doc.data() as Map<dynamic, dynamic>);
      }).toList();
    } catch (e) {
      print("Error fetching categories: $e");
    }
  }

  // // Real-time updates for categories
  // void listenToCategories() {
  //   _firestore.collection('categories').snapshots().listen((snapshot) {
  //     categoriesList.value = snapshot.docs.map((doc) {
  //       return CategoriesModel.fromMap(doc.data() as Map<String, dynamic>);
  //     }).toList();
  //   });
  // }

  // Add a new category and refetch categories
  Future<void> addCategory(CategoriesModel category) async {
    try {
      await _firestore.collection('categories').add(category.toMap());
      fetchCategories(); // Refetch after adding
    } catch (e) {
      print("Error adding category: $e");
    }
  }

  // Update an existing category and refetch categories
  Future<void> updateCategory(
      String categoryId, Map<String, dynamic> updatedData) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('categories')
          .where('categoryId', isEqualTo: categoryId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Get the document ID of the first matching document
        String docId = querySnapshot.docs.first.id;

        await _firestore
            .collection('categories')
            .doc(docId)
            .update(updatedData);
        await fetchCategories(); // Refetch after updating
      } else {
        print("No category found with categoryId: $categoryId");
      }
    } catch (e) {
      print("Error updating category: $e");
    }
  }

  // Delete a category and refetch categories
  Future<void> deleteCategory(String categoryId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('categories')
          .where('categoryId', isEqualTo: categoryId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Get the document ID of the first matching document
        String docId = querySnapshot.docs.first.id;

        await _firestore.collection('categories').doc(docId).delete();
        await fetchCategories(); // Refetch after updating
      } else {
        print("No category found with categoryId: $categoryId");
      }
    } catch (e) {
      print("Error deleting category: $e");
    }
  }
}
