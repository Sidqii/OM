import 'package:flutter/material.dart';
import 'package:pusdatin_end/widget/component/comp_buttonCust.dart';
import 'package:pusdatin_end/widget/component/comp_kembali.dart';
import 'package:pusdatin_end/widget/component/comp_txtField.dart';

class tambahPemeliharaan extends StatefulWidget {
  @override
  _tambahPemeliharaan createState() => _tambahPemeliharaan();
}

class _tambahPemeliharaan extends State<tambahPemeliharaan> {
  final formKey = GlobalKey<FormState>();

  // TextEditingControllers untuk setiap field
  final TextEditingController _namaPetugasController = TextEditingController();
  final TextEditingController _namaBarangController = TextEditingController();
  final TextEditingController _kondisiBarangController = TextEditingController();
  final TextEditingController _keteranganPeliharaController = TextEditingController();
  final TextEditingController _lokasiBarangController = TextEditingController();
  final TextEditingController _fotoBarangController = TextEditingController();

  // Menyimpan error message untuk setiap field
  String? _nmPetugasError;
  String? _namaBarangError;
  String? _kondisiBarangError;
  String? _keteranganPeliharaError;
  String? _lokasiBarangError;
  String? _fotoBarangError;

  // Fungsi untuk validasi form secara keseluruhan
  bool validateForm() {
    bool isValid = true;
    setState(() {
      _nmPetugasError =
          _namaPetugasController.text.isEmpty ? 'Silahkan masukan nomor seri' : null;
      _namaBarangError = _namaBarangController.text.isEmpty
          ? 'Silakan masukkan nama barang'
          : null;
      _kondisiBarangError = _kondisiBarangController.text.isEmpty
          ? 'Silakan masukkan kondisi barang'
          : null;
      _keteranganPeliharaError = _keteranganPeliharaController.text.isEmpty
          ? 'Silakan masukkan pengadaan barang'
          : null;
      _lokasiBarangError = _lokasiBarangController.text.isEmpty
          ? 'Silakan masukkan lokasi barang'
          : null;
      _fotoBarangError = _fotoBarangController.text.isEmpty
          ? 'Silakan masukkan foto barang'
          : null;

      if (_nmPetugasError != null ||
          _namaBarangError != null ||
          _kondisiBarangError != null ||
          _keteranganPeliharaError != null ||
          _lokasiBarangError != null ||
          _fotoBarangError != null ||
          _lokasiBarangError != null ||
          _fotoBarangError != null) {
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
                'Tambah Pemeliharaan Barang', // Ganti dengan sub judul yang diinginkan
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
                        label: 'Nama Petugas',
                        controller: _namaPetugasController,
                        errorText: _nmPetugasError,
                        onChanged: (value) {
                          setState(() {
                            _nmPetugasError = null;
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
                                    label: 'Nama Barang',
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
                                  CompTxtfield(
                                    label: 'Kondisi Barang',
                                    controller: _kondisiBarangController,
                                    errorText: _kondisiBarangError,
                                    onChanged: (value) {
                                      setState(
                                        () {
                                          _kondisiBarangError = null;
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
                        label: 'Keterangan',
                        controller: _keteranganPeliharaController,
                        errorText: _keteranganPeliharaError,
                        onChanged: (value) {
                          setState(() {
                            _keteranganPeliharaError = null;
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
                                    label: 'Lokasi',
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
                                    label: 'Foto',
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
                      // SizedBox(height: 35),
                      // CompTxtfield(
                      //   label: 'Merk Barang',
                      //   controller: _merkBarangController,
                      //   errorText: _merkBarangError,
                      //   onChanged: (value) {
                      //     setState(() {
                      //       _merkBarangError = null;
                      //     });
                      //   },
                      // ),
                      // SizedBox(height: 3),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: Padding(
                      //         padding: const EdgeInsets.only(right: 8.0),
                      //         child: Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             CompTxtfield(
                      //               label: 'Lokasi Barang',
                      //               controller: _lokasiBarangController,
                      //               errorText: _lokasiBarangError,
                      //               onChanged: (value) {
                      //                 setState(
                      //                   () {
                      //                     _lokasiBarangError = null;
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
                      // SizedBox(height: 35),
                      // CompTxtfield(
                      //   label: 'Keterangan Barang',
                      //   controller: _keteranganBarangController,
                      //   errorText: _keteranganBarangError,
                      //   onChanged: (value) {
                      //     setState(() {
                      //       _keteranganBarangError = null;
                      //     });
                      //   },
                      // ),
                      SizedBox(height: 310),
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
