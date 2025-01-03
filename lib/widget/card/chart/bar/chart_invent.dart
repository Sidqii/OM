import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pusdatin_end/models/dataset/dataset_databarang.dart';

class InventoryBarChart extends StatelessWidget {
  final String selectedCategory;
  final List<DatasetDatabarang>? dataBarang;

  const InventoryBarChart({
    Key? key,
    required this.selectedCategory,
    required this.dataBarang,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if (dataBarang == null || dataBarang!.isEmpty) {
      // print('Data barang yang diterima di chart: $dataBarang');
      // return const Center(
      //   child: Text('Data tidak tersedia'),
      // );
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.wifi_off,
              size: 50,
              color: Colors.grey,
            ),
            Text(
              'Tidak ada internet',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      );
    }

    final data = _generateSampleData();

    return SafeArea(
      child: MouseRegion(
        cursor: SystemMouseCursors.basic,
        child: data.isNotEmpty
            ? BarChart(
                BarChartData(
                  backgroundColor: Colors.transparent,
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 5,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      tooltipRoundedRadius: 8,
                      tooltipPadding: const EdgeInsets.all(6),
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        return BarTooltipItem(
                          'Value: ${rod.toY}',
                          const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final labels = selectedCategory == 'Kondisi'
                              ? ['Baik', 'Rusak Ringan', 'Rusak Berat']
                              : selectedCategory == 'Status'
                                  ? ['Dipinjam', 'Dipelihara', 'Request']
                                  : [];
                          final labelText = value.toInt() < labels.length
                              ? labels[value.toInt()]
                              : '';
                          return Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Text(
                              labelText,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                  barGroups: data,
                ),
              )
            : Center(
                child: Text(
                  'Data Tidak Tersedia',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
      ),
    );
  }

  List<BarChartGroupData> _generateSampleData() {
    final data = getDataByCategory();
    return data.isNotEmpty
        ? List.generate(data.length, (index) {
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: data[index].toDouble(),
                  color: Colors.blueAccent,
                  width: 45,
                  borderRadius: BorderRadius.circular(10),
                ),
              ],
            );
          })
        : [];
  }

  List<int> getDataByCategory() {
    if (selectedCategory == 'Kondisi') {
      return [
        dataBarang!
            .where((item) => item.kondisi == 'Baik')
            .fold(0, (sum, item) => sum + item.jumlah),
        dataBarang!
            .where((item) => item.kondisi == 'Rusak Ringan')
            .fold(0, (sum, item) => sum + item.jumlah),
        dataBarang!
            .where((item) => item.kondisi == 'Rusak Berat')
            .fold(0, (sum, item) => sum + item.jumlah),
      ];
    } else if (selectedCategory == 'Status') {
      return [
        dataBarang!
            .where((item) => item.status == 'Dipinjam')
            .fold(0, (sum, item) => sum + item.jumlah),
        dataBarang!
            .where((item) => item.status == 'Dipelihara')
            .fold(0, (sum, item) => sum + item.jumlah),
        dataBarang!
            .where((item) => item.status == 'Request')
            .fold(0, (sum, item) => sum + item.jumlah),
      ];
    }
    return [];
  }
}
