import 'package:flutter/material.dart';
import 'package:pusdatin_end/models/mock/models_pengguna.dart';

class LoanRequestPage extends StatelessWidget {
  final pengguna user;

  const LoanRequestPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Pengajuan Peminjaman"),
      ),
      body: Center(
        child: Text("Halaman Pengajuan Peminjaman untuk ${user.name}"),
      ),
    );
  }
}
