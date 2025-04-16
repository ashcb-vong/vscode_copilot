import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Backend {
  static Future<String> _getDbFilePath() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      return '${directory.path}/user_db.json';
    } catch (e) {
      // Fallback to temporary directory if application documents directory is not accessible
      final tempDirectory = await getTemporaryDirectory();
      return '${tempDirectory.path}/user_db.json';
    }
  }

  // Load the database (JSON file)
  static Future<Map<String, dynamic>> _loadDatabase() async {
    final dbFilePath = await _getDbFilePath();
    final file = File(dbFilePath);
    try {
      if (!file.existsSync()) {
        file.writeAsStringSync(jsonEncode({"users": []})); // Initialize with empty users list
      }
      final content = await file.readAsString();
      return jsonDecode(content);
    } catch (e) {
      print('Error loading database: $e');
      return {"users": []}; // Return an empty database on error
    }
  }

  // Save the database (JSON file)
  static Future<void> _saveDatabase(Map<String, dynamic> db) async {
    final dbFilePath = await _getDbFilePath();
    final file = File(dbFilePath);
    await file.writeAsString(jsonEncode(db));
  }

  // Signup function
  static Future<String?> signup(String name, String email, String password) async {
    final db = await _loadDatabase();
    final users = db['users'] as List;

    // Check if email already exists
    if (users.any((user) => user['email'] == email)) {
      return 'Email already exists';
    }

    // Add new user
    users.add({
      'name': name,
      'email': email,
      'password': password,
    });
    await _saveDatabase(db);
    return null; // Success
  }

  // Login function
  static Future<String?> login(String email, String password) async {
    final db = await _loadDatabase();
    final users = db['users'] as List;

    // Verify email and password
    final user = users.firstWhere(
      (user) => user['email'] == email && user['password'] == password,
      orElse: () => null,
    );

    if (user == null) {
      return 'Invalid email or password';
    }

    return null; // Success
  }
}