import 'package:basic/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TaskPal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins',),
      home: HomePage(),
    );
  }
}
