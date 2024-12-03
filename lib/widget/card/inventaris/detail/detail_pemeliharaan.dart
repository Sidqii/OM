import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:pusdatin_end/widget/component/comp_kembali.dart';
import 'package:pusdatin_end/models/dataset/dataset_pegawai.dart';
import 'package:pusdatin_end/models/dataset/dataset_databarang.dart';
import 'package:pusdatin_end/models/dataset/dataset_pemeliharaan.dart';

class detailPemeliharaan extends StatelessWidget {
  final DatasetPemeliharaan pelihara;
  final DatasetDatabarang item;
  final DatasetPegawai pegawai;
  
  detailPemeliharaan({required this.item, required this.pegawai, required this.pelihara});

  String formatDate(String date) {
    try {
      DateTime parseDate = DateTime.parse(date);
      return DateFormat('yyyy - MM - dd').format(parseDate);
    } catch (e) {
      return date;
    }
  }

  Widget _buildSingleField(String label, String value, bool isDropdown) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        // const SizedBox(height: 5),
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
                  // contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  border: UnderlineInputBorder(),
                ),
              )
            : TextFormField(
                initialValue: value,
                readOnly: true,
                decoration: InputDecoration(
                  // contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  border: UnderlineInputBorder(),
                ),
              ),
      ],
    );
  }

  Widget _buildBoxField(String label, String value, bool isDropdown) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 5),
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
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              )
            : TextFormField(
                initialValue: value,
                readOnly: true,
                textAlign: TextAlign.start,
                maxLines: label.contains('Ket.')
                    ? null
                    : 1, // null = otomatis sesuai teks
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10),
                  border: const UnderlineInputBorder(), // Garis bawah saja
                ),
              ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CompKembali(
        title: 'Inventaris',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header dan Logo
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Detail',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    Text(
                      'Pemeliharaan',
                      style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 1,
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Gambar Barang dengan Placeholder
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                item.foto,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  }
                },
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.broken_image,
                    size: 150,
                    color: Colors.red,
                  );
                },
              ),
            ),
            const SizedBox(height: 35),
            _buildSingleField('Penanggung Jawab', pegawai.nama, false),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: _buildSingleField('Status Barang', pelihara.status, false),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildSingleField('Tanggal Pemeliharaan', formatDate('${pelihara.tanggal_pemeliharaan}'), false),
                ),
              ],
            ),
            const SizedBox(height: 35),
            _buildSingleField('Jenis Barang', item.merk, false),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: _buildSingleField(
                      'Jumlah', '${pelihara.jumlah}', false),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildSingleField(
                    'Kondisi', pelihara.kondisi, false),
                ),
              ],
            ),
            const SizedBox(height: 35),
            _buildBoxField('Ket. Kerusakan Barang:', pelihara.keterangan, false),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
