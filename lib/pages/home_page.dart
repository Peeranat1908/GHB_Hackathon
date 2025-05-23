import 'package:flutter/material.dart';
import 'analyst_page.dart';
import 'scan_page.dart';
import 'setting_page.dart';
import 'home_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const ScanScreen(),
    const AnalystScreen(),
    const SettingScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E8),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                child: _pages[_selectedIndex],
                transitionBuilder: (child, animation) =>
                    FadeTransition(opacity: animation, child: child),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: _selectedIndex,
          selectedFontSize: 13,
          unselectedFontSize: 11,
          selectedLabelStyle: const TextStyle(fontFamily: 'Kanit'),
          unselectedLabelStyle: const TextStyle(fontFamily: 'Kanit'),
          selectedItemColor: const Color(0xFFE74C3C),
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded, size: 28),
              label: 'หน้าแรก',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.qr_code_scanner_rounded, size: 28),
              label: 'ออมเงิน',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.trending_up_rounded, size: 28),
              label: 'วิเคราะห์',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded, size: 28),
              label: 'ตั้งค่า',
            ),
          ],
        ),
      ),
    );
  }
}
