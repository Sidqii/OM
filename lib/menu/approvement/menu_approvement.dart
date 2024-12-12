import 'package:flutter/material.dart';
import 'package:pusdatin_end/models/mock/models_pengguna.dart';
import 'package:pusdatin_end/widget/component/page/comp_kembali.dart';

class ApprovePage extends StatelessWidget {
  final pengguna user;
  final List<Map<String, dynamic>> dataBarang;

  const ApprovePage({super.key, required this.dataBarang, required this.user});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> barangRequest = 
        dataBarang.where((item) => item['status'] == 'Request').toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CompKembali(
        title: 'Persetujuan',
      ),
      body: barangRequest.isEmpty
          ? const Center(child: Text('Tidak ada barang dengan status request.'))
          : ListView.builder(
              itemCount: barangRequest.length,
              itemBuilder: (context, index) {
                final barang = barangRequest[index];
                return ListTile(
                  leading: const Icon(Icons.inventory),
                  title: Text(barang['nama']),
                  subtitle: Text('Jumlah: ${barang['jumlah']}'),
                );
              },
            ),
    );
  }
}
