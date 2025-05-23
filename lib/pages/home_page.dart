// home_page.dart
import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'scan_page.dart';
import 'wallet_page.dart';
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
    const ProfileScreen(),
    const AccountScreen()
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
      appBar: AppBar(
        title: const Text('วิเคราะห์การเงินของคุณ', 
          style: TextStyle(fontFamily: 'Kanit', fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFE74C3C),
        titleTextStyle: const TextStyle(
          fontFamily: 'Kanit',
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        elevation: 0,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedFontSize: 12,
        unselectedFontSize: 10,
        selectedLabelStyle: const TextStyle(fontFamily: 'Kanit'),
        unselectedLabelStyle: const TextStyle(fontFamily: 'Kanit'),
        selectedItemColor: const Color(0xFFE74C3C),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'หน้าแรก',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'ออมเงิน',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'วิเคราะห์',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'ตั้งค่า',
          ),
        ],
      ),
    );
  }
}
