import 'package:flutter/material.dart';
import 'package:lang_info/database/database_helper.dart';
import 'package:lang_info/dismissible.dart';
import 'package:lang_info/grid.dart';
import 'package:sqflite/sqflite.dart';

import 'model/level.dart';

class StackScreen extends StatefulWidget {
  @override
  _StackScreenState createState() => _StackScreenState();
}

class _StackScreenState extends State<StackScreen> {
  var _list =
      List<String>.generate(202, (index) => "The item number is $index");
  final List<Color> _colors = [
    Colors.red,
    Colors.green,
    Colors.deepPurple,
    Colors.deepOrange,
    Colors.indigo,
    Colors.yellow,
    Colors.brown,
    Colors.pink,
  ];
  int _colorIndex = 0;
  var angle = 0;

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Leval> levalList;

  updateLeval() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Leval>> noteListFuture = databaseHelper.getLevalList();
      noteListFuture.then((noteList) {
        setState(() {
          this.levalList = noteList;
          print(noteList.length);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (levalList == null) {
      levalList = List<Leval>();
      print("111");
      updateLeval();
    }

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("object");
            setState(() {
              this.angle = this.angle == 25 ? 0 : 25;
            });
          },
          child: Icon(Icons.add),
        ),
        body: Stack(
            overflow: Overflow.visible,
            // fit: StackFit.expand,
            alignment: Alignment.topCenter,
            children: [
              Container(
                width: size.width,
                height: size.height * 0.25,
                color: Colors.redAccent,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 65.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            // onDoubleTap: () => Navigator.push(context,MaterialPageRoute(builder: (_)=> Grid() )),
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => Dismissiblee())),
                            child: Icon(
                              Icons.arrow_back_ios_outlined,
                              size: 40,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 90.0, top: 5.0),
                            child: Text(
                              "Levels",
                              textAlign: TextAlign.center,
                              textScaleFactor: 1.3,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.0),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                // top: size.height * 0.05,
                child: RotationTransition(
                  turns: AlwaysStoppedAnimation(this.angle / 360),
                  child: ListView(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.only(right: 15.0, left: 15.0, top: 75.0),
                        width: size.width * 0.85,
                        height: size.height * 0.75,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(23),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5.0,
                                color: Colors.black12,
                                spreadRadius: 3.0,
                                offset: Offset.zero,
                              )
                            ]),

                        //list
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 15.0),
                          child: GridView.builder(
                              itemCount: 280,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 10.0,
                                      crossAxisCount: 4,
                                      mainAxisSpacing: 10.0),
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  child: Container(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        index.toString(),
                                        textScaleFactor: 1.5,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15.0),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        // borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.blueGrey.shade100,
                                            blurRadius: 3.0,
                                          )
                                        ],
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Colors.red,
                                                width: 2.0,
                                                style: BorderStyle.solid))),
                                  ),
                                  onTap: () => print("$index"),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ]));
  }

  // Widget _buildList(int index) {
  //   final str = _list[index];
  //   return Dismissible(
  //     key: Key(_list[index]),
  //     onDismissed: (direction) {
  //       setState(() {
  //         _list.removeAt(index);
  //       });

  //       //show msg
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text("item deleted at indexed $index")));
  //     },
  //     child: ListTile(
  //       title: Text(str),
  //       subtitle: Text(
  //         str.toLowerCase(),
  //         style: TextStyle(color: Colors.grey),
  //       ),
  //       leading: CircularProgressIndicator.adaptive(
  //         value: 1,
  //         strokeWidth: 4.0,
  //         valueColor: new AlwaysStoppedAnimation<Color>(
  //             _colors[(++_colorIndex) % _colors.length]),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildList(int index) {
    final str = _list[index];
    final thisColor = _colors[(++_colorIndex) % _colors.length];
    return Dismissible(
      key: Key(_list[index]),
      onDismissed: (direction) {
        setState(() {
          _list.removeAt(index);
        });

        //show msg
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("item deleted at indexed $index")));
      },
      background: _sideBackground(
          "Edit", Icons.edit, thisColor, MainAxisAlignment.start),
      secondaryBackground: _sideBackground(
          "Delete", Icons.delete, Colors.red, MainAxisAlignment.end),
      child: ListTile(
        title: Text(str),
        subtitle: Text(
          str.toLowerCase(),
          style: TextStyle(color: Colors.grey),
        ),
        leading: CircularProgressIndicator.adaptive(
          value: 1,
          strokeWidth: 4.0,
          backgroundColor: Colors.deepOrange,
          valueColor: new AlwaysStoppedAnimation<Color>(thisColor),
        ),
        trailing: Container(
            color: thisColor,
            child: SizedBox(
              height: double.infinity,
              width: 5.0,
            )),
        onTap: () => _showAlertBox(str, thisColor),
      ),
    );
  }

  Widget _sideBackground(
      String action, IconData icon, Color color, MainAxisAlignment axis) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: double.infinity,
        color: color,
        child: Row(
          mainAxisAlignment: axis,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.0,
              width: 10.0,
            ),
            Icon(
              icon,
              size: 30.0,
              color: Colors.white,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              action,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 22.0),
            ),
            SizedBox(
              height: 20.0,
              width: 10.0,
            )
          ],
        ),
      ),
    );
  }

  _showAlertBox(String str, Color myColor) {
    final dialog = AlertDialog(
      title: Text(
        str.toUpperCase(),
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 30.0, color: myColor),
      ),
      elevation: 1,
      content: Text(
        str.toLowerCase(),
        style: TextStyle(color: Colors.grey),
      ),
      actions: [
        FlatButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
          },
          child: Text("Okay"),
          color: myColor,
        ),
      ],
    );

    showDialog(context: context, builder: (context) => dialog);
  }
}
