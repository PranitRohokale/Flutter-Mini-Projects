import 'package:flutter/material.dart';

class Grid extends StatefulWidget {
  @override
  _GridState createState() => _GridState();
}

class _GridState extends State<Grid> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.amberAccent,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
        child: GridView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 23,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, crossAxisSpacing: 5.0, mainAxisSpacing: 5.0),
            itemBuilder: (context, index) {
              return Container(
                height: 30.0,
                color: Colors.amber,
                width: 0.0,
                child: Center(
                  child: Text(
                    index.toString(),
                    textScaleFactor: 1.6,
                  ),
                ),
              );
            }),
      ),
    );
  }
}
