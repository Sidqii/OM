import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pusdatin_end/models/dataset/dataset_pegawai.dart';
import 'package:pusdatin_end/services/services_pegawai.dart';

class ProviderPegawai extends ChangeNotifier {
  final ServicesPegawai _servicesPegawai = ServicesPegawai();
  List<DatasetPegawai>? _Pegawai;
  bool _isLoading = false;
  String? _errorMessage;

  List<DatasetPegawai>? get pegawai => _Pegawai;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void>fetchPegawai() async {
    if (_Pegawai != null) return;
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      var pegawai = await _servicesPegawai.fetchPegawai();
      print('Data diterima: $pegawai');

      if (pegawai.isEmpty) {
        _errorMessage = 'Tidak ada data';
        _Pegawai = null;
      } else {
        _Pegawai = pegawai;
      }
    } catch (e) {
      if (e is SocketException) {
        _errorMessage = 'Tidak ada internet';
      } else {
        _errorMessage = '${e.toString()}';
      }
      print('Error: $e');
    } finally {
      _isLoading = true;
      notifyListeners();
    }
  }
}