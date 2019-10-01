import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class Picker extends StatefulWidget {
  @override
  _PickerState createState() => new _PickerState();
}

class _PickerState extends State<Picker> {
  int _wholeNumberValue = 1;
  int _decimalValue = 0;
  NumberPicker _wholeNumberPicker;
  NumberPicker _decimalNumberPicker;

  @override
  Widget build(BuildContext context) {
    _initializePickers();
    return new Center(
      child: new Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_wholeNumberPicker, _decimalNumberPicker],
            ),
            new Text('Number picker value: $_wholeNumberValue.$_decimalValue')
          ],
        ),
      ),
    );
  }

  void _initializePickers() {
    _wholeNumberPicker = new NumberPicker.integer(
      initialValue: _wholeNumberValue,
      minValue: 0,
      maxValue: 100,
      onChanged: (value) => setState(() => _wholeNumberValue = value),
    );
    _decimalNumberPicker = new NumberPicker.integer(
      initialValue: _decimalValue,
      minValue: 0,
      maxValue: 75,
      step: 25,
      onChanged: (value) => setState(() => _decimalValue = value),
    );
  }
}
