import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pusdatin_end/models/dataset/dataset_peminjamanDetail.dart';
import 'package:pusdatin_end/services/services_peminjaman.dart';

class ProvidersPeminjaman extends ChangeNotifier {
  final ServicesPeminjaman _servicesPeminjaman = ServicesPeminjaman();

  List<DatasetPeminjamandetail>? _detail;
  List<DatasetPeminjamandetail>? _filterDetail;
  bool _isLoading = false;
  String? _errorMessage;

  List<DatasetPeminjamandetail>? get detail => _filterDetail ?? _detail;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchPeminjamanDetail(int id) async {
    if (_detail != null) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      var pinjam = await _servicesPeminjaman.fetchPeminjamanDetail();
      print('Data diterima: $pinjam');

      if (pinjam.isEmpty) {
        _errorMessage = 'Tidak ada data tersedia';
        _detail = null;
      } else {
        _detail = pinjam;
      }
    } catch (e) {
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

  void applyFilter(String query) {
    if (query.isEmpty) {
      _filterDetail = _detail;
    } else {
      _filterDetail = _detail?.where((detail) {
        return detail.namaPegawai.toLowerCase().contains(query.toLowerCase()) ||
               detail.inventaris.any((inv) => inv.namaInventaris
                  .toLowerCase()
                  .contains(query.toLowerCase())) ||
               detail.namaPeminjam.toLowerCase().contains(query.toLowerCase()) ||
               detail.instansi.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }
}
