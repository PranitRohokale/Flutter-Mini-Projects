import 'package:flutter/material.dart';
import 'package:flutterfire_auth/authentication_service.dart';
import 'package:flutterfire_auth/helper.dart';
// Import the provider plugin
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.indigoAccent,
        title: const Text(
          'Sign up',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.all(5.0)
                  ,child: TextFormField(
                    controller: emailTextController,
                    enableInteractiveSelection: true,
                    decoration: InputDecoration(
                      
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(3.0)))
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  height: 40,
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 6.0,
                      primary: Colors.indigoAccent, // background
                      onPrimary: Colors.white, // foreground
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: const BorderSide(color: Colors.indigoAccent)),
                    ),
                    onPressed: () async {
                      final result = await context
                          .read<AuthenticationService>()
                          .signUp(
                              email: emailTextController.text.trim(),
                              password: passwordTextController.text.trim());

                      showSnackbar(context, result);

                      if (result == "Signed up") {
                        Navigator.popUntil(
                            context, ModalRoute.withName("/auth"));
                      }
                    },
                    child: Text('Create Account'),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account? "),
                      Text(
                        'Sign in.',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
