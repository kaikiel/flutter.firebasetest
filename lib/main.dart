import 'package:flutter/material.dart';
import 'login_page.dart';
import 'home.dart';

void main(){
  runApp(new MyApp());
}
  
class MyApp extends StatelessWidget {

  Widget _defaultHome(){
    Widget _defaultHome = new LoginPage();
    return _defaultHome;
  }
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bicycle Login',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _defaultHome(),
      routes: <String, WidgetBuilder>{
      // Set routes for using the Navigator.
      '/home': (BuildContext context) => new HomePage(),
      '/login': (BuildContext context) => new LoginPage()
      },
    );
  }
}