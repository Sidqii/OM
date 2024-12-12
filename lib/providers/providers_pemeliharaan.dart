import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pusdatin_end/services/services_pegawai.dart';
import 'package:pusdatin_end/services/services_dataBarang.dart';
import 'package:pusdatin_end/services/services_pemeliharaan.dart';
import 'package:pusdatin_end/models/dataset/dataset_pegawai.dart';
import 'package:pusdatin_end/models/dataset/dataset_databarang.dart';
import 'package:pusdatin_end/models/dataset/dataset_pemeliharaan.dart';

class Pemeliharaan {
  final DatasetPemeliharaan pemeliharaan;
  final DatasetDatabarang barang;
  final DatasetPegawai pegawai;

  Pemeliharaan({
    required this.pemeliharaan,
    required this.pegawai,
    required this.barang,
  });
}

class ProviderPemeliharaan extends ChangeNotifier {
  final ServicesPemeliharaan _servicesPemeliharaan = ServicesPemeliharaan();
  final ServicesDatabarang _servicesDatabarang = ServicesDatabarang();
  final ServicesPegawai _servicesPegawai = ServicesPegawai();

  List<Pemeliharaan>? _pemeliharaan;
  List<Pemeliharaan>? _filterPemeliharaan;
  bool _isLoading = false;
  String? _errorMessage;

  List<Pemeliharaan>? get pemeliharaan => _filterPemeliharaan ?? _pemeliharaan;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  // Fungsi untuk mengambil dan menggabungkan data
  Future<void> fetchPemeliharaan() async {
    if (_pemeliharaan != null) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Mengambil data pemeliharaan, pegawai, dan barang
      var pelihara = await _servicesPemeliharaan.fetchPemeliharaan();
      var barangList = await _servicesDatabarang.fetchDataBarang();
      var pegawaiList = await _servicesPegawai.fetchPegawai();

      // Gabungkan data pemeliharaan dengan pegawai dan barang berdasarkan ID
      _pemeliharaan = pelihara.map((pemeliharaan) {
        final pegawai = pegawaiList.firstWhere(
          (p) => p.id == pemeliharaan.id_pegawai,
          orElse: () => DatasetPegawai(
            id: -1,
            nama: 'Unknown',
            email: '',
            telegram_id: '',
            pangkat: '',
            nrp: '',
            jabatan: '',
            foto: '',
          ),
        );

        final barang = barangList.firstWhere(
          (b) => b.id == pemeliharaan.id_inventaris,
          orElse: () => DatasetDatabarang(
            id: -1,
            nama: 'Unknown',
            kondisi: '',
            status: '',
            merk: '',
            no_seri: '',
            jumlah: 0,
            pengadaan: '',
            tanggal_masuk: DateTime(0000, 00, 00),
            lisensi: 0,
            lokasi: '',
            foto: '',
            keterangan: '',
          ),
        );

        // Mengembalikan objek Pemeliharaan yang sudah digabungkan dengan pegawai dan barang
        return Pemeliharaan(
          pemeliharaan: pemeliharaan,
          pegawai: pegawai,
          barang: barang,
        );
      }).toList();

      // Jika tidak ada data pemeliharaan
      if (_pemeliharaan!.isEmpty) {
        _errorMessage = 'Tidak ada data';
      }
    } catch (e) {
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

  void applyFilter(String query) {
    if (query.isEmpty) {
      _filterPemeliharaan = _pemeliharaan;
    } else {
      _filterPemeliharaan = _pemeliharaan!.where((pemeliharaan) {
        return pemeliharaan.pegawai.nama
                .toLowerCase()
                .contains(query.toLowerCase()) ||
               pemeliharaan.barang.nama
                .toLowerCase()
                .contains(query.toLowerCase()) ||
               pemeliharaan.pemeliharaan.kondisi
                .toLowerCase()
                .contains(query.toLowerCase()) ||
               pemeliharaan.pemeliharaan.status
                .toLowerCase()
                .contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }
}
