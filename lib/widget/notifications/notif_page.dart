import 'package:flutter/material.dart';
import 'package:pusdatin_end/widget/component/page/comp_kembali.dart';
import 'package:pusdatin_end/widget/notifications/notif_item.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  final List<Map<String, String>> notifications = const [
    {
      "message": "Pemeliharaan barang sudah hampir selesai!"
    },
    {
      "image": "assets/pusdatin.png",
      "message": "Peminjaman melewati masa tenggang!"
    },
    {
      "image": "assets/pusdatin.png",
      "message": "Pengurus meminta untuk melakukan pemeliharaan barang!"
    },
    {
      "image": "assets/pusdatin.png",
      "message": "Pengembalian barang sudah diterima!"
    },
    {
      "image": "assets/pusdatin.png",
      "message": "Barang perlu diperiksa kembali!"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CompKembali(
        title: 'Menu',
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                NotificationItem(
                  imagePath: notifications[index]["image"]??'assets/logo/pusdatin.png',
                  message: notifications[index]["message"]!,
                ),
                SizedBox(height: 10),
                const Divider(),
              ],
            );
          },
        ),
      ),
    );
  }
}
