
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:testing_everything/models/my_user.dart';
import 'package:testing_everything/screens/registration_screen.dart';
import 'package:testing_everything/services/authentication_service.dart';

// ignore: must_be_immutable
class AuthenticationScreen extends StatelessWidget {
  AuthenticationService _authenticationService = AuthenticationService();

  String email;
  String password;

  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left : 10.0 , right: 10.0, top: 50.0, bottom: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.white,
                width: 100,
                  height: 100,
                  child: Image(image: AssetImage("assets/images/socar_logo_full.png"))),
              SizedBox(height: 25,),
              TextField(
                controller: _controllerEmail,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: "email@mail.com",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _controllerPassword,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                obscureText: true,
              ),
              Row( mainAxisAlignment : MainAxisAlignment.center,
                  children: [
                ButtonBar(children: [
                  RaisedButton(
                    child: Text("Daxil ol"),
                    color: Colors.blueAccent,
                    onPressed: () => onPressedLogin(),
                  ),
                  SizedBox(width: 4,),
                  RaisedButton(
                      child: Text("Google hesabından daxil ol"),
                      color: Colors.red,
                      onPressed: () => AuthenticationService()..googleSignIn() //onPressedRegister()
                  ),
                ]),
              ]),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Və ya", style: TextStyle(
                    fontSize: 16
                  ),),
                  FlatButton(
                      child: Text("Qeydiyyatdan keçin.",
                        style: TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),),
                      onPressed:  ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationScreen()));
                      }
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  void onPressedLogin() async {
    email = _controllerEmail.text;
    password = _controllerPassword.text;
    MyUser user = await _authenticationService.simpleSingIn(
        email: _controllerEmail.text, password: _controllerPassword.text);
    print(email + " /// " + password);
  }
}
