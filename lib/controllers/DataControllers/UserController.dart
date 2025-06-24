import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user-model.dart';

class UsersController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Observable list of users
  RxList<UserModel> usersList = <UserModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  // Fetch all users from Firestore
  Future<void> fetchUsers() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('users').get();

      usersList.value = querySnapshot.docs.map((doc) {
        return UserModel.fromMap(doc.data()
            as Map<dynamic, dynamic>); // Assign Firestore auto-generated ID
      }).toList();
    } catch (e) {
      print("Error fetching users: $e");
    }
  }

  // Update user details and refetch users
  Future<void> updateUser(
      String userId, Map<String, dynamic> updatedData) async {
    try {
      await _firestore.collection('users').doc(userId).update(updatedData);
      fetchUsers(); // Refetch users after update
    } catch (e) {
      print("Error updating user: $e");
    }
  }

  // Change user role (Admin <-> User) and refetch users
  Future<void> changeUserRole(String userId, bool isAdmin) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'isAdmin': isAdmin,
      });
      fetchUsers(); // Refetch users after role change
    } catch (e) {
      print("Error changing user role: $e");
    }
  }

  // Delete a user and refetch users
  Future<void> deleteUser(String userId) async {
    try {
      await _firestore.collection('users').doc(userId).delete();
      fetchUsers(); // Refetch after deleting
    } catch (e) {
      print("Error deleting user: $e");
    }
  }
}
