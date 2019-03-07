import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_kit/home.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_kit/user.model.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  User userInfo;

  Future<FirebaseUser> _signIn() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication gSA = await googleSignInAccount.authentication;

    FirebaseUser user = await _auth.signInWithGoogle(
        idToken: gSA.idToken, accessToken: gSA.accessToken);

    Route route = MaterialPageRoute(
        builder: (context) => Home(User(
            id: user.uid,
            name: user.displayName,
            photoUrl: user.photoUrl,
            email: user.email)));
    Navigator.push(context, route);

    return user;
  }

  void _signOut() {
    googleSignIn.signOut();
    print("Signing out ...");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Demo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RaisedButton(
              onPressed: () => _signIn()
                  .then((FirebaseUser user) {})
                  .catchError((e) => print(e)),
              child: Text("Sign In"),
              color: Colors.green,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
            ),
            RaisedButton(
              onPressed: _signOut,
              child: Text("SignOut"),
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
