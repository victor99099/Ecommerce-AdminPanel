// ignore_for_file: file_names

class CategoriesModel {
  final String categoryId;
  final String categoryImage;
  final String categoryName;
  final dynamic createdAt;
  final dynamic updatedAt;

  CategoriesModel({
    required this.categoryId,
    required this.categoryImage,
    required this.categoryName,
    required this.createdAt,
    required this.updatedAt,
  });

  // Serialize the UserModel instance to a JSON map
  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'categoryImage': categoryImage,
      'categoryName': categoryName,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Create a UserModel instance from a JSON map
  factory CategoriesModel.fromMap(Map<dynamic, dynamic> map) {
    return CategoriesModel(
      categoryId: map['categoryId'] ?? '', // Default empty string if null
      categoryName: map['categoryName'] ?? 'Unknown', // Fallback name
      categoryImage: map['categoryImage'] ??
          '', // Default image placeholder URL can be set here
      createdAt: map['createdAt'] ?? 'N/A', // Default date or handle formatting
      updatedAt: map['updatedAt'] ?? 'N/A', // Default date or handle formatting
    );
  }
}
