import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pusdatin_end/pages/tambah_dataBarang.dart';
import 'package:pusdatin_end/pages/tambah_pemeliharaan.dart';
import 'package:pusdatin_end/pages/tambah_peminjaman.dart';
import 'package:pusdatin_end/providers/providers_dataBarang.dart';
import 'package:pusdatin_end/providers/providers_pemeliharaan.dart';
import 'package:pusdatin_end/providers/providers_peminjaman.dart';
import 'package:pusdatin_end/widget/component/field/field_search.dart';

class MenuHeader extends StatefulWidget {
  final VoidCallback onEditData;
  final VoidCallback onAddData;
  final TabController tabController;
  final String userLevel;

  MenuHeader({
    required this.onEditData,
    required this.onAddData,
    required this.tabController,
    required this.userLevel,
  });

  @override
  _MenuHeaderState createState() => _MenuHeaderState();
}

class _MenuHeaderState extends State<MenuHeader> {
  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(() {
      final activeTabIndex = widget.tabController.index;
      print('Tab aktif diubah ke: $activeTabIndex');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: const Color(0xFF3D0E22),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo/pusdatin.png',
                    height: 135.0,
                  ),
                  const Text(
                    'INVENTARIS BARANG\nPUSDATIN KEMHAN',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              TabBar(
                controller: widget.tabController,
                tabs: const [
                  Tab(text: 'Data Barang'),
                  Tab(text: 'Pemeliharaan'),
                  Tab(text: 'Peminjaman'),
                ],
                indicator: BoxDecoration(),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white60,
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.userLevel.toLowerCase() == 'admin') ...[
                    // Edit Button
                    IconButton(
                      onPressed: widget.onEditData,
                      icon: const Icon(Icons.edit),
                      color: Colors.white,
                      iconSize: 24.0,
                      tooltip: 'Edit Data',
                    ),
                  ],
                  if (widget.userLevel.toLowerCase() == 'admin' ||
                      widget.userLevel.toLowerCase() == 'employee') ...[
                    // Tambah Button
                    IconButton(
                      onPressed: () {
                        final activeTabIndex = widget.tabController.index;
                        if (activeTabIndex == 0) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => tambahDatabarang(),
                            ),
                          );
                        } else if (activeTabIndex == 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => tambahPemeliharaan(),
                            ),
                          );
                        } else if (activeTabIndex == 2) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => tambahPeminjaman(),
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.add),
                      color: Colors.white,
                      iconSize: 24.0,
                      tooltip: 'Tambah data',
                    ),
                    const SizedBox(width: 16.0),
                  ],
                  Expanded(
                    child: Consumer2<ProviderDatabarang, ProviderPemeliharaan>(
                      builder: (context, dataBarangProvider,
                          pemeliharaanProvider, child) {
                        return CompSearch(
                          onSearch: (query) {
                            final activeTabIndex = widget.tabController.index;
                            // Penerapan filter berdasarkan tab yang aktif
                            if (activeTabIndex == 0) {
                              // Tab Data Barang
                              dataBarangProvider.applyFilter(query);
                            } else if (activeTabIndex == 1) {
                              // Tab Pemeliharaan
                              pemeliharaanProvider.applyFilter(query);
                            } else if (activeTabIndex == 2) {
                              // Tab Peminjaman
                              context
                                  .read<ProviderPeminjaman>()
                                  .applyFilter(query);
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
