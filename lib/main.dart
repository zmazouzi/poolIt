import 'package:flutter/material.dart';
import './ui/login.dart';
import './ui/home.dart';

void main() {
  runApp(MaterialApp(
    title: 'Named Routes Demo',
    // Start the app with the "/" named route. In our case, the app will start
    // on the FirstScreen Widget
    initialRoute: '/login',
    routes: {
      // When we navigate to the "/" route, build the FirstScreen Widget
      '/': (context) => Home(),
      // When we navigate to the "/second" route, build the SecondScreen Widget
      '/login': (context) => Login(),
    },
  ));
}


