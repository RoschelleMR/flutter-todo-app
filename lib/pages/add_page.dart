import 'package:basic/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  //box to store tasks
  final _tasksBox = Hive.box('myTasks');

  final formKey = GlobalKey<FormState>();
  TextEditingController date_controller = TextEditingController();
  TextEditingController taskName_controller = TextEditingController();


  // default selected priority
  int prioritySelected = 0;
  String priorityName = 'High';
  int priorityColor = 0xffE00000;

  Future<void> createTask(Map<String, dynamic> newItem) async {
    await _tasksBox.add(newItem);
  }

  void saveTask() {
    createTask({
      'taskName': taskName_controller.text,
      'date': date_controller.text,
      'priorityColor': priorityColor,
      'category': priorityName,
      'completedStatus': false,
    });

    taskName_controller.clear();
    date_controller.clear();
  }

  

  Widget CustomRadioButton(String btnText, int index, int color) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          prioritySelected = index;
          priorityName = btnText;
          priorityColor = color;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          btnText,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Color(color)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7),
          ),
        ),
        side: MaterialStateProperty.all(
          BorderSide(
            color: (prioritySelected == index)
                ? Colors.blue.shade300
                : Colors.transparent,
            width: 4,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff00C969),
      appBar: _appBarSection(context),
      body: Column(
        children: [
          _headerText(),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: taskName_controller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Task';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            width: 2.5,
                            color: Colors.black,
                          )),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 1.5,
                              color: Color.fromARGB(255, 0, 170, 255),
                            ),
                          ),
                          labelText: 'Add Task',
                          labelStyle: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          hintText: 'Eg. Learn Flutter',
                        ),
                      ),
                      // SizedBox(
                      //   height: 30,
                      // ),
                      TextFormField(
                          controller: date_controller,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Date';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            suffixIcon: Icon(Icons.calendar_month, size: 35),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              width: 2.5,
                              color: Colors.black,
                            )),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: Color.fromARGB(255, 0, 170, 255),
                              ),
                            ),
                            labelText: 'Date',
                            labelStyle: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                            hintText: 'Eg. June 17, 2023',
                          ),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(3000));

                            if (pickedDate != null) {
                              date_controller.text =
                                  DateFormat.yMMMMEEEEd('en_US')
                                      .format(pickedDate);
                            }
                          }),
                      // SizedBox(
                      //   height: 30,
                      // ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Priorty',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomRadioButton('High', 0, 0xffE00000),
                              CustomRadioButton('Medium', 1, 0xffFFB800),
                              CustomRadioButton('Low', 2, 0xff04E000),
                            ],
                          ),
                        ],
                      ),
                      // for save button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                saveTask();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Color(0xff00C969),
                                      content: Text(
                                        'Task Added',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ),
                                );
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 10,
                                bottom: 10,
                                left: 50,
                                right: 50,
                              ),
                              child: Text(
                                'Save',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xff00C969)),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(280),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => const HomePage(),
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
