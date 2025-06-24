import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/brand-model.dart';

class BrandsController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Observable list of brands
  RxList<BrandModel> brandsList = <BrandModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBrands();
    // print(brandsList.length);
  }

  // Fetch all brands from Firestore
  Future<void> fetchBrands() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('brand').get();

      brandsList.value = querySnapshot.docs.map((doc) {
        return BrandModel.fromMap(doc.data()
            as Map<String, dynamic>); // Assign Firestore auto-generated ID
      }).toList();
    } catch (e) {
      print("Error fetching brands: $e");
    }
  }

  // Add a new brand and refetch brands
  Future<void> addBrand(BrandModel brand) async {
    try {
      await _firestore
          .collection('brand')
          .doc(brand.brandId)
          .set(brand.toMap());
      fetchBrands(); // Refetch after adding
    } catch (e) {
      print("Error adding brand: $e");
    }
  }

  // Update an existing brand and refetch brands
  Future<void> updateBrand(
      String brandId, Map<String, dynamic> updatedData) async {
    try {
      await _firestore.collection('brand').doc(brandId).update(updatedData);
      fetchBrands(); // Refetch after updating
    } catch (e) {
      print("Error updating brand: $e");
    }
  }

  // Delete a brand and refetch brands
  Future<void> deleteBrand(String brandId) async {
    try {
      await _firestore.collection('brand').doc(brandId).delete();
      fetchBrands(); // Refetch after deleting
    } catch (e) {
      print("Error deleting brand: $e");
    }
  }
}
