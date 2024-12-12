import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  final String imagePath;
  final String message;

  const NotificationItem({
    super.key,
    required this.imagePath,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: AssetImage('assets/logo/pusdatin.png'),
        radius: 25,
      ),
      title: Text(
        message,
        style: const TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }
}
