import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pusdatin_end/models/dataset/dataset_pemeliharaan.dart';

class ServicesPemeliharaan {
  Future<List<DatasetPemeliharaan>> fetchPemeliharaan() async {
    final response = await http.get(
      Uri.parse('http://localhost:8000/api/lapor'),
    );

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      print('Data berhasil diterima: $jsonData');
      if (jsonData is List) {
        return DatasetPemeliharaan.fromJsonList(jsonData);
      } else if (jsonData is Map && jsonData.containsKey('pelihara')) {
        return DatasetPemeliharaan.fromJsonList(jsonData['pelihara']);
      } else {
        throw Exception('Data tidak sesuai format');
      }
    } else {
      throw Exception('Gagal memuat data');
    }
  }
}
