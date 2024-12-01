import 'package:flutter/material.dart';
import 'package:pusdatin_end/models/dataset/dataset_databarang.dart';
import 'package:pusdatin_end/models/dataset/dataset_pegawai.dart';
import 'package:pusdatin_end/models/dataset/dataset_pemeliharaan.dart';
import 'package:pusdatin_end/models/dataset/dataset_peminjaman.dart';
import 'package:pusdatin_end/models/dataset/dataset_peminjamanDetail.dart';

class ProvidersFilter extends ChangeNotifier {
  String _pencarian = '';
  int _indexAktif = 0;

  List<DatasetPegawai> _pegawai = [];
  List<DatasetPeminjaman> _pinjam = [];
  List<DatasetDatabarang> _barang = [];
  List<DatasetPemeliharaan> _pelihara = [];
  List<DatasetPeminjamandetail> _detail = [];

  List<DatasetPegawai> _filterPegawai = [];
  List<DatasetPeminjaman> _filterPinjam = [];
  List<DatasetDatabarang> _filterBarang = [];
  List<DatasetPemeliharaan> _filterPelihara = [];
  List<DatasetPeminjamandetail> _filterDetail = [];

  // Getter
  String get pencarian => _pencarian;
  List<DatasetPegawai> get filterPegawai => _filterPegawai;
  List<DatasetPeminjaman> get filterPinjam => _filterPinjam;
  List<DatasetDatabarang> get filterBarang => _filterBarang;
  List<DatasetPemeliharaan> get filterPelihara => _filterPelihara;
  List<DatasetPeminjamandetail> get filterDetail => _filterDetail;

  // Set Data
  void setPegawai(List<DatasetPegawai> pegawai) {
    _pegawai = pegawai;
    _filterPegawai = pegawai;
    notifyListeners();
  }

  void setPinjam(List<DatasetPeminjaman> pinjam) {
    _pinjam = pinjam;
    _filterPinjam = pinjam;
    notifyListeners();
  }

  void setBarang(List<DatasetDatabarang> barang) {
    _barang = barang;
    _filterBarang = barang;
    notifyListeners();
  }

  void setPelihara(List<DatasetPemeliharaan> pelihara) {
    _pelihara = pelihara;
    _filterPelihara = pelihara;
    notifyListeners();
  }

  void setDetail(List<DatasetPeminjamandetail> detail) {
    _detail = detail;
    _filterDetail = detail;
    notifyListeners();
  }

  // Update Index Aktif
  void setActiveTabIndex(int index) {
    _indexAktif = index;
    _pencarian = '';
    _applySearchQuery();
    notifyListeners();
  }

  // Update Query Pencarian
  void updateSearchQuery(String newQuery) {
    if (_pencarian != newQuery) {
      _pencarian = newQuery;
      _applySearchQuery();
      notifyListeners();
    }
  }

  // Apply Filter Berdasarkan Tab Aktif
  void _applySearchQuery() {
    final queryLower = _pencarian.toLowerCase();

    switch (_indexAktif) {
      case 0: // Pegawai
        _filterPegawai = _pegawai.where((pegawai) {
          return pegawai.nama.toLowerCase().contains(queryLower);
        }).toList();
        break;

      case 1: // Peminjaman
        _filterPinjam = _pinjam.where((pinjam) {
          return pinjam.nama_peminjam.toLowerCase().contains(queryLower) ||
              pinjam.instasi.toLowerCase().contains(queryLower) ||
              pinjam.jabatan.toLowerCase().contains(queryLower);
        }).toList();
        break;

      case 2: // Barang
        _filterBarang = _barang.where((barang) {
          return barang.id.toString().contains(queryLower) ||
              barang.merk.toLowerCase().contains(queryLower) ||
              barang.status.toLowerCase().contains(queryLower) ||
              barang.kondisi.toLowerCase().contains(queryLower) ||
              barang.jumlah.toString().contains(queryLower);
        }).toList();
        break;

      case 3: // Pemeliharaan
        _filterPelihara = _pelihara.where((pelihara) {
          return pelihara.status.toLowerCase().contains(queryLower) ||
              pelihara.kondisi.toLowerCase().contains(queryLower);
        }).toList();
        break;

      case 4: // Detail Peminjaman
        _filterDetail = _detail.where((detail) {
          return detail.namaPegawai.toLowerCase().contains(queryLower) ||
              detail.namaPeminjam.toLowerCase().contains(queryLower) ||
              detail.instansi.toLowerCase().contains(queryLower) ||
              (detail.inventaris.isNotEmpty &&
                  detail.inventaris.isNotEmpty &&
                  detail.inventaris.any((inv) =>
                      inv.namaInventaris.toLowerCase().contains(queryLower)));
        }).toList();
        break;

      default:
        // Jika index tidak valid, kosongkan semua filter
        _filterPegawai = [];
        _filterPinjam = [];
        _filterBarang = [];
        _filterPelihara = [];
        _filterDetail = [];
        break;
    }
    notifyListeners(); // Selalu notifikasi setelah filter diperbarui
  }
}
