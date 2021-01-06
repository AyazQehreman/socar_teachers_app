import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing_everything/models/my_user.dart';
import 'package:testing_everything/screens/authentication_screen.dart';
import 'package:testing_everything/services/authentication_service.dart';

class RegistrationScreen extends StatelessWidget {

  AuthenticationService _authenticationService = AuthenticationService();


  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  TextEditingController _controllerPasswordAgain = TextEditingController();

  String email, password;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),

              SizedBox(
                height: 4,
              ),
              TextField(
                controller: _controllerEmail,
                decoration: InputDecoration(
                  labelText: 'email',
                  hintText: "email@mail.com",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              TextField(
                  controller: _controllerPassword,
                decoration: InputDecoration(
                  hintText: "şifrə",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(
                height: 4,
              ),
              TextField(
                  controller: _controllerPasswordAgain,
                decoration: InputDecoration(
                  hintText: "şifrə təkrarən",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(
                height: 30,
              ),
              RaisedButton(
                child: Text("Qeyd ol",
                style: TextStyle(
                  color: Colors.white,
                ),),
                color: Colors.blueAccent,
                onPressed: () async
                  {
                    email = _controllerEmail.text;
                    password = _controllerPassword.text;

                    MyUser user = await _authenticationService.register(email: email, password: _controllerPassword.text);

                    Navigator.push(context, MaterialPageRoute(builder: (context) => AuthenticationScreen()));

                    _controllerEmail.clear();
                    _controllerPassword.clear();
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }


  // register() async
  // {
  //   name = _controllerName.text;
  //   email = _controllerEmail.text;
  //   password = _controllerPassword.text;
  //
  //   MyUser user = await _authenticationService.register(email: email, password: _controllerPassword.text);
  //
  //   Navigator.push(context, MaterialPageRoute(builder: (context) => AuthenticationScreen()));
  //
  // }






}
