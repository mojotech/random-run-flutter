import 'package:flutter/material.dart';
import 'theme.dart' as Theme;

import 'package:random_run/screens/FirstScreen.dart';
import 'package:random_run/screens/SecondScreen.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Run',
      color: Theme.RandomRunColors.brightPink,
      theme: Theme.randomRunThemeData,
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => FirstScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => SecondScreen(),
      },
    );
  }
}
