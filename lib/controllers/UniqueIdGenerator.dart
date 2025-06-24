import 'package:uuid/uuid.dart';

class UUIDGenerator {
  static final Uuid _uuid = Uuid();

  // Generate a unique UUID
  static String generate() {
    return _uuid.v4(); // Generates a random UUID (version 4)
  }
}
