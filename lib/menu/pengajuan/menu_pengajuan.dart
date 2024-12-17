import 'package:flutter/material.dart';
import 'package:pusdatin_end/models/mock/models_pengguna.dart';
import 'package:pusdatin_end/widget/component/field/field_button.dart';
import 'package:pusdatin_end/widget/component/page/comp_kembali.dart';
import 'package:pusdatin_end/widget/component/field/field_text.dart';

class LoanRequestPage extends StatefulWidget {
  final pengguna user;
  
LoanRequestPage({required this.user});
  @override
  _tambahPeminjaman createState() => _tambahPeminjaman();
}

class _tambahPeminjaman extends State<LoanRequestPage> {
  final formKey = GlobalKey<FormState>();

  // TextEditingControllers untuk setiap field
  final TextEditingController _nmPenanggungjawabController = TextEditingController();
  final TextEditingController _jabatanPeminjamController = TextEditingController();
  final TextEditingController _InstansiController = TextEditingController();
  final TextEditingController _golonganPeminjamController = TextEditingController();
  final TextEditingController _NRPpeminjamController = TextEditingController();
  final TextEditingController _namaPeminjamController = TextEditingController();
  final TextEditingController _tanggalPeminjamController = TextEditingController();
  final TextEditingController _InventarisController = TextEditingController();
  final TextEditingController _fotoBarangController = TextEditingController();
  final TextEditingController _HalController = TextEditingController();

  // Menyimpan error message untuk setiap field
  String? _nmPenaggungJawabError;
  String? _jabatanPeminjamError;
  String? _InstansiError;
  String? _golonganPeminjamError;
  String? _NRPpeminjamError;
  String? _namaPeminjamError;
  String? _tanggalPeminjamError;
  String? _InventarisError;
  String? _fotoBarangError;
  String? _HalError;

  // Fungsi untuk validasi form secara keseluruhan
  bool validateForm() {
    bool isValid = true;
    setState(() {
      _nmPenaggungJawabError =
          _nmPenanggungjawabController.text.isEmpty ? 'Silahkan masukan nomor seri' : null;
      _jabatanPeminjamError = _jabatanPeminjamController.text.isEmpty
          ? 'Silakan masukkan nama barang'
          : null;
      _InstansiError = _InstansiController.text.isEmpty
          ? 'Silakan masukkan kondisi barang'
          : null;
      _golonganPeminjamError = _golonganPeminjamController.text.isEmpty
          ? 'Silakan masukkan pengadaan barang'
          : null;
      _NRPpeminjamError = _NRPpeminjamController.text.isEmpty
          ? 'Silakan masukkan tanggal masuk barang'
          : null;
      _namaPeminjamError = _namaPeminjamController.text.isEmpty
          ? 'Silakan masukkan masa lisensi'
          : null;
      _tanggalPeminjamError = _tanggalPeminjamController.text.isEmpty
          ? 'Silakan masukkan merk barang'
          : null;
      _InventarisError = _InventarisController.text.isEmpty
          ? 'Silakan masukkan lokasi barang'
          : null;
      _fotoBarangError = _fotoBarangController.text.isEmpty
          ? 'Silakan masukkan foto barang'
          : null;
      _HalError = _HalController.text.isEmpty
          ? 'Silakan masukkan keterangan barang'
          : null;

      if (_nmPenaggungJawabError != null ||
          _jabatanPeminjamError != null ||
          _InstansiError != null ||
          _golonganPeminjamError != null ||
          _NRPpeminjamError != null ||
          _namaPeminjamError != null ||
          _tanggalPeminjamError != null ||
          _InventarisError != null ||
          _fotoBarangError != null ||
          _HalError != null) {
        isValid = false;
      }
    });
    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CompKembali(title: 'Pengajuan Peminjaman'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 35.0, top: 10.0),
              child: Text(
                'Peminjaman Barang',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            // Form Pengajuan
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      CompTxtfield(
                        label: 'Nama Peminjam',
                        controller: _nmPenanggungjawabController,
                        errorText: _nmPenaggungJawabError,
                        onChanged: (value) {
                          setState(() {
                            _nmPenaggungJawabError = null;
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
                                    label: 'Jabatan Peminjam',
                                    controller: _jabatanPeminjamController,
                                    errorText: _jabatanPeminjamError,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          _jabatanPeminjamError = null;
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
                                    label: 'Instansi',
                                    controller: _InstansiController,
                                    errorText: _InstansiError,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          _InstansiError = null;
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
                        label: 'NRP Peminjam',
                        controller: _golonganPeminjamController,
                        errorText: _golonganPeminjamError,
                        onChanged: (value) {
                          setState(() {
                            _golonganPeminjamError = null;
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
                                    label: 'Merk Barang',
                                    controller: _NRPpeminjamController,
                                    errorText: _NRPpeminjamError,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          _NRPpeminjamError = null;
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
                                    label: 'Nama Barang',
                                    controller: _namaPeminjamController,
                                    errorText: _namaPeminjamError,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          _namaPeminjamError = null;
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
                        label: 'Tanggal Peminjam',
                        controller: _tanggalPeminjamController,
                        errorText: _tanggalPeminjamError,
                        onChanged: (value) {
                          setState(() {
                            _tanggalPeminjamError = null;
                          });
                        },
                      ),
                      SizedBox(height: 3),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: Padding(
                      //         padding: const EdgeInsets.only(right: 8.0),
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             CompTxtfield(
                      //               label: 'Hal',
                      //               controller: _InventarisController,
                      //               errorText: _InventarisError,
                      //               onChanged: (value) {
                      //                 setState(
                      //                   () {
                      //                     _InventarisError = null;
                      //                   },
                      //                 );
                      //               },
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(width: 10),
                      //     Expanded(
                      //       child: Padding(
                      //         padding: const EdgeInsets.only(left: 8.0),
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             CompTxtfield(
                      //               label: 'Foto Barang',
                      //               controller: _fotoBarangController,
                      //               errorText: _fotoBarangError,
                      //               onChanged: (value) {
                      //                 setState(
                      //                   () {
                      //                     _fotoBarangError = null;
                      //                   },
                      //                 );
                      //               },
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(height: 35),
                      CompTxtfield(
                        label: 'Hal',
                        controller: _HalController,
                        errorText: _HalError,
                        onChanged: (value) {
                          setState(() {
                            _HalError = null;
                          });
                        },
                      ),
                      SizedBox(height: 85),
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
