import 'package:flutter/material.dart';

import 'package:random_run/widgets/Picker.dart';
import 'package:random_run/widgets/Dropdown.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Random Run'),
      ),
      body: new Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('How far would you like to run?'),
          Picker(),
          Dropdown(),
          new RaisedButton(
            child: Text('Next'),
            onPressed: () {
              // Navigate to the second screen using a named route.
              Navigator.pushNamed(context, '/second');
            },
          ),
        ],
      ),
    );
  }
}
