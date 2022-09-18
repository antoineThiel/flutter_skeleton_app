import 'package:flutter/material.dart';

class AuthenticationState with ChangeNotifier {
  final _token = [];
  dynamic get authenticationToken => _token;

  void authenticate(String token) {
    _token.add(token);
    notifyListeners();
  }

  bool isAuthenticated() {
    return _token.isNotEmpty;
  }

  void logout() {
    _token.clear();
    notifyListeners();
  }
}