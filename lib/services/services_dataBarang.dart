import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pusdatin_end/models/dataset/dataset_databarang.dart';

class ServicesDatabarang {
  Future<List<DatasetDatabarang>> fetchDataBarang() async {
    final response = await http.get(
      Uri.parse('http://localhost:8000/api/inven'),
      // Uri.parse('http://10.0.2.2:8000/api/inven'), //Mobile Device
    );

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      print('Data berhasil diterima: $jsonData');
      if (jsonData is List) {
        return DatasetDatabarang.fromJsonList(jsonData);
      } else if (jsonData is Map && jsonData.containsKey('data')) {
        return DatasetDatabarang.fromJsonList(jsonData['data']);
      } else {
        throw Exception('Data tidak sesuai format.');
      }
    } else {
      throw Exception('Gagal memuat data barang.');
    }
  }
}
