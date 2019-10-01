import 'package:flutter/material.dart';

class Picker extends StatefulWidget {
  @override
  _PickerState createState() => new _PickerState();
}

class _PickerState extends State<Picker> {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Text("Picker"), //TODO: add number picker here
          ],
        ),
      ),
    );
  }
}
