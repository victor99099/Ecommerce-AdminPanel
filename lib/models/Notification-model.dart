import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  final String id;
  final String title;
  final String body;
  final DateTime timestamp;
  final Map<String, dynamic>? data;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.timestamp,
    this.data,
  });

  /// Convert Firestore DocumentSnapshot to NotificationModel
  factory NotificationModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return NotificationModel(
      id: doc.id,
      title: data['title'] ?? 'No Title',
      body: data['body'] ?? 'No Body',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      data: data['data'] ?? {},
    );
  }

  /// Convert NotificationModel to Map (for Firestore)
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'body': body,
      'timestamp': FieldValue.serverTimestamp(),
      'data': data ?? {},
    };
  }
}
