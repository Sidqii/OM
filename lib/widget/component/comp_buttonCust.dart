import 'package:flutter/material.dart';

// Widget tombol yang modular dan bisa digunakan kembali
class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  CustomButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // agar tombol lebar penuh seperti TextField
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3), // rounded corner
          ),
          padding: EdgeInsets.symmetric(vertical: 16), // padding vertikal
          backgroundColor: Color(0xFF3D0E22), // warna latar belakang tombol
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1,
          ),
        ),
      ),
    );
  }
}
