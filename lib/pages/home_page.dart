import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'add_page.dart';

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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff00C969),
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => 
              const AddPage(),
            ),
          );
        },
        child: SvgPicture.asset(
          'assets/icons/plus-solid.svg',
          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
          width: 25,
        ),
      ),
      appBar: appBarSection(),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 12, bottom: 12),
          child: Text(
            'All Tasks',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Color(0xFF888888).withOpacity(0.2)),
          ),
        ),
      ]),
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
