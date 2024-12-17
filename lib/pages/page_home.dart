import 'package:flutter/material.dart';
import 'package:pusdatin_end/menu/inventory/sub_menu/sub_inventori.dart';
import 'package:pusdatin_end/menu/approvement/menu_approvement.dart';
import 'package:pusdatin_end/menu/pengajuan/menu_pengajuan.dart';
import 'package:pusdatin_end/menu/profile/menu_profile.dart';
import 'package:pusdatin_end/menu/report/menu_report.dart';
import 'package:pusdatin_end/models/mock/models_pengguna.dart';
import 'package:pusdatin_end/widget/notifications/notif_page.dart';
import 'package:pusdatin_end/widget/card/chart/bar/chart_main.dart';
import 'package:pusdatin_end/widget/card/calendar/calendar_card.dart';

class HomePage extends StatefulWidget {
  final pengguna user;
  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200), () {
      print("HomePage loaded with User Level: ${widget.user.level}");
    });
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => profilePage(user: widget.user)),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => InventoriPage(user: widget.user)),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => reportPage(user: widget.user)),
        );
        break;
      case 3:
        if (widget.user.level.toLowerCase() == 'admin' ||
            widget.user.level.toLowerCase() == 'employee') {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ApprovePage(user: widget.user, status:'Request')),
          );
        } else if (widget.user.level.toLowerCase() == 'user') {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LoanRequestPage(user: widget.user)),
          );
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3D0E22),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            _buildCustomAppBar(),
            const SizedBox(height: 20),
            CalendarCard(),
            const SizedBox(height: 20),
            if (widget.user.level.toLowerCase() == 'admin' ||
                widget.user.level.toLowerCase() == 'employee')
              ChartBar(),
            if (widget.user.level.toLowerCase() == 'user') ChartBar()
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Inventaris',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Laporan',
          ),
          if (widget.user.level.toLowerCase() == 'admin' ||
              widget.user.level.toLowerCase() == 'employee')
            const BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Persetujuan',
            ),
          if (widget.user.level.toLowerCase() == 'user')
            const BottomNavigationBarItem(
              icon: Icon(Icons.add_box),
              label: 'Pengajuan',
            ),
        ],
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(fontSize: 12),
        unselectedLabelStyle: TextStyle(fontSize: 12),
      ),
    );
  }

  Widget _buildCustomAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.transparent,
                backgroundImage:
                    widget.user.avatar != null && widget.user.avatar!.isNotEmpty
                        ? AssetImage(widget.user.avatar!)
                        : null,
                child: widget.user.avatar == null || widget.user.avatar!.isEmpty
                    ? Icon(
                        Icons.person,
                        size: 45,
                        color: Colors.grey[400],
                      )
                    : null,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.user.name,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  Text(
                    widget.user.level.toString(),
                    style: const TextStyle(fontSize: 12, color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationPage()),
                  );
                },
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    '3',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
