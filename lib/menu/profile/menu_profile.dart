import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              Navigator.pop(context);
            },
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Logout berhasil!")),
              );
              SystemNavigator.pop();
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
          const SizedBox(height: 75),
          const Text(
            'Profil',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Selamat datang ${user.name}, ${user.level}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 130),
          Center(
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
              ),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage(user.avatar),
              ),
            ),
          ),
          const SizedBox(height: 130),
          Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 65,
                    height: 65,
                    child: Image(
                      image: AssetImage('assets/logo/pusdatin.png'),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                    'PUSAT DATA DAN INFORMASI',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Kementrian Pertahanan Republik Indonesia',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                    )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 45),
              GestureDetector(
                onTap: () {
                  _onLogoutPressed(context);
                },
                child: const Text(
                  'LOGOUT',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
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
