import 'package:flutter/material.dart';

import '../model/user_model.dart';
import '../service/api_service.dart';

enum UserState { loading, data, error }

class UserProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<User> _users = [];
  UserState _state = UserState.loading;
  String _errorMessage = '';

  List<User> get users => _users;
  UserState get state => _state;
  String get errorMessage => _errorMessage;

  Future<void> fetchUsers() async {
    _state = UserState.loading;
    notifyListeners();

    try {
      _users = await _apiService.fetchUsers();
      _state = UserState.data;
    } catch (e) {
      _state = UserState.error;
      _errorMessage = e.toString();
    }

    notifyListeners();
  }

  void searchUsers(String query) {
    if (query.isEmpty) {
      fetchUsers();
    } else {
      _users = _users
          .where((user) => user.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
      notifyListeners();
    }
  }
}
