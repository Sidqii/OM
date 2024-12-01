import 'package:flutter/material.dart';

class CustomLoading extends StatefulWidget {
  final double width;
  final VoidCallback? onCompleted;

  const CustomLoading({Key? key, required this.width, this.onCompleted}) : super(key: key);

  @override
  _CustomLoadingState createState() => _CustomLoadingState();
}

class _CustomLoadingState extends State<CustomLoading> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0, end: widget.width).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward(); // Mulai animasi hanya satu kali

    // Menambahkan listener untuk mendeteksi akhir animasi
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && widget.onCompleted != null) {
        widget.onCompleted!(); // Memanggil callback jika animasi selesai
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: widget.width,
        height: 5,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          border: Border.all(color: Colors.transparent),
        ),
        alignment: Alignment.centerLeft,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Container(
              width: _animation.value,
              height: 5,
              color: const Color(0xFF3D0E22),
            );
          },
        ),
      ),
    );
  }
}
