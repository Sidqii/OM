import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pusdatin_end/models/dataset/dataset_pegawai.dart';
import 'package:pusdatin_end/services/services_pegawai.dart';

class ProviderPegawai extends ChangeNotifier {
  final ServicesPegawai _servicesPegawai = ServicesPegawai();
  List<DatasetPegawai>? _pegawai;
  List<DatasetPegawai>? _filterPegawai;
  bool _isLoading = false;
  String? _errorMessage;

  List<DatasetPegawai>? get pegawai => _filterPegawai ?? _pegawai;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void>fetchPegawai() async {
    if (_pegawai != null) return;
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      var pegawai = await _servicesPegawai.fetchPegawai();
      // print('Data diterima: $pegawai');

      if (pegawai.isEmpty) {
        _errorMessage = 'Tidak ada data';
        _pegawai = null;
      } else {
        _pegawai = pegawai;
        _filterPegawai = pegawai;
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

  void applyFilter(String query){
    if (query.isEmpty) {
      _filterPegawai = _pegawai;
    } else {
      _filterPegawai = _pegawai!.where((pegawai){
        return pegawai.nama.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }
}