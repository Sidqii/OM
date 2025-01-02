
import 'package:flutter/material.dart';
import 'package:pusdatin_end/models/mock/models_pengguna.dart';
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

  // Enter function pada tiap field
  final FocusNode nmPeminjamFocus = FocusNode();
  final FocusNode jabatanPeminjamFocus = FocusNode();
  final FocusNode instansiFocus = FocusNode();
  final FocusNode nrpPeminjamFocus = FocusNode();
  final FocusNode merkBarangFocus = FocusNode();
  final FocusNode nmBarangFocus = FocusNode();
  final FocusNode tglPeminjamanFocus = FocusNode();
  final FocusNode halFocus = FocusNode();

  // TextEditingControllers untuk setiap field
  final Map<String, TextEditingController> controllers = {
    'nmPenanggungJawab': TextEditingController(),
    'nmPeminjam': TextEditingController(),
    'jabatanPeminjam': TextEditingController(),
    'golPeminjam': TextEditingController(),
    'nrpPeminjam': TextEditingController(),
    'instansi': TextEditingController(),
    'merkBarang': TextEditingController(),
    'nmBarang': TextEditingController(),
    'tglPeminjaman': TextEditingController(),
    'fotoBarang': TextEditingController(),
    'hal': TextEditingController(),
  };

  // Menyimpan error message untuk setiap field
  final Map<String, String?> errors = {};

  // Fungsi untuk validasi form secara keseluruhan
  bool validateForm() {
    bool isValid = true;
    setState(() {
      errors.clear();
      controllers.forEach((Key, controller) {
        if (controller.text.isEmpty) {
          errors[Key] = 'Silahkan masukan $Key';
          isValid = false;
        } else {
          errors[Key] = null;
        }
      });
    });
    return isValid;
  }

  void onFieldSubmitted (FocusNode nextFocus){
    FocusScope.of(context).requestFocus(nextFocus);
  }

  Widget buildTextField(
      String label, TextEditingController controller, String? errorText,
      {bool isDate = false, FocusNode? nextFocus}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: CompTxtfield(
        label: label,
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Field wajib diisi';
          }
          return null;
        },
        onFieldSubmitted: (_){
          if (nextFocus != null) {
            onFieldSubmitted(nextFocus);
          }
        },
        onChanged: (value) {
          setState(() {
            errors[label] = null;
          });
        },
      ),
    );
  }

  // Header laman Peminjaman Barang
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

            // Form Pengajuan Peminjaman Barang
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextField(
                    'Nama Peminjam',
                    controllers['nmPeminjam']!,
                    errors['nmPeminjam'],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: buildTextField(
                          'Jabatan Peminjam',
                          controllers['jabatanPeminjam']!,
                          errors['jabatanPeminjam'],
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: buildTextField(
                          'Instansi',
                          controllers['instansi']!,
                          errors['instansi'],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 30),
                  buildTextField(
                    'NRP Peminjam',
                    controllers['nrpPeminjam']!,
                    errors['nrpPeminjam'],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: buildTextField(
                          'Merk Barang',
                          controllers['merkBarang']!,
                          errors['merkBarang'],
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: buildTextField(
                          'Nama Barang',
                          controllers['nmBarang']!,
                          errors['nmBarang'],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  buildTextField(
                    'Tanggal Peminjaman',
                    controllers['tglPeminjaman']!,
                    errors['tglPeminjaman'],
                  ),
                  SizedBox(height: 30),
                  buildTextField(
                    'Hal',
                    controllers['hal']!,
                    errors['hal'],
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (validateForm()) {
                  print('Form valid');
                } else {
                  print('Form invalid');
                }
              },
              child: Text('Kirim'),
            ),
          ],
        ),
      ),
    );
  }
}
