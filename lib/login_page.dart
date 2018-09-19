import 'dart:async';
import 'dart:io';
import 'main.dart';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email;
  String _password;

  void _signoutUser() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<String> _testSignInWithGoogle() async {
    try {
      
      var loginUser = await _googleSignIn.signIn();
      if(loginUser != null){
        GoogleSignInAccount googleUser = loginUser;
      GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      FirebaseUser user = await _auth.signInWithGoogle(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      assert(user.email != null);
      assert(user.displayName != null);
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);
      print(_auth.currentUser().toString());
      Navigator.of(context).pushReplacementNamed('/home');
      return 'signInWithGoogle succeeded: $user';
      }
      return '';
    } catch (e) {
      print(e.toString());
      return '';
    }
  }

  void validateAndSave() {}

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Bicycle Login')),
      body: new Container(
          padding: EdgeInsets.only(top: 20.0, left: 8.0, right: 8.0),
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/images/login-bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: new Center(
            child: new Form(
                child: new Column(children: <Widget>[
              new Text(
                'FUNBike',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 45.0,
                ),
              ),
              new Text(
                '註冊會員',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
              ),
              new TextFormField(
                decoration: new InputDecoration(labelText: 'Email'),
              ),
              new TextFormField(
                decoration: new InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              new RaisedButton(
                child: Row(
                  // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    new Icon(
                      FontAwesomeIcons.envelope,
                      color: Colors.black,
                    ),
                    new Text(
                      "    Sign in with Email",
                      style: new TextStyle(color: Colors.black),
                    )
                  ],
                ),
                color: new Color.fromRGBO(999, 999, 999, 0.2),
                onPressed: validateAndSave,
              ),
              new RaisedButton(
                child: Row(
                  // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    new Icon(
                      FontAwesomeIcons.facebookF,
                      color: Colors.white,
                    ),
                    new Text(
                      "    Login with Facebook",
                      style: new TextStyle(color: Colors.white),
                    )
                  ],
                ),
                color: new Color.fromRGBO(59, 89, 152, 1.0),
                onPressed: validateAndSave,
              ),
              new MaterialButton(
                  child: Row(
                    // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      new Icon(
                        FontAwesomeIcons.google,
                        color: Colors.white,
                      ),
                      new Text(
                        "    Sign in with Google+",
                        style: new TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  color: new Color.fromRGBO(211, 72, 54, 1.0),
                  onPressed: () {
                    _testSignInWithGoogle();
                  }
              ),
              new MaterialButton(
                  child: Row(
                    // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      new Icon(
                        FontAwesomeIcons.google,
                        color: Colors.white,
                      ),
                      new Text(
                        "    Sign in with Google+",
                        style: new TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  color: new Color.fromRGBO(211, 72, 54, 1.0),
                  onPressed: () {
                    _signoutUser();
                  }
              ),
            ])),
          )),
    );
  }
}
