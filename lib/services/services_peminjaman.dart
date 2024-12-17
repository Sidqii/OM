import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pusdatin_end/models/dataset/dataset_peminjamanDetail.dart';

class ServicesPeminjaman {
  // final String baseUrl = 'http://10.0.2.2:8000/api/peminjaman/detail';
  final String baseUrl = 'http://localhost:8000/api/peminjaman/detail';

  // Fungsi untuk mengambil data peminjaman dari API
  Future<List<DatasetPeminjamandetail>> fetchPeminjamanDetail() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);

        if (jsonData != null && jsonData['data'] is List) {
          return (jsonData['data'] as List)
              .map((item) => DatasetPeminjamandetail.fromJson(item))
              .toList();
        } else {
          throw Exception('Data tidak sesuai format atau tidak ada data');
        }
      } else {
        throw Exception('Gagal memuat data: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Tidak ada internet');
    }
  }
}
