import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('หน้าแรก', style: TextStyle(fontSize: 24, fontFamily: 'Kanit')),
    );
  }
}
