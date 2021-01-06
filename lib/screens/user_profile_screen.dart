import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testing_everything/screens/home_screen.dart';
import 'package:testing_everything/services/authentication_service.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  User currentUser = AuthenticationService.googleSignedUser;

  String userName;

  @override
  // ignore: must_call_super
  void initState()
  {
    userName = HomeScreen.empty().getName;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.orange,
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 10, top: 50, bottom: 10)),
            CircleAvatar(
                radius: MediaQuery.of(context).size.width / 4 ,
                backgroundImage: AssetImage("assets/images/user_image.jpg")),
            SizedBox(
              height: 20,
            ),
            Text(
              userName,
              style: TextStyle(
                fontSize: 30.0,
                //fontWeight: FontWeight.bold,
                color: Colors.black
              ),
            ),
          ],
        ),
      ),
    );
  }


}
