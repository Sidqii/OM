import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:pusdatin_end/widget/component/comp_kembali.dart';
import 'package:pusdatin_end/models/dataset/dataset_peminjamanDetail.dart';

class detailPeminjaman extends StatelessWidget {
  final DatasetPeminjamandetail detail;

  detailPeminjaman({required this.detail});

  String formatDate(String date) {
    try {
      DateTime parseDate = DateTime.parse(date);
      return DateFormat('yyyy - MM - dd').format(parseDate);
    } catch (e) {
      return date;
    }
  }

  String formatInventaris(List<Inventaris> inventaris) {
    return inventaris.map((e) => e.namaInventaris).join(', ');
  }

  String formatInv(List<Inventaris> inventaris) {
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
                maxLines: label.contains('Ket.') ? null : 1,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  border: const UnderlineInputBorder(),
                ),
              ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    final invenImages = detail.inventaris.map((e) => e.foto).toList();

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

            // Slider untuk Gambar Barang
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: pageController,
                    itemCount: invenImages.length,
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          invenImages[index],
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.broken_image,
                              size: 150,
                              color: Colors.red,
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1)
                                    : null,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  // Tombol Navigasi Kiri
                  Positioned(
                    left: 10,
                    top: 75,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        int prevIndex = pageController.page!.toInt() - 1;
                        if (prevIndex < 0) {
                          prevIndex = 0;
                        }
                        pageController.jumpToPage(
                          prevIndex,
                        );
                      },
                    ),
                  ),
                  // Tombol Navigasi Kanan
                  Positioned(
                    right: 10,
                    top: 75,
                    child: IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        int nextIndex = pageController.page!.toInt() + 1;
                        if (nextIndex >= invenImages.length) {
                          nextIndex = 0;
                        }
                        pageController.jumpToPage(
                          nextIndex,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Informasi Detail
            _buildSingleField('Penanggung Jawab', detail.namaPegawai, false),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: _buildSingleField(
                      'Inventaris', formatInventaris(detail.inventaris), false),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildSingleField(
                      'Kondisi', formatInv(detail.inventaris), false),
                ),
              ],
            ),
            const SizedBox(height: 30),
            _buildSingleField('Nama Peminjam', detail.namaPeminjam, false),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: _buildSingleField('Instansi', detail.instansi, false),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildSingleField('Tanggal Pengembalian',
                      formatDate(detail.tanggalPengembalian), false),
                ),
              ],
            ),
            const SizedBox(height: 30),
            _buildBoxField('Hal', detail.hal, false),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
