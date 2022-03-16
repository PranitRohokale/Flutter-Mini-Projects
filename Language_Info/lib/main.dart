import 'package:flutter/material.dart';
import 'package:lang_info/grid.dart';
import 'package:lang_info/stack.dart';

void main(List<String> args) {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Atateful App Widget",
      // home: favouriteCity(),
      home: StackScreen(),
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        accentColor: Colors.purple,
        // brightness: Brightness.dark
      )));
}

class SIApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIAppState();
  }
}

class _SIAppState extends State<SIApp> {
  int _index = 0;

  var _margin = 5.5;
  TextEditingController prin = TextEditingController();
  TextEditingController term = TextEditingController();
  TextEditingController roi = TextEditingController();

  double _ans = 0.0;
  var _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Align(
          alignment: Alignment.center,
          child: Text(
            "Simple interest calculator",
            textAlign: TextAlign.center,
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.info_outline_rounded),
              label: "info",
              backgroundColor: Colors.white),
        ],
        currentIndex: _index,
        onTap: (index) {
          setState(() {
            this._index = index;
          });
        },
        backgroundColor: Theme.of(context).primaryColorDark,
        unselectedItemColor: Colors.white,
        selectedFontSize: 14.0,
        selectedItemColor: Colors.black12,
      ),

      body: Form(
        key: _formkey,
        child: Container(
          height: 1000.0,
          color: Colors.amberAccent,
          child: ListView(
            children: [
              // image
              Padding(
                padding: EdgeInsets.all(_margin),
                child: Image.network(
                  "https://picsum.photos/200/200",
                ),
              ),

              //inputs
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(_margin),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: prin,
                    validator: (String value) {
                      if (value.isEmpty) return "Enter the principal..";
                    },
                    decoration: InputDecoration(
                        hintText: "Enter principle",
                        labelText: "Principle",
                        errorStyle:
                            TextStyle(fontSize: 15.0, letterSpacing: 1.3),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                  ),
                ),
              ),

              //input second
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(_margin),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: roi,
                  validator: (String value) {
                    if (value.isEmpty) return "Enter the rate of interest..";
                  },
                  decoration: InputDecoration(
                      labelText: "Rate of interest",
                      hintText: "Enter rate of interest ...",
                      hintMaxLines: 2,
                      errorStyle: TextStyle(fontSize: 15.0, letterSpacing: 1.3),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                ),
              )),

              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(_margin),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: term,
                        validator: (String value) {
                          if (value.isEmpty) return "Enter the term..";
                        },
                        decoration: InputDecoration(
                            hintText: "Enter term",
                            labelText: "Term",
                            errorStyle:
                                TextStyle(fontSize: 15.0, letterSpacing: 1.3),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(_margin))),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(_margin),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Enter principle",
                          labelText: "ruppes",
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  Expanded(
                      child: RaisedButton(
                    padding: EdgeInsets.only(top: 12, bottom: 12),
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      "calculate",
                      textScaleFactor: 1.5,
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      setState(() {
                        if (_formkey.currentState.validate())
                          _ans = _calculateSI();
                      });
                    },
                  )),
                  Expanded(
                      child: RaisedButton(
                          padding: EdgeInsets.only(top: 12, bottom: 12),
                          color: Theme.of(context).accentColor,
                          child: Text(
                            "Reset",
                            textScaleFactor: 1.5,
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            _reset();
                          })),
                ],
              ),
              Expanded(
                child: Padding(
                    padding: EdgeInsets.all(_margin * 5),
                    child: Text(
                      _ans.toString(),
                      textScaleFactor: 1.8,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _calculateSI() {
    double principal = double.parse(prin.text);
    double rate = double.parse(roi.text);
    double _term = double.parse(term.text);

    return principal + (principal + rate + _term) / 100;
  }

  void _reset() {
    prin.text = "";
    roi.text = "";
    term.text = "";

    setState(() {
      this._ans = 0.0;
    });
  }
}

class favouriteCity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FavouriteCity();
  }
}

class _FavouriteCity extends State<favouriteCity> {
  String city = "";
  final bgcolor = const Color(0xffE5D68A);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("StatefulWidget"),
      ),
      body: Container(
          padding: EdgeInsets.all(15.5),
          color: bgcolor,
          child: Column(
            children: [
              Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "you typed : " + city,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )),
              Expanded(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "you typed : " + city,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )),
            ],
          )),
    );
  }
}
