import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pusdatin_end/models/dataset/dataset_peminjamanDetail.dart';
import 'package:pusdatin_end/models/mock/models_pengguna.dart';
import 'package:pusdatin_end/providers/providers_persetujuan.dart';
import 'package:pusdatin_end/widget/component/page/comp_kembali.dart';

class ApprovePage extends StatelessWidget {
  final pengguna user;
  final String status;

  ApprovePage({required this.status, required this.user});

  String formatDate(String date) {
    try {
      DateTime parseDate = DateTime.parse(date);
      return DateFormat('yyyy - MM - dd').format(parseDate);
    } catch (e) {
      return date;
    }
  }

  String namaInventaris(List<Inventaris> inventaris) {
    return inventaris.map((e) => e.namaInventaris).join(', ');
  }

  String kondisiInventaris(List<Inventaris> inventaris) {
    return inventaris.map((e) => e.kondisi).join(', ');
  }

  Widget _buildSingleField(String label, String value, bool isDropdown) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        isDropdown
            ? DropdownButtonFormField<String>(
                value: value,
                items: [value].map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (newValue) {},
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                ),
              )
            : TextFormField(
                initialValue: value,
                readOnly: true,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                ),
              ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderPersetujuan>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CompKembali(
        title: 'Persetujuan',
      ),
      body: FutureBuilder(
        future: provider.fetchPeminjamanDetail(),
        builder: (context, snapshot) {
          if (provider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null) {
            return Center(child: Text(provider.errorMessage!));
          }

          provider.filterByStatus(status);
          final filteredData = provider.detail;

          if (filteredData == null || filteredData.isEmpty) {
            return Center(child: Text('Tidak ada pengajuan barang.'));
          }

          return PageView.builder(
            itemCount: filteredData.length,
            itemBuilder: (context, index) {
              final item = filteredData[index];
              return Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/logo/pusdatin.png',
                              width: 50,
                              height: 50,
                            ),
                            const SizedBox(width: 10),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'INVENTARIS BARANG',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'PUSDATIN KEMHAN',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Gambar Inventaris
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: item.inventaris.isNotEmpty
                              ? Image.network(
                                  item.inventaris.first.foto,
                                  width: double.infinity,
                                  height: 180,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.broken_image,
                                      size: 80,
                                      color: Colors.red,
                                    );
                                  },
                                )
                              : Container(
                                  width: double.infinity,
                                  height: 180,
                                  color: Colors.grey[300],
                                  child: Center(
                                    child: Text('Tidak ada gambar'),
                                  ),
                                ),
                        ),
                        const SizedBox(height: 20),
                        _buildSingleField(
                            'Nama Penanggung Jawab', item.namaPegawai, false),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                              child: _buildSingleField('Inventaris',
                                  namaInventaris(item.inventaris), false),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: _buildSingleField('Kondisi',
                                  kondisiInventaris(item.inventaris), false),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        _buildSingleField(
                            'Nama Peminjam', item.namaPeminjam, false),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                              child: _buildSingleField(
                                  'Instansi', item.instansi, false),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: _buildSingleField('Tanggal Peminjam', formatDate(item.tanggalPeminjaman), false),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        _buildSingleField('Hal', item.hal, false),
                        const SizedBox(height: 30),

                        // Tombol Aksi
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                provider.approvePeminjaman([item]);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Peminjaman disetujui')),
                                );
                              },
                              child: Text('Setujui',
                                  style: TextStyle(color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[800],
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            ElevatedButton(
                              onPressed: () {
                                provider.rejectPeminjaman([item]);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Peminjaman ditolak')),
                                );
                              },
                              child: Text('Tolak',
                                  style: TextStyle(color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red[800],
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
