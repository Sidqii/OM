import 'package:flutter/material.dart';
import 'package:pusdatin_end/models/mock/models_pengguna.dart';
import 'package:pusdatin_end/widget/component/page/comp_kembali.dart';

class ApprovePage extends StatelessWidget {
  final pengguna user;

  const ApprovePage ({Key?key ,required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CompKembali(title: 'Menu'),
      body: Center(child: Text('Welcome, ${user.name} - Level: ${user.level}')),
    );
  }
}
