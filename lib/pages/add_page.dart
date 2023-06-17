import 'package:basic/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xff00C969),

      appBar: _appBarSection(context),

      body: Column(
        children: [
          _headerText(),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }


  Container _headerText() {
    return Container(
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xff00C969),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'TaskPal',
              style: TextStyle(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.bold, 
              ),
            ),
          ),
        );
  }



  AppBar _appBarSection(BuildContext context) {
    return AppBar(
       backgroundColor: Color(0xff00C969),
       elevation: 0,
       leading: GestureDetector(
          onTap: (){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => 
                const HomePage(),
              ),
            );
          },
         child: Container(
          margin: EdgeInsets.all(8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color.fromARGB(126, 255, 255, 255),
            borderRadius: BorderRadius.circular(50),
          ),
          child: SvgPicture.asset(
            'assets/icons/xmark-solid.svg',
            colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
            width: 26,
            height: 26,
            fit: BoxFit.scaleDown,
          ),
         ),
       ),
    );
  }
}
