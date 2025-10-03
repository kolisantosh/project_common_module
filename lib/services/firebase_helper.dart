/*
import 'package:firebase_database/firebase_database.dart';

class FirebaseHelper {
  static final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  /// Add new user
  static Future<void> addUser(String name, int age) async {
    String key = _dbRef.child("users").push().key!;
    await _dbRef.child("users/$key").set({
      "id": key,
      "name": name,
      "age": age,
    });
  }

  /// Get all users (Stream for realtime updates)
  static Stream<DatabaseEvent> getUsers() {
    return _dbRef.child("users").onValue;
  }

  /// Update user
  static Future<void> updateUser(String id, String name, int age) async {
    await _dbRef.child("users/$id").update({
      "name": name,
      "age": age,
    });
  }

  /// Delete user
  static Future<void> deleteUser(String id) async {
    await _dbRef.child("users/$id").remove();
  }
}
*/
