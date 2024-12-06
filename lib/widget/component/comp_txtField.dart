import 'package:flutter/material.dart';

class CompTxtfield extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String? errorText;
  final Function(String) onChanged;

  const CompTxtfield({
    Key? key,
    required this.label,
    required this.controller,
    required this.errorText,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CompTxtfieldState createState() => _CompTxtfieldState();
}

class _CompTxtfieldState extends State<CompTxtfield> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    // Memantau perubahan fokus
    _focusNode.addListener(() {
      setState(() {}); // Ketika fokus berubah, widget akan diupdate
    });
  }

  @override
  void dispose() {
    _focusNode.dispose(); // Jangan lupa dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Set warna label berdasarkan fokus
    TextStyle labelStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: _focusNode.hasFocus ? Colors.black : Colors.black54, // Warna label berubah saat fokus
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label, style: labelStyle),
          TextFormField(
            controller: widget.controller,
            focusNode: _focusNode, // Fokuskan field ke FocusNode
            decoration: InputDecoration(
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: widget.errorText != null ? Colors.red : Colors.black54, // Border merah jika error
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: widget.errorText != null ? Colors.red : Colors.black, // Border biru saat fokus
                ),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: widget.errorText != null ? Colors.red : Colors.black54, // Border default jika tidak ada error
                ),
              ),
            ),
            onChanged: widget.onChanged,
          ),
        ],
      ),
    );
  }
}
