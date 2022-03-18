import 'package:flutter/material.dart';
import 'package:flutterfire_auth/authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User user;

  @override
  void initState() {
    super.initState();
    user = context.read<AuthenticationService>().getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.indigoAccent,
          title: const Text(
            'Flutter Firebase Auth',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  // TODO: Implement Sign Out
                  context.read<AuthenticationService>().signOut();
                })
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              // 4
              user != null ? user.email : "No User Found",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ));
  }
}

 
