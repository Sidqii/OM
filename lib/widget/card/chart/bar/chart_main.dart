import 'package:flutter/material.dart';
import 'chart_drpdwn.dart' as custom;
import 'chart_invent.dart';

class ChartBar extends StatefulWidget {
  @override
  _ChartBarState createState() => _ChartBarState();
}

class _ChartBarState extends State<ChartBar> {
  String selectedCategory = 'Kondisi';

  void _onCategoryChanged(String? newCategory) async {
    await Future.delayed(const Duration(
      milliseconds: 50
    ));
    setState(() {
      selectedCategory = newCategory ?? 'Kondisi';
      print('Selected Category changed to: $selectedCategory');
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: double.infinity,
      height: screenHeight * 0.30,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Kondisi Inventaris Barang',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              // Spacer(),
              custom.DropdownMenu(
                selectedCategory: selectedCategory,
                onCategoryChanged: _onCategoryChanged,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: InventoryBarChart(
              selectedCategory: selectedCategory,
            ),
          ),
        ],
      ),
    );
  }
}
