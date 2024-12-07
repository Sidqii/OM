import 'package:flutter/material.dart';

class LisField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String? errorText;
  final Function(int) onChanged;
  final int minValue;
  final int maxValue;

  const LisField({
    Key? key,
    required this.label,
    required this.controller,
    required this.errorText,
    required this.onChanged,
    this.minValue = 0,
    this.maxValue = 100,
  }) : super(key: key);

  @override
  _LisFieldState createState() => _LisFieldState();
}

class _LisFieldState extends State<LisField> {
  late int currentValue;

  @override
  void initState() {
    super.initState();
    // Initialize the current value from the controller's text or default value
    currentValue = int.tryParse(widget.controller.text) ?? widget.minValue;
  }

  void _increment() {
    setState(() {
      if (currentValue < widget.maxValue) {
        currentValue++;
        widget.controller.text = currentValue.toString();
        widget.onChanged(currentValue);
      }
    });
  }

  void _decrement() {
    setState(() {
      if (currentValue > widget.minValue) {
        currentValue--;
        widget.controller.text = currentValue.toString();
        widget.onChanged(currentValue);
      }
    });
  }

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
          TextFormField(
            controller: widget.controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: widget.controller.text.isEmpty ? '0' : widget.controller.text,
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
              prefixIcon: IconButton(
                icon: Icon(Icons.arrow_downward),
                onPressed: _decrement,
              ),
              suffixIcon: IconButton(
                icon: Icon(Icons.arrow_upward),
                onPressed: _increment,
              ),
            ),
            onChanged: (value) {
              int? parsedValue = int.tryParse(value);
              if (parsedValue != null && parsedValue >= widget.minValue && parsedValue <= widget.maxValue) {
                currentValue = parsedValue;
                widget.onChanged(currentValue);
              }
            },
          ),
        ],
      ),
    );
  }
}
