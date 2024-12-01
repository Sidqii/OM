import 'package:flutter/foundation.dart';
import 'package:pusdatin_end/services/services_login.dart';
import 'package:pusdatin_end/models/mock/models_pengguna.dart';

class AuthService extends ChangeNotifier {
  pengguna? _currentUser;
  bool _isLoggedIn = false;
  String? _errorMessage;

  pengguna? get currentUser => _currentUser;
  bool get isLoggedIn => _isLoggedIn;
  String? get errorMessage => _errorMessage;

  Future<void> login(String email, String password) async {
    try {
      final user = await ServicesLogin.login(email, password);
      if (user != null) {
        _currentUser = user;
        _isLoggedIn = true;
        _errorMessage = null;
        notifyListeners();
      } else {
        _isLoggedIn = false;
        _errorMessage = 'Email atau password salah';
        notifyListeners();
      }
    } catch (e) {
      _isLoggedIn = false;
      _errorMessage = 'Terjadi kesalahan saat login: ${e.toString()}';
      notifyListeners();
    }
  }

  void logout() {
    _currentUser = null;
    _isLoggedIn = false;
    _errorMessage = null;
    ServicesLogin.logout();
    notifyListeners();
  }

  void updateUser(pengguna user) {
    _currentUser = user;
    notifyListeners();
  }
}
