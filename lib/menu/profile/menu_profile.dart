import 'package:flutter/material.dart';
import 'package:pusdatin_end/models/mock/models_pengguna.dart';
import 'package:pusdatin_end/widget/component/comp_kembali.dart';

class profilePage extends StatelessWidget {
  final pengguna user;

  const profilePage({required this.user});

  void _onLogoutPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Apakah Anda yakin ingin logout?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Menutup dialog
            },
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Menutup dialog
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Logout berhasil!")),
              );
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CompKembali(
        title: 'Menu',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 98),  // Jarak atas 98
          const Text(
            'Profil',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Selamat datang ${user.name}, ${user.level}',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 40),
          Center(
            child: SizedBox(
              width: 150,
              height: 150,
              child: Stack(
                children: [
                  // Garis atas
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 2,
                      width: 100,
                      color: const Color(0xFFD4CBB8),
                    ),
                  ),
                  // Garis bawah
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 2,
                      width: 100,
                      color: const Color(0xFFD4CBB8),
                    ),
                  ),
                  // Garis kiri
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 100,
                      width: 2,
                      color: const Color(0xFFD4CBB8),
                    ),
                  ),
                  // Garis kanan
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 100,
                      width: 2,
                      color: const Color(0xFFD4CBB8),
                    ),
                  ),
                  // Ikon profil di tengah
                  const Align(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.person,
                      size: 100,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 98),  // Jarak bawah 98
          Column(
            children: [
              // Row untuk menempatkan logo dan teks secara horizontal
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo Kemhan di samping teks
                  SizedBox(
                    width: 55,  // Ukuran logo
                    height: 55,
                    child: Image(
                      image: AssetImage('assets/logo/pusdatin.png'), // Sesuaikan dengan nama file logo
                    ),
                  ),
                  SizedBox(width: 10),  // Jarak antara logo dan teks
                  Text(
                    'PUSAT DATA DAN INFORMASI\nKementrian Pertahanan RI',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  _onLogoutPressed(context); // Menangani aksi logout
                },
                child: const Text(
                  'LOGOUT',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}