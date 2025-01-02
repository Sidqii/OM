import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pusdatin_end/models/dataset/dataset_databarang.dart';
import 'package:pusdatin_end/services/services_dataBarang.dart';

class ProviderDatabarang extends ChangeNotifier {
  final ServicesDatabarang _servicesDatabarang = ServicesDatabarang();
  List<DatasetDatabarang>? _databarang;
  List<DatasetDatabarang>? _filteredDatabarang;
  bool _isLoading = false;
  String? _errorMessage;

  List<DatasetDatabarang>? get dataBarang => _filteredDatabarang ?? _databarang;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchDataBarang() async {
    print('Mulai fetch data barang...');
    if (_databarang != null) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      var data = await _servicesDatabarang.fetchDataBarang();
      // print('Data diterima: $data');

      // Handle empty data case
      if (data.isEmpty) {
        _errorMessage = 'Tidak ada data yang tersedia';
        _databarang = null;
      } else {
        _databarang = data;
        _filteredDatabarang = data;
        // print('Data barang telah diambil');
      }
    } catch (e) {
      // Handle different error types
      if (e is SocketException) {
        _errorMessage = 'Tidak ada internet';
      } else {
        _errorMessage = '${e.toString()}';
      }
      
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fungsi untuk melakukan filter berdasarkan query pencarian
  void applyFilter(String query) {
    if (query.isEmpty) {
      // Jika query kosong, tampilkan semua data
      _filteredDatabarang = _databarang;
    } else {
      // Lakukan filter berdasarkan nama atau merk barang
      _filteredDatabarang = _databarang!.where((barang) {
        return barang.jumlah.toString().contains(query.toLowerCase()) ||
               barang.merk.toLowerCase().contains(query.toLowerCase()) ||
               barang.id.toString().contains(query.toLowerCase()) ||
               barang.kondisi.toLowerCase().contains(query.toLowerCase()) ||
               barang.status.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }
}
