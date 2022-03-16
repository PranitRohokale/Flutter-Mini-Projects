import 'dart:math';

import 'package:flutter/material.dart';
import 'main.dart';

class Dismissiblee extends StatefulWidget {
  @override
  _DismissibleStatee createState() => _DismissibleStatee();
}

class _DismissibleStatee extends State<Dismissiblee> {
  final _list = List<String>.generate(20, (n) => "List item ${n}");
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("dismissible"),
      ),
      body: generateItemsList(),
    );
  }

  ListView generateItemsList() {
    return ListView.builder(
      itemCount: _list.length,
      itemBuilder: (context, index) {
        return _buildList(index);
      },
    );
  }

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
