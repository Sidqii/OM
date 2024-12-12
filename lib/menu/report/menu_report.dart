import 'package:flutter/material.dart';
import 'package:pusdatin_end/models/mock/models_pengguna.dart';
import 'package:pusdatin_end/widget/component/page/comp_kembali.dart';

class reportPage extends StatelessWidget {
  final pengguna user;

  const reportPage ({Key?key, required this.user}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CompKembali(title: 'Laporan'),
      body: Center(child: Text('Laman dalam Pengembangan')),
    );
  }
}
