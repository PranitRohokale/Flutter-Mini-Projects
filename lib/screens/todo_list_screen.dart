import 'package:flutter/material.dart';
import 'package:notekeeper/database/database_helper.dart';
import 'package:notekeeper/models/task_model.dart';
import 'package:notekeeper/screens/add_task.dart';
import 'package:animate_do/animate_do.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  bool checkBox = false;
  var _totalTask = 0;

  Future<List<Task>> _taskList;
  var _list;

  @override
  void initState() {
    super.initState();
    _updateTaskList();
  }

//update task
  _updateTaskList() async {
    // Future<List<Task>> taskListFuture = DatabaseHelper.instance.getTaskList();
    // taskListFuture.then((task) {
    //   setState(() {
    //     this._taskList = task;
    //     this._totalTask = task.length;
    //     print(task.length);
    //   });

    setState(() {
      _taskList = DatabaseHelper.instance.getTaskList();
    });
  }

  _up() async {
    setState(() async {
      _list = await DatabaseHelper.instance.getTaskList();
    });
    print(_list);
  }

  Widget _buildTask(Task row) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(15), topLeft: Radius.circular(15)),
          child: ListTile(
            leading: Icon(Icons.dashboard),
            title: Text(
              row.title,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  decoration: row.status == 1
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
              textScaleFactor: 1.15,
            ),
            subtitle: Text(
              row.description,
              style: TextStyle(
                  decoration: row.status == 1
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
            ),
            trailing: Checkbox(
              onChanged: (value) {
                setState(() {
                  row.status = value ? 1 : 0;
                  DatabaseHelper.instance.updateTask(row);
                  _updateTaskList();
                });
              },
              activeColor: Theme.of(context).primaryColor,
              value: row.status == 1 ? true : false,
            ),
            tileColor: Colors.grey.shade200,
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => AddTaskScreen(row: row))),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(Icons.add),
          onPressed: (() async {
            // print("Total : $_totalTask");
            // print(_taskList);
            print(await DatabaseHelper.instance.totalRows());
            // print(await DatabaseHelper.instance.getTaskMapList());
            print(await DatabaseHelper.instance.getTaskList());
            // print("my function");
            // print(_up());
            // Navigator.push(
            //     context, MaterialPageRoute(builder: (_) => AddTaskScreen()));
            // print(await DatabaseHelper.instance.insertTask(Task(
            //     title: "shopping",
            //     description: "asdf",
            //     date: DateTime.now(),
            //     priority: "low",
            //     status: 1)));
          }),
          splashColor: Theme.of(context).primaryColorLight,
          tooltip: "Add new task",
        ),
        //future builder
        body: FutureBuilder(
          future: DatabaseHelper.instance.getTaskList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (!snapshot.hasData) {
                return Text('no data');
              } else {
                return Text('data present');
              }
            }
            if (snapshot.hasError) print('${snapshot.error}');

            final int completedTaskCount = snapshot.data
                .where((Task task) => task.status == 1)
                .toList()
                .length;

            return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 80.0),
              itemCount: snapshot.data.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 40.0, horizontal: 40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeInLeft(
                          child: Text(
                            "My Tasks",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 45.0),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          '$completedTaskCount Of $_totalTask',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w500),
                          textScaleFactor: 1.5,
                        ),
                      ],
                    ),
                  );
                }

                return _buildTask(snapshot.data[index - 1]);
              },
            );
          },
        ));
  }
}
