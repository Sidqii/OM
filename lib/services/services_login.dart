import 'package:pusdatin_end/dummy/dummy_pengguna.dart';
import 'package:pusdatin_end/models/mock/models_pengguna.dart';

class ServicesLogin {
  static Future<pengguna?> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      print("Email dan pass tidak boleh kosong");
      return null;
    }

    try {
      await Future.delayed(Duration(seconds: 1));
      final user = dummyUsers.firstWhere(
        (user) => user.email == email && user.password == password,
        orElse: null,
      );
      return user;
    } catch (e) {
      print('Error during login: $e');
      return null;
    }
  }

  static void logout() {
    // Implementasikan logout sesuai kebutuhan
  }
}
