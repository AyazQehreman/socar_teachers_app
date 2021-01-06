import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:testing_everything/models/my_user.dart';
import 'package:google_sign_in/google_sign_in.dart';


class AuthenticationService
{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  static String userName;
  static String email;
  static User googleSignedUser;



  Future <MyUser> simpleSingIn ({String email, String password}) async
  {
    try{
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;

      return MyUser.fromFirebase(user);

    } on FirebaseAuthException  catch (e)
    {
      debugPrint(e.toString());
      return null;
    }
  }

  Future <MyUser> register ({String email, String password}) async
  {
    try{
      UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;

      return MyUser.fromFirebase(user);

    } on FirebaseAuthException  catch (e)
    {
      debugPrint(e.toString());
      return null;
    }
  }

  Future signOut() async
  {
    await _firebaseAuth.signOut();
    _googleSignIn.disconnect();
  }

  Stream<User> get authStageChanges => _firebaseAuth.authStateChanges();

  Stream<MyUser> get currentUser
  {
    return _firebaseAuth.authStateChanges().map((User user) => user != null ? MyUser.fromFirebase(user) : null );
  }

  Future<void> googleSignIn() async
  {
    try {
      await _googleSignIn.signIn();

      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      UserCredential authResult = await _firebaseAuth.signInWithCredential(credential);
      User _user = authResult.user;
      assert(!_user.isAnonymous);
      assert(await _user.getIdToken() != null);
      //Google ile qeydiyytatdan kecen istifadecini gotur
      googleSignedUser = _firebaseAuth.currentUser;
      assert(_user.uid == googleSignedUser.uid);

      userName = _user.displayName.toString();
      email = _user.email.toString();


    } catch (error) {
      print(error);
    }
  }

  String getName()
  {
    return userName;
  }

  String getEmail()
  {
    return email;
  }

}





