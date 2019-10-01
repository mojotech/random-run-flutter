import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class Picker extends StatefulWidget {
  @override
  _PickerState createState() => new _PickerState();
}

class _PickerState extends State<Picker> {
  int _wholeNumberValue = 1;
  int _firstDecimalValue = 0;
  int _secondDecimalValue = 0;
  NumberPicker wholeNumberPicker;
  NumberPicker firstDecimalNumberPicker;
  NumberPicker secondDecimalNumberPicker;

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
                firstDecimalNumberPicker,
                secondDecimalNumberPicker
              ],
            ),
            new Text(
                'Number picker value: $_wholeNumberValue.$_firstDecimalValue$_secondDecimalValue')
          ],
        ),
      ),
    );
  }

  void _initializePickers() {
    wholeNumberPicker = new NumberPicker.integer(
      initialValue: _wholeNumberValue,
      minValue: 0,
      maxValue: 100,
      onChanged: (value) => setState(() => _wholeNumberValue = value),
    );
    firstDecimalNumberPicker = new NumberPicker.integer(
      initialValue: _firstDecimalValue,
      minValue: 0,
      maxValue: 9,
      onChanged: (value) => setState(() => _firstDecimalValue = value),
    );
    secondDecimalNumberPicker = new NumberPicker.integer(
      initialValue: _secondDecimalValue,
      minValue: 0,
      maxValue: 9,
      onChanged: (value) => setState(() => _secondDecimalValue = value),
    );
  }
}
