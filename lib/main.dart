import 'package:flutter/material.dart';
import 'pages/product_screen.dart'; // <<< Import ProductScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ProductScreen(), // <<< Change this to ProductScreen
      theme: ThemeData(
        fontFamily: 'NotoSansThai_Condensed',
      ),
    );
  }
}
