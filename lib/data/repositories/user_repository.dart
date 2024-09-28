

import '../datasources/local/local_storage.dart';
import '../models/user.dart';

class UserRepository {
  final LocalStorage localStorage;

  UserRepository({required this.localStorage});

  // Lưu thông tin người dùng vào local storage
  Future<void> saveUser(User user) async {
    try {
      await localStorage.saveUser(user.toJson());
    } catch (e) {
      throw Exception('Failed to save user: $e');
    }
  }

  // Lấy thông tin người dùng từ local storage
  Future<User?> getUser() async {
    try {
      final userJson = await localStorage.getUser();
      return userJson != null ? User.fromJson(userJson) : null;
    } catch (e) {
      throw Exception('Failed to load user: $e');
    }
  }

  // Xóa thông tin người dùng
  Future<void> deleteUser() async {
    try {
      await localStorage.deleteUser();
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }
}
