import 'package:flutter/material.dart';
import 'package:pusdatin_end/widget/component/page/comp_kembali.dart';

class PagePemulihan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CompKembali(title: 'Login'),
      body: Center(
        child: Text('Laman dalam pengembangan'),
      ),
    );
  }
}