import 'package:flutter/material.dart';
import 'package:pusdatin_end/widget/component/field/field_calendar.dart';
import 'package:pusdatin_end/widget/component/field/field_dropdown.dart';
import 'package:pusdatin_end/widget/component/field/field_lisensi.dart';
import 'package:pusdatin_end/widget/component/page/comp_kembali.dart';
import 'package:pusdatin_end/widget/component/field/field_text.dart';
import 'package:pusdatin_end/widget/component/field/field_button.dart';

class tambahDatabarang extends StatefulWidget {
  @override
  _tambahDatabarang createState() => _tambahDatabarang();
}

class _tambahDatabarang extends State<tambahDatabarang> {
  final formKey = GlobalKey<FormState>();

  // TextEditingControllers untuk setiap field
  final TextEditingController _noSeriController = TextEditingController();
  final TextEditingController _namaBarangController = TextEditingController();
  final TextEditingController _kondisiBarangController = TextEditingController();
  final TextEditingController _pengadaanBarangController = TextEditingController();
  final TextEditingController _tanggalMasukController = TextEditingController();
  final TextEditingController _masaLisensiController = TextEditingController();
  final TextEditingController _merkBarangController = TextEditingController();
  final TextEditingController _lokasiBarangController = TextEditingController();
  final TextEditingController _fotoBarangController = TextEditingController();
  final TextEditingController _keteranganBarangController = TextEditingController();

  // Menyimpan error message untuk setiap field
  String? _noSeriError;
  String? _namaBarangError;
  String? _kondisiBarangError;
  String? _pengadaanBarangError;
  String? _tanggalMasukError;
  String? _masaLisensiError;
  String? _merkBarangError;
  String? _lokasiBarangError;
  String? _fotoBarangError;
  String? _keteranganBarangError;

  // Fungsi untuk validasi form secara keseluruhan
  bool validateForm() {
    bool isValid = true;
    setState(() {
      _noSeriError =
          _noSeriController.text.isEmpty ? 'Silahkan masukan nomor seri' : null;
      _namaBarangError = _namaBarangController.text.isEmpty
          ? 'Silakan masukkan nama barang'
          : null;
      _kondisiBarangError = _kondisiBarangController.text.isEmpty
          ? 'Silakan masukkan kondisi barang'
          : null;
      _pengadaanBarangError = _pengadaanBarangController.text.isEmpty
          ? 'Silakan masukkan pengadaan barang'
          : null;
      _tanggalMasukError = _tanggalMasukController.text.isEmpty
          ? 'Silakan masukkan tanggal masuk barang'
          : null;
      _masaLisensiError = _masaLisensiController.text.isEmpty
          ? 'Silakan masukkan masa lisensi'
          : null;
      _merkBarangError = _merkBarangController.text.isEmpty
          ? 'Silakan masukkan merk barang'
          : null;
      _lokasiBarangError = _lokasiBarangController.text.isEmpty
          ? 'Silakan masukkan lokasi barang'
          : null;
      _fotoBarangError = _fotoBarangController.text.isEmpty
          ? 'Silakan masukkan foto barang'
          : null;
      _keteranganBarangError = _keteranganBarangController.text.isEmpty
          ? 'Silakan masukkan keterangan barang'
          : null;

      if (_noSeriError != null ||
          _namaBarangError != null ||
          _kondisiBarangError != null ||
          _pengadaanBarangError != null ||
          _tanggalMasukError != null ||
          _masaLisensiError != null ||
          _merkBarangError != null ||
          _lokasiBarangError != null ||
          _fotoBarangError != null ||
          _keteranganBarangError != null) {
        isValid = false;
      }
    });
    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CompKembali(title: 'Inventaris'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 35.0, top: 10.0),
              child: Text(
                'Tambah Data Barang', // Ganti dengan sub judul yang diinginkan
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            // Form
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      CompTxtfield(
                        label: 'No. Seri Barang',
                        controller: _noSeriController,
                        errorText: _noSeriError,
                        onChanged: (value) {
                          setState(() {
                            _noSeriError = null;
                          });
                        },
                      ),
                      SizedBox(height: 3),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CompTxtfield(
                                    label: 'Nama barang',
                                    controller: _namaBarangController,
                                    errorText: _namaBarangError,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          _namaBarangError = null;
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DrpField(
                                    label: 'Kondisi Barang',
                                    controller: _kondisiBarangController,
                                    errorText: null,
                                    onChanged: (selected) {
                                      print('Kondisi yang dipilih: $selected');
                                    },
                                    items: ['Baik', 'Rusak Ringan', 'Rusak Berat'],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 35),
                      CompTxtfield(
                        label: 'Pengadaan Barang',
                        controller: _pengadaanBarangController,
                        errorText: _pengadaanBarangError,
                        onChanged: (value) {
                          setState(() {
                            _pengadaanBarangError = null;
                          });
                        },
                      ),
                      SizedBox(height: 3),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TglField(
                                    label: 'Tanggal Masuk Barang',
                                    controller: _tanggalMasukController,
                                    errorText: _tanggalMasukError,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          _tanggalMasukError = null;
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  LisField(
                                    label: 'Masa Lisensi Barang',
                                    controller: _masaLisensiController,
                                    errorText: _masaLisensiError,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          _masaLisensiError = null;
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 35),
                      CompTxtfield(
                        label: 'Merk Barang',
                        controller: _merkBarangController,
                        errorText: _merkBarangError,
                        onChanged: (value) {
                          setState(() {
                            _merkBarangError = null;
                          });
                        },
                      ),
                      SizedBox(height: 3),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CompTxtfield(
                                    label: 'Lokasi Barang',
                                    controller: _lokasiBarangController,
                                    errorText: _lokasiBarangError,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          _lokasiBarangError = null;
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CompTxtfield(
                                    label: 'Foto Barang',
                                    controller: _fotoBarangController,
                                    errorText: _fotoBarangError,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          _fotoBarangError = null;
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 35),
                      CompTxtfield(
                        label: 'Keterangan Barang',
                        controller: _keteranganBarangController,
                        errorText: _keteranganBarangError,
                        onChanged: (value) {
                          setState(() {
                            _keteranganBarangError = null;
                          });
                        },
                      ),
                      SizedBox(height: 20),
                      CustomButton(
                        label: 'Kirim',
                        onPressed: (){
                          if (validateForm()) {
                            print('Form valid');
                          } else {
                            print('Form invalid');
                          }
                        })
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
