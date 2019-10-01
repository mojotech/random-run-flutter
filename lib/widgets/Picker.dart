import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class Picker extends StatefulWidget {
  @override
  _PickerState createState() => new _PickerState();
}

class _PickerState extends State<Picker> {
  int _currentWholeValue = 1;
  int _currentDecimalValue = 1;
  NumberPicker wholeNumberPicker;
  NumberPicker decimalNumberPicker;

  @override
  Widget build(BuildContext context) {
    _initializePickers();
    return new Center(
      child: new Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                wholeNumberPicker,
                decimalNumberPicker,
              ],
            ),
            new Text(
                'Number picker value: $_currentWholeValue.$_currentDecimalValue')
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
    decimalNumberPicker = new NumberPicker.integer(
      initialValue: _currentDecimalValue,
      minValue: 0,
      maxValue: 9,
      onChanged: (value) => setState(() => _currentDecimalValue = value),
    );
  }
}
