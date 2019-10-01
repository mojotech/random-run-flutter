import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class Picker extends StatefulWidget {
  @override
  _PickerState createState() => new _PickerState();
}

class _PickerState extends State<Picker> {
  int _currentWholeValue = 1;
  NumberPicker wholeNumberPicker;

  @override
  Widget build(BuildContext context) {
    _initializePickers();
    return new Center(
      child: new Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            wholeNumberPicker,
          ],
        ),
      ),
    );
  }

  void _initializePickers() {
    wholeNumberPicker = new NumberPicker.integer(
      initialValue: _currentWholeValue,
      minValue: 0,
      maxValue: 100,
      onChanged: (value) => setState(() => _currentWholeValue = value),
    );
  }
}
