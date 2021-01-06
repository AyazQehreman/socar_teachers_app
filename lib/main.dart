import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:testing_everything/services/authentication_service.dart';
import 'screens/home_screen.dart';
import 'screens/authentication_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(TeachersApp());
}

class TeachersApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
            create: (_) => AuthenticationService()),
        StreamProvider(
            create: (context) =>
                context.read<AuthenticationService>().authStageChanges),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Teachers App',
        theme: ThemeData(
          primarySwatch: Colors.lightBlue,
        ),
        home: AnimatedSplashScreen(
            splash: Image(
              image: AssetImage("assets/images/socar_logo_full.png"),
            ),
            duration: 1000,
            splashTransition: SplashTransition.fadeTransition,
            animationDuration: Duration(milliseconds: 1500),
            nextScreen: AuthenticationWrapper()), //AuthenticationWrapper()),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return HomeScreen(firebaseUser);
    } else {
      return AuthenticationScreen();
    }
  }
}

