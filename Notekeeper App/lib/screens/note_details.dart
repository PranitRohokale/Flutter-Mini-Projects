
import 'package:flutter/material.dart';

class NoteDetails extends StatefulWidget {
  String _appBarTitle = "";
  NoteDetails(this._appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return _NoteDetailsState(this._appBarTitle);
  }
}

class _NoteDetailsState extends State<NoteDetails> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String _appBarTitle = "";
  double _btnOpacity = 0.0;
  _NoteDetailsState(this._appBarTitle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this._appBarTitle),
      ),
      body: Padding(
        padding: EdgeInsets.all(5.5),
        child: Container(
          child: ListView(
            children: [
              //title
              Padding(
                padding: EdgeInsets.only(
                    right: 5.5, left: 5.5, top: 10.0, bottom: 10.0),
                child: TextField(
                  controller: titleController,
                  onChanged: (value) {
                    if (value.length > 0) {
                      setState(() {
                        this._btnOpacity = 1.0;
                      });
                    } else {
                      setState(() {
                        this._btnOpacity = 0;
                      });
                    }
                    print(value);
                  },
                  decoration: InputDecoration(
                      labelText: "Title",
                      hintText: "Enter the Title..",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                ),
              ),

              //description
              Padding(
                padding: EdgeInsets.only(
                    right: 5.5, left: 5.5, top: 10.0, bottom: 10.0),
                child: TextField(
                  controller: descriptionController,
                  onChanged: (value) {
                    print(value);
                  },
                  decoration: InputDecoration(
                      labelText: "Description",
                      hintText: "Enter the description..",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                ),
              ),

              //row
              Padding(
                padding: EdgeInsets.all(5.5),
                child: Row(
                  children: [
                    Expanded(
                        child: Opacity(
                      opacity: _btnOpacity,
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorLight,
                        child: Text(
                          "save".toUpperCase(),
                          textAlign: TextAlign.center,
                          textScaleFactor: 1.4,
                        ),
                        onPressed: () {
                          setState(() {
                            print("Save btn");
                          });
                        },
                      ),
                    )),
                    Container(
                      width: 5.5,
                    ),
                    Expanded(
                        child: RaisedButton(
                      elevation: 2,
                      child: Text(
                        "Delete".toUpperCase(),
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.4,
                      ),
                      onPressed: () {
                        setState(() {
                          print("delete");
                        });
                      },
                    ))
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
