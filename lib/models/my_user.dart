import 'package:firebase_auth/firebase_auth.dart';


class MyUser
{
  String id;
  String name;
  String email;

  MyUser.fromFirebase(User user)
  {
    id = user.uid;
    name = user.displayName.toString();
    email = user.email.toString();
  }
}