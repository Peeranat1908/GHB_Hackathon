import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  
  final List<Widget> _pages = [
    const Center(child: Text('หน้าแรก', style: TextStyle(fontSize: 24, fontFamily: 'Kanit'))),
    const Center(child: Text('สแกน', style: TextStyle(fontSize: 24, fontFamily: 'Kanit'))),
    const Center(child: Text('โปรไฟล์', style: TextStyle(fontSize: 24, fontFamily: 'Kanit'))),
    const Center(child: Text('บัญชี', style: TextStyle(fontSize: 24, fontFamily: 'Kanit')))
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('GHB', style: TextStyle(fontFamily: 'Kanit')),
        backgroundColor: Colors.red,
        titleTextStyle: const TextStyle(
          fontFamily: 'Kanit',
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedFontSize: 14,
        unselectedFontSize: 12,
        selectedLabelStyle: const TextStyle(fontFamily: 'Kanit'),
        unselectedLabelStyle: const TextStyle(fontFamily: 'Kanit'),
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'หน้าแรก',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.document_scanner),
            label: 'สแกน',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'โปรไฟล์',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'บัญชี',
          )
        ],
      ),
    );
  }
}