import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthService {
  static const String _userKey = 'current_user';
  static const String _usersKey = 'all_users';

  Future<UserModel?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString(_userKey);
    if (userData != null) {
      return UserModel.fromJson(jsonDecode(userData));
    }
    return null;
  }

  Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final usersData = prefs.getString(_usersKey);
    
    if (usersData != null) {
      final users = jsonDecode(usersData) as Map<String, dynamic>;
      if (users.containsKey(email) && users[email]['password'] == password) {
        await prefs.setString(_userKey, jsonEncode(users[email]['user']));
        return true;
      }
    }
    return false;
  }

  Future<bool> signup(String email, String password, String username) async {
    final prefs = await SharedPreferences.getInstance();
    final usersData = prefs.getString(_usersKey);
    final users = usersData != null ? jsonDecode(usersData) as Map<String, dynamic> : {};
    
    if (users.containsKey(email)) return false;
    
    final user = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      username: username,
    );
    
    users[email] = {'password': password, 'user': user.toJson()};
    await prefs.setString(_usersKey, jsonEncode(users));
    await prefs.setString(_userKey, jsonEncode(user.toJson()));
    return true;
  }

  Future<void> updateUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user.toJson()));
    
    final usersData = prefs.getString(_usersKey);
    if (usersData != null) {
      final users = jsonDecode(usersData) as Map<String, dynamic>;
      if (users.containsKey(user.email)) {
        users[user.email]['user'] = user.toJson();
        await prefs.setString(_usersKey, jsonEncode(users));
      }
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
}
