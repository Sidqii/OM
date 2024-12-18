import 'package:flutter/material.dart';

class DrpField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String? errorText;
  final Function(String?) onChanged;
  final List<String> items;
  final String? Function(String?)? validator;

  const DrpField({
    Key? key,
    required this.label,
    required this.controller,
    this.errorText,
    required this.onChanged,
    required this.items,
    this.validator,
  }) : super(key: key);

  @override
  _DrpFieldState createState() => _DrpFieldState();
}

class _DrpFieldState extends State<DrpField> {
  late FocusNode _focusNode;
  String? _selectedItem;
  String? _currentError;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle labelStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: _focusNode.hasFocus ? Colors.black : Colors.black54,
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label, style: labelStyle),
          GestureDetector(
            onTap: () async {
              // Tampilkan dropdown saat field ditekan
              String? selected = await showDialog<String>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Pilih ${widget.label}'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: widget.items.map((item) {
                          return ListTile(
                            title: Text(item),
                            onTap: () {
                              Navigator.of(context).pop(item);
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              );
              if (selected != null) {
                setState(() {
                  _selectedItem = selected;
                  _currentError = null; // Reset error jika ada
                });
                widget.controller.text = selected;
                widget.onChanged(selected);
              }
            },
            child: AbsorbPointer(
              child: TextFormField(
                controller: widget.controller,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: _selectedItem ?? "Pilih ${widget.label}",
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: _currentError != null ? Colors.red : Colors.black54,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: _currentError != null ? Colors.red : Colors.black,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: _currentError != null ? Colors.red : Colors.black54,
                    ),
                  ),
                  errorText: _currentError,
                ),
                onChanged: (value) {
                  // Reset error saat mengetik
                  setState(() {
                    _currentError = null;
                  });
                  widget.onChanged(value);
                },
              ),
            ),
          ),
          if (_currentError != null)
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                _currentError!,
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
        ],
      ),
    );
  }

  // Fungsi untuk validasi
  void validate() {
    if (widget.validator != null) {
      setState(() {
        _currentError = widget.validator!(widget.controller.text);
      });
    }
  }
}
