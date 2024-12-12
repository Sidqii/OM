import 'package:flutter/material.dart';
import 'package:pusdatin_end/menu/inventory/sub_menu/sub_header.dart';
import 'package:pusdatin_end/menu/inventory/tab/tab_dataBarang.dart';
import 'package:pusdatin_end/menu/inventory/tab/tab_pemeliharaan.dart';
import 'package:pusdatin_end/menu/inventory/tab/tab_peminjaman.dart';
import 'package:pusdatin_end/models/mock/models_pengguna.dart';
import 'package:pusdatin_end/widget/component/page/comp_kembali.dart';

class InventoriPage extends StatefulWidget {
  final pengguna user;

  const InventoriPage({Key? key, required this.user}) : super(key: key);

  @override
  _InventoriPageState createState() => _InventoriPageState();
}

class _InventoriPageState extends State<InventoriPage> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CompKembali(
        title: 'Inventaris',
        onBack: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        children: [
          MenuHeader(
            onEditData: () {
              if (widget.user.level.toLowerCase()== 'admin' || widget.user.level.toLowerCase()== 'employee') {
                print('Edit Data');
              }
            },
            onAddData: () {
              if (widget.user.level.toLowerCase() == 'admin' || widget.user.level.toLowerCase()== 'employee') {
                print('Tambah Data');
              }
            },
            tabController: _tabController!,
            userLevel: widget.user.level.toLowerCase().toString(),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                TabDatabarang(user: widget.user),
                TabPemeliharaan(user: widget.user,),
                TabPeminjaman(user: widget.user,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
