import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pusdatin_end/models/dataset/dataset_pegawai.dart';

class ServicesPegawai {
  Future<List<DatasetPegawai>>fetchPegawai() async{
    final response =await http.get(
      Uri.parse('http://localhost:8000/api/pegawai'),
      // Uri.parse('http://10.0.2.2:8000/api/pegawai') // Mobile Device
    );

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      // print('Data berhasil diterima: $jsonData');

      if (jsonData is List) {
        return DatasetPegawai.fromJsonList(jsonData);
      } else if (jsonData is Map && jsonData.containsKey('pegawai')) {
        return DatasetPegawai.fromJsonList(jsonData['pegawai']);
      } else {
        throw Exception('Data tidak sesuai format');
      }
    } else {
      throw Exception('Gagal memuat data');
    }
  }
}