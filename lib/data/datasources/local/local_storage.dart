import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class LocalStorage {
  static const String EVENTS_KEY = 'events';
  static const String USER_KEY = 'user';
  static const String THEME_KEY = 'theme';

  // Lưu sự kiện vào local storage
  Future<void> saveEvent(Map<String, dynamic> event) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> events = prefs.getStringList(EVENTS_KEY) ?? [];
    events.add(json.encode(event));
    await prefs.setStringList(EVENTS_KEY, events);
  }

  // Lấy danh sách sự kiện từ local storage
  Future<List<Map<String, dynamic>>> getEvents() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> events = prefs.getStringList(EVENTS_KEY) ?? [];
    return events.map((e) => json.decode(e) as Map<String, dynamic>).toList();
  }

  // Xóa sự kiện theo ID
  Future<void> deleteEvent(String eventId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> events = prefs.getStringList(EVENTS_KEY) ?? [];
    events.removeWhere((e) => json.decode(e)['id'] == eventId);
    await prefs.setStringList(EVENTS_KEY, events);
  }

  // Lưu thông tin người dùng vào local storage
  Future<void> saveUser(Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(USER_KEY, json.encode(user));
  }

  // Lấy thông tin người dùng từ local storage
  Future<Map<String, dynamic>?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? userStr = prefs.getString(USER_KEY);
    return userStr != null ? json.decode(userStr) as Map<String, dynamic> : null;
  }

  // Xóa thông tin người dùng từ local storage
  Future<void> deleteUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(USER_KEY);
  }

  // Lưu trạng thái chủ đề (theme) vào local storage
  Future<void> saveTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(THEME_KEY, isDark);
  }

  // Lấy trạng thái chủ đề từ local storage
  Future<bool> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(THEME_KEY) ?? false; // Mặc định là false nếu không có giá trị
  }
}
