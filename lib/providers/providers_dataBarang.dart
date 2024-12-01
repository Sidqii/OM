import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pusdatin_end/services/services_dataBarang.dart';
import 'package:pusdatin_end/models/dataset/dataset_databarang.dart';

class ProviderDatabarang extends ChangeNotifier {
  final ServicesDatabarang _servicesDatabarang = ServicesDatabarang();
  List<DatasetDatabarang>? _databarang;
  bool _isLoading = false;
  String? _errorMessage;

  List<DatasetDatabarang>? get dataBarang => _databarang;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchDataBarang() async {
    if (_databarang != null) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      var data = await _servicesDatabarang.fetchDataBarang();
      print('Data diterima: $data');

      // Handle empty data case
      if (data.isEmpty) {
        _errorMessage = 'Tidak ada data yang tersedia';
        _databarang = null;
      } else {
        _databarang = data;
      }
    } catch (e) {
      // Handle different error types
      if (e is SocketException) {
        _errorMessage = 'Tidak ada internet';
      } else {
        _errorMessage = '${e.toString()}';
      }
      print('Error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
