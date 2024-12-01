import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pusdatin_end/models/mock/models_pengguna.dart';
import 'package:pusdatin_end/providers/providers_dataBarang.dart';
import 'package:pusdatin_end/widget/component/comp_cardLoad.dart';
import 'package:pusdatin_end/widget/card/inventaris/card_dataBarang.dart';

class TabDatabarang extends StatelessWidget {
  final pengguna user;

  const TabDatabarang({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Memastikan data barang di-fetch setiap kali widget ini ditampilkan
    final provider = Provider.of<ProviderDatabarang>(context, listen: false);
    if (provider.dataBarang == null) {
      provider.fetchDataBarang();
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
        padding: const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
        child: Consumer<ProviderDatabarang>(
          builder: (context, provider, child) {
            // Menangani loading state
            if (provider.isLoading) {
              return const Center(child: CardLoad());
            }

            // Menangani kasus jika dataBarang kosong atau null
            if (provider.dataBarang == null || provider.dataBarang!.isEmpty) {
              return Center(child: Text(provider.errorMessage ?? 'Data tidak ditemukan'));
            }

            // Menampilkan data jika sudah tersedia
            return ListView.builder(
              itemCount: provider.dataBarang!.length,
              itemBuilder: (context, index) {
                return DataBarangCard(
                  item: provider.dataBarang![index],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
