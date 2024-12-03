import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pusdatin_end/models/mock/models_pengguna.dart';
import 'package:pusdatin_end/providers/providers_dataBarang.dart';
import 'package:pusdatin_end/widget/card/inventaris/card/card_dataBarang.dart';
import 'package:pusdatin_end/widget/component/comp_cardLoad.dart';

class TabDatabarang extends StatefulWidget {
  final pengguna user;
  const TabDatabarang({Key? key, required this.user}) : super(key: key);

  @override
  _TabDatabarangState createState() => _TabDatabarangState();
}

class _TabDatabarangState extends State<TabDatabarang> {
  @override
  void initState() {
    super.initState();
    // Mendapatkan provider untuk data barang
    final dataProvider = Provider.of<ProviderDatabarang>(context, listen: false);

    // Memastikan data barang sudah tersedia
    if (dataProvider.dataBarang != null) {
      // Jika data sudah ada, langsung lakukan pemfilteran dengan filter kosong (untuk menampilkan semua data)
      dataProvider.applyFilter('');
    } else {
      // Jika data belum tersedia, ambil data dari API atau sumber lain
      dataProvider.fetchDataBarang().then((_) {
        if (dataProvider.dataBarang != null) {
          // Lakukan pemfilteran setelah data diambil
          dataProvider.applyFilter('');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3D0E22),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        padding: const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
        child: Consumer<ProviderDatabarang>(
          builder: (context, dataProvider, child) {
            // Menangani loading state
            if (dataProvider.isLoading) {
              return const Center(child: CardLoad());
            }

            // Menangani kasus jika dataBarang kosong atau null setelah filter
            if (dataProvider.dataBarang == null || dataProvider.dataBarang!.isEmpty) {
              return Center(
                child: Text(
                  dataProvider.errorMessage ?? 'Data tidak ditemukan',
                ),
              );
            }

            // Menampilkan data yang sudah difilter
            return ListView.builder(
              itemCount: dataProvider.dataBarang!.length,
              itemBuilder: (context, index) {
                final item = dataProvider.dataBarang![index];
                return DataBarangCard(item: item); // Ganti dengan card yang sesuai
              },
            );
          },
        ),
      ),
    );
  }
}
