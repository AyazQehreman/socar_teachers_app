import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:testing_everything/screens/schedule_screen.dart';
import 'package:testing_everything/screens/settings_screen.dart';
import 'package:testing_everything/screens/user_profile_screen.dart';
import 'package:testing_everything/services/authentication_service.dart';

 String name = "Ayaz";
 User user;

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget
{

  HomeScreen.empty();


  HomeScreen(User firebaseUer)
  {
    user = firebaseUer;
    name = user.displayName.toString();
  }



  String get getName
  {
    return name;
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
{
  int _selectedIndex = 0;

  List<Widget> _navigationBarItems = <Widget>
  [
    ScheduleScreen(),
    UserProfileScreen(),
    SettingsScreen(),
  ];


  void _onItemTap(int index)
  {
    setState(() {
      _selectedIndex = index;
    });

    pr();

  }

  void pr()
  {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    print(" **** " + w.toString() + " **** " + h.toString());
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (_selectedIndex != 1) ? AppBar(
        title: Text(name),
        actions: [
          IconButton(icon: Icon(Icons.logout, color: Colors.white,), onPressed: () => AuthenticationService()..signOut()),
        ],
      ) : null,
      body: _navigationBarItems.elementAt(_selectedIndex)
      ,
      bottomNavigationBar: CurvedNavigationBar(
        items: [
          IconButton(icon: Icon(Icons.info, size: 30, color: Colors.white), onPressed: null),
          IconButton(icon: Icon(Icons.person, size: 30,  color: Colors.white), onPressed: null),
          IconButton(icon: Icon(Icons.settings, size: 30,  color: Colors.white), onPressed: null),
        ],
        index : _selectedIndex,
        onTap: _onItemTap,
        backgroundColor: onTabSelectedColor(_selectedIndex),
        buttonBackgroundColor: Colors.purple,
        color: Colors.green,
        height: 50.0,
        animationDuration: Duration(milliseconds: 500),
      ),
    );
  }

  // ignore: missing_return
  Color onTabSelectedColor(int index)
  {
    if(index == 0)
      {
        return Colors.lightBlueAccent;
      } else if(index == 1){
      return Colors.orange;
    } else if(index == 2)
      {
        return Colors.red;
      }

    pr();
  }
}


