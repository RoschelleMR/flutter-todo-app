import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff242424),
      appBar: appBarSection(),
      body: Column(
        children: [

        ]
      ),
    );
  }



  AppBar appBarSection() {
    return AppBar(
      elevation: 0,
      toolbarHeight: 75,
      centerTitle: true,
      title: Text(
        'TaskPal',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Color(0xff00C969),
    );
  }
}
