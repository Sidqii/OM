import 'package:flutter/material.dart';

class CompSearch extends StatelessWidget {
  final ValueChanged<String> onSearch;

  const CompSearch({Key?key, required this.onSearch}) : super(key: key);

  // @override
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onSearch,
      decoration: InputDecoration(
        hintText: 'Cari',
        filled: true,
        fillColor: Colors.white,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(fontSize: 14.0),
    );
  }
}