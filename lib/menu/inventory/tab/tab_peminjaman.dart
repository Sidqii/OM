import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pusdatin_end/models/mock/models_pengguna.dart';
import 'package:pusdatin_end/providers/providers_peminjaman.dart';
import 'package:pusdatin_end/widget/card/inventaris/card/card_peminjaman.dart';
import 'package:pusdatin_end/widget/component/page/comp_cardLoad.dart';

class TabPeminjaman extends StatelessWidget {
  final pengguna user;

  const TabPeminjaman({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Memastikan data detail peminjaman di-fetch setiap kali widget ini ditampilkan
    final provider = Provider.of<ProviderPeminjaman>(context, listen: false);
    if (provider.detail == null) {
      provider.fetchPeminjamanDetail();
    }

    return Scaffold(
      backgroundColor: const Color(0xFF3D0E22),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
        child: Consumer<ProviderPeminjaman>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(
                child: CardLoad(),
              );
            }
            if (provider.detail == null || provider.detail!.isEmpty) {
              return Center(
                child: Text(provider.errorMessage ?? 'Data tidak ditemukan'),
              );
            }
            return ListView.builder(
              itemCount: provider.detail!.length,
              itemBuilder: (context, index) {
                return CardPeminjaman(
                  pinjam: provider.detail![index],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
