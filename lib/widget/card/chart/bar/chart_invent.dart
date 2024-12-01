import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pusdatin_end/dummy/dummy_dataBarag.dart';

class InventoryBarChart extends StatelessWidget {
  final String selectedCategory;

  const InventoryBarChart({
    Key? key,
    required this.selectedCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data =
        _generateSampleData();

    return SafeArea(
      child: MouseRegion(
        cursor: SystemMouseCursors.basic,
        child: data.isNotEmpty
            ? BarChart(
                BarChartData(
                  backgroundColor: Colors.transparent,
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 50,
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
                              : selectedCategory == 'Merek'
                                  ? ['Gems', 'Geode', 'Artisan']
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
        dummyItems
            .where((item) => item.kondisi == 'Baik')
            .fold(0, (sum, item) => sum + item.jmlBarang),
        dummyItems
            .where((item) => item.kondisi == 'Rusak Ringan')
            .fold(0, (sum, item) => sum + item.jmlBarang),
        dummyItems
            .where((item) => item.kondisi == 'Rusak Berat')
            .fold(0, (sum, item) => sum + item.jmlBarang),
      ];
    } else if (selectedCategory == 'Merek') {
      return [
        dummyItems
            .where((item) => item.mrkBarang == 'Gems')
            .fold(0, (sum, item) => sum + item.jmlBarang),
        dummyItems
            .where((item) => item.mrkBarang == 'Geode')
            .fold(0, (sum, item) => sum + item.jmlBarang),
        dummyItems
            .where((item) => item.mrkBarang == 'Artisan')
            .fold(0, (sum, item) => sum + item.jmlBarang)
      ];
    }
    return [];
  }
}
