import 'package:flutter/material.dart';
import 'package:pusdatin_end/dummy/dummy_dataBarag.dart';
import 'package:pusdatin_end/dummy/dummy_pemeliharaan.dart';
import 'package:pusdatin_end/models/mock/models_pemeliharaan.dart';

class InventoryStatusCard extends StatelessWidget {
  int countCondition(String condition) {
    return filterItemsByCondition(condition).length;
  }

  List<Pelihara> filterItemsByCondition(String condition) {
    return dummmyPelihara.where((pelihara) => pelihara.sttsPelihara == condition).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ketersediaan Barang',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
            ),
            const SizedBox(height: 25.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatusCard('Baik', Color(0xFFA3D9A5), Icons.check_circle,
                    countCondition('Baik')),
                _buildStatusCard('Perawatan', Color(0xFFFFD966),
                    Icons.warning_amber, countCondition('Pemeliharaan')),
                _buildStatusCard('Perbaikan', Color(0xFFE56B6F), Icons.error,
                    countCondition('Perbaikan')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(
      String condition, Color color, IconData icon, int count) {
    return Column(
      children: [
        Icon(icon, color: color, size: 35),
        const SizedBox(height: 8),
        Text(
          condition,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '$count',
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ],
    );
  }
}

class InventoryDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Detail Ketersediaan Barang"),
        backgroundColor: Colors.transparent,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: dummyItems.length,
        itemBuilder: (context, index) {
          final item = dummyItems[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blueGrey,
                child: Text(
                  item.nmBarang[0], // Menampilkan huruf awal nama barang
                  style: TextStyle(color: Colors.white),
                ),
              ),
              title: Text(
                item.nmBarang,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Kondisi: ${item.kondisi}"),
              trailing: Icon(
                Icons.circle,
                color: item.kondisi == 'Baik'
                    ? Color(0xFFA3D9A5)
                    : item.kondisi == 'Rusak Ringan'
                        ? Color(0xFFFFD966)
                        : Color(0xFFE56B6F),
              ),
            ),
          );
        },
      ),
    );
  }
}
