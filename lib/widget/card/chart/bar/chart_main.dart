import 'chart_drpdwn.dart' as custom;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pusdatin_end/providers/providers_dataBarang.dart';
import 'package:pusdatin_end/widget/card/chart/bar/chart_invent.dart';

class ChartBar extends StatefulWidget {
  @override
  _ChartBarState createState() => _ChartBarState();
}

class _ChartBarState extends State<ChartBar> {
  String selectedCategory = 'Status';

  @override
  void initState() {
    super.initState();
    print('Memanggil fetchDataBarang');
    Provider.of<ProviderDatabarang>(context, listen: false).fetchDataBarang();
  }

  void _onCategoryChanged(String newCategory) async {
    await Future.delayed(const Duration(milliseconds: 50));
    setState(() {
      selectedCategory = newCategory;
      print('Selected Category changed to: $selectedCategory');
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final provider = Provider.of<ProviderDatabarang>(context);

    if (provider.isLoading) {
      print('Data dalam proses fetch');
    } else {
      print('Data barang di ChartBar: ${provider.dataBarang}');
    }

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
              custom.DropdownMenu(
                selectedCategory: selectedCategory,
                onCategoryChanged: _onCategoryChanged,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: provider.isLoading ? const Center(
              child: CircularProgressIndicator(),
              ) : InventoryBarChart(selectedCategory: selectedCategory, dataBarang: provider.dataBarang),
          ),
        ],
      ),
    );
  }
}
