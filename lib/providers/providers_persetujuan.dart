import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pusdatin_end/models/dataset/dataset_peminjamanDetail.dart';
import 'package:pusdatin_end/services/services_peminjaman.dart';

class ProviderPersetujuan extends ChangeNotifier {
  final ServicesPeminjaman _servicesPeminjaman = ServicesPeminjaman();

  List<DatasetPeminjamandetail>? _detail;
  List<DatasetPeminjamandetail>? _filterDetail;
  bool _isLoading = false;
  String? _errorMessage;

  List<DatasetPeminjamandetail>? get detail => _filterDetail ?? _detail;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchPeminjamanDetail() async {
    if (_detail != null) return;

    _isLoading = true;
    _errorMessage = null;

    try {
      var pinjam = await _servicesPeminjaman.fetchPeminjamanDetail();
      // print('Data diterima: $pinjam');

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
      if (_detail != null || _errorMessage != null) {
        notifyListeners();
      }
    }
  }

  void filterByStatus(String status) {
    if (_detail != null) {
      _filterDetail = _detail!
          .where((item) => item.status.toLowerCase() == status.toLowerCase())
          .toList();
    } else {
      _filterDetail = [];
    }
    notifyListeners();
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
            detail.status.toLowerCase().contains(query.toLowerCase()) ||
            detail.instansi.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  // Menambahkan metode untuk menyetujui peminjaman
  void approvePeminjaman(List<DatasetPeminjamandetail> data) {
    for (var item in data) {
      item.status = 'Disetujui'; // Mengubah status menjadi "Disetujui"
    }
    notifyListeners(); // Memberi tahu bahwa data telah berubah, UI perlu diperbarui
  }

  // Menambahkan metode untuk menolak peminjaman
  void rejectPeminjaman(List<DatasetPeminjamandetail> data) {
    for (var item in data) {
      item.status = 'Ditolak'; // Mengubah status menjadi "Ditolak"
    }
    notifyListeners(); // Memberi tahu bahwa data telah berubah, UI perlu diperbarui
  }
}
