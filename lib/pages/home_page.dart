import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'add_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _tasksBox = Hive.box('myTasks');

  bool dataEmpty = true;
  List<Map<String, dynamic>> tasks_list = [];

  @override
  void initState() {
    super.initState();
    if (tasks_list.length == 0) {
      dataEmpty = true;
    } else {
      dataEmpty = false;
    }
  }

  void refreshTasks() {
    final data = _tasksBox.keys.map((key) {
      final item = _tasksBox.get(key);
      return {
        'id': key,
        'name': item['taskName'],
        'date': item['date'],
        'priorityColor': item['priorityColor'],
        'category': item['category'],
        'completedStatus': item['completedStatus'],
      };
    }).toList();

    setState(() {
      tasks_list = data.reversed.toList();
    });
  }

  Future<void> updateStatus(id) async {
    var item = _tasksBox.get(id);
    item['completedStatus'] = !item['completedStatus'];

    _tasksBox.putAt(id, item);

    refreshTasks();
  }

  @override
  Widget build(BuildContext context) {
    refreshTasks();

    return Scaffold(
      backgroundColor: Color(0xff242424),
      floatingActionButton: floatingButton(),
      appBar: appBarSection(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => SizedBox(
                  height: 10,
                ),
                itemCount: tasks_list.length,
                itemBuilder: (context, index) {
                  final item = tasks_list[index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(20, 20, 20, 0.83),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 1, right: 1),
                        child: CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.trailing,
                          value: item['completedStatus'],
                          onChanged: (value) {
                            updateStatus(item['id']);
                          },
                          checkColor: Colors.white,
                          activeColor: Color(0xff00C969),
                          title: Text(
                            item['name'],
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['date'],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromRGBO(0, 201, 104, 0.981),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(item['priorityColor']),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 2.0, bottom: 2, right: 5, left: 5),
                                  child: Text(
                                    item['category'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                //this is temporary, need to add an intro to the app
                // that says 'Create a task' or something like that
              ),
            ]),
      ),
    );
  }

  AppBar appBarSection() {
    return AppBar(
      elevation: 0,
      toolbarHeight: 75,
      centerTitle: true,
      automaticallyImplyLeading: false,
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

  FloatingActionButton floatingButton() {
    return FloatingActionButton(
      backgroundColor: Color(0xff00C969),
      foregroundColor: Colors.white,
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => const AddPage(),
          ),
        );
      },
      child: SvgPicture.asset(
        'assets/icons/plus-solid.svg',
        colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
        width: 25,
      ),
    );
  }
}
