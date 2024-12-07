import 'package:flutter/material.dart';

class TglField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String? errorText;
  final Function(String?) onChanged;

  const TglField({
    Key? key,
    required this.label,
    required this.controller,
    required this.errorText,
    required this.onChanged,
  }) : super(key: key);

  @override
  _TglFieldState createState() => _TglFieldState();
}

class _TglFieldState extends State<TglField> {
  @override
  Widget build(BuildContext context) {
    // Set warna label berdasarkan fokus
    TextStyle labelStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: widget.controller.text.isNotEmpty ? Colors.black : Colors.black54,
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label, style: labelStyle),
          GestureDetector(
            onTap: () async {
              // Tampilkan date picker ketika field ditekan
              DateTime? selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900), // Tanggal awal yang diperbolehkan
                lastDate: DateTime(2101),  // Tanggal akhir yang diperbolehkan
              );
              if (selectedDate != null) {
                // Format tanggal ke format yang diinginkan (misalnya dd-MM-yyyy)
                String formattedDate = "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
                widget.controller.text = formattedDate;
                widget.onChanged(formattedDate); // Panggil callback untuk memberi tahu tanggal yang dipilih
              }
            },
            child: AbsorbPointer(
              child: TextFormField(
                controller: widget.controller,
                decoration: InputDecoration(
                  hintText: widget.controller.text.isEmpty ? null : widget.controller.text, // Menghilangkan hintText jika sudah ada teks
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: widget.errorText != null ? Colors.red : Colors.black54,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: widget.errorText != null ? Colors.red : Colors.black,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: widget.errorText != null ? Colors.red : Colors.black54,
                    ),
                  ),
                  suffixIcon: Icon(Icons.calendar_today), // Menampilkan ikon kalender di kanan
                ),
                onChanged: widget.onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
