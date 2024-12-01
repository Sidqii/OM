import 'package:flutter/material.dart';
import 'package:pusdatin_end/models/mock/models_pengguna.dart';

class profilePage extends StatelessWidget {
  final pengguna user; // Menerima data pengguna

  const profilePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Profille Page')),
      body: Center(
        child: Text('Welcome, ${user.name} - Level: ${user.level}'),
      ),
    );
  }
}
