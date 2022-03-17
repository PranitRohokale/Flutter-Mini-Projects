import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:notekeeper/database/database_helper.dart';
import 'package:notekeeper/models/task_model.dart';

class AddTaskScreen extends StatefulWidget {
  //constructor
  final Task row;
  AddTaskScreen({this.row});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
//formkey
  final formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  String _priority;
  DateTime _date = DateTime.now();

  final List<String> _priorities = ['low', 'Medium', 'High'];

//controller
  TextEditingController _dateController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  _datePicker() async {
    final DateTime date = await showDatePicker(
        context: context,
        initialDate: this._date,
        firstDate: DateTime(2020),
        lastDate: DateTime(210));

    if (date != null) {
      setState(() {
        _date = date;
      });
    }
    _dateController.text = "shgsh".toString();
  }

  _onSubmit()  {
    if (this.formKey.currentState.validate()) {
      formKey.currentState.save();
      print('$_title : $_description : $_date : $_priority');

      //insert the task to the database
      Task row = Task(
          title: this._title,
          description: this._description,
          date: this._date,
          priority: this._priority);

      if (widget.row == null) {
        row.status = 0;
           DatabaseHelper.instance.insertTask(row);
      } else {
        row.status = widget.row.status;
        DatabaseHelper.instance.updateTask(row);
      }

      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();

    if (widget.row != null) {
      this._title = widget.row.title;
      this._description = widget.row.description;
      // this._date = widget.row.date;
      this._priority = widget.row.priority;
    }

    _dateController.text = this._date.toString();
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 70.0, left: 10.0),
                child: GestureDetector(
                    child: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).primaryColorDark,
                      size: 30.0,
                    ),
                    onTap: () => Navigator.pop(context)),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 40.0),
                child: FadeInLeft(
                  duration: Duration(seconds: 1),
                  child: Text(
                    "Add Task",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 45.0),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Expanded(
                        child: TextFormField(
                          style: TextStyle(fontSize: 20.0),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.8)),
                              labelText: "Title",
                              labelStyle: TextStyle(
                                fontSize: 20.0,
                              ),
                              hintText: "Enter the Task Title",
                              hintStyle: TextStyle(fontSize: 20.0),
                              errorStyle: TextStyle(letterSpacing: 1.2)),
                          onSaved: (newValue) =>
                              this._title = newValue.trim().toString(),
                          initialValue: this._title,
                          validator: (value) {
                            if (value.trim().isEmpty) {
                              return "Enter the task Title";
                            }
                          },
                        ),
                      ),
                    ),

                    //second input
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: TextFormField(
                        style: TextStyle(fontSize: 20.0),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.8)),
                            labelText: "Description",
                            labelStyle: TextStyle(
                              fontSize: 20.0,
                            ),
                            hintText: "Enter the Task Description",
                            hintStyle: TextStyle(fontSize: 20.0),
                            errorStyle: TextStyle(letterSpacing: 1.2)),
                        onSaved: (newValue) =>
                            this._description = newValue.trim().toString(),
                        initialValue: this._description,
                        validator: (value) {
                          if (value.trim().isEmpty) {
                            return "Enter the task Description";
                          }
                        },
                      ),
                    ),

                    //third input
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: TextFormField(
                          style: TextStyle(fontSize: 20.0),
                          controller: _dateController,
                          onTap: _datePicker,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.8)),
                            labelText: "Date",
                            labelStyle: TextStyle(
                              fontSize: 20.0,
                            ),
                            hintText: "Enter the Task Title",
                            hintStyle: TextStyle(fontSize: 20.0),
                          ),
                          readOnly: true,
                        )),

                    //forth input
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: DropdownButtonFormField(
                        isDense: true,
                        icon: Icon(Icons.arrow_drop_down_circle_sharp),
                        iconSize: 25.0,
                        iconEnabledColor: Theme.of(context).primaryColorDark,
                        items: _priorities.map((String e) {
                          return DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 18.0),
                              ));
                        }).toList(),
                        style: TextStyle(fontSize: 20.0),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.8)),
                            labelText: "Priority",
                            labelStyle: TextStyle(
                              fontSize: 20.0,
                            ),
                            hintText: "Enter the Task Title",
                            hintStyle: TextStyle(fontSize: 20.0),
                            errorStyle: TextStyle(letterSpacing: 1.2)),
                        validator: (value) => this._priority == null
                            ? "Please Select the Priority"
                            : null,
                        onChanged: (value) {
                          setState(() {
                            this._priority = value;
                          });
                        },
                        value: _priority,
                      ),
                    ),

                    //btn
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 60.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0)),
                        child: SlideInUp(
                          delay: Duration(milliseconds: 5),
                          child: Container(
                              height: 60.0,
                              width: double.infinity,
                              color: Theme.of(context).primaryColorDark,
                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.circular(30.0),
                              // ),
                              child: FlatButton(
                                  onPressed: () => _onSubmit(),
                                  child: Text(
                                    "ADD",
                                    textScaleFactor: 2.0,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ))),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
