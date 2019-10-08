import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:random_run/theme.dart' as T;

class Picker extends StatefulWidget {
  @override
  _PickerState createState() => _PickerState();
}

class _PickerState extends State<Picker> {
  int _wholeNumberValue = 1;
  int _decimalValue = 0;
  NumberPicker _wholeNumberPicker;
  NumberPicker _decimalNumberPicker;

  static Color brightPink = T.RandomRunColors.brightPink;
  static Color lighterPink = T.RandomRunColors.lighterPink;

  Widget _dot = Padding(
    padding: EdgeInsets.only(
      top: T.Spacing.small,
    ),
    child: Container(
      width: 6.0,
      height: 6.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: brightPink,
      ),
    ),
  );

  BoxDecoration _boxOutline = BoxDecoration(
    border: Border.all(
      width: 2,
      color: brightPink,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(T.Spacing.micro),
    ),
    color: T.RandomRunColors.grayPink,
  );

  TextStyle _highlightedStyle = TextStyle(
    fontSize: T.FontSize.large,
    fontWeight: FontWeight.w400,
  );

  TextStyle _notHighlightedStyle = TextStyle(
    color: lighterPink,
    fontSize: T.FontSize.medium,
    fontWeight: FontWeight.w100,
  );

  @override
  Widget build(BuildContext context) {
    _initializePickers();
    final theme = Theme.of(context);
    return Column(
      children: <Widget>[
        Container(
          width: T.Spacing.xxlarge,
          height: T.Spacing.xlarge,
          decoration: _boxOutline,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Theme(
                data: theme.copyWith(
                  accentColor: brightPink,
                  textTheme: theme.textTheme.copyWith(
                    headline: _highlightedStyle,
                    body1: _notHighlightedStyle,
                  ),
                ),
                child: _wholeNumberPicker,
              ),
              _dot,
              Theme(
                data: theme.copyWith(
                  accentColor: brightPink,
                  textTheme: theme.textTheme.copyWith(
                    headline: _highlightedStyle,
                    body1: _notHighlightedStyle,
                  ),
                ),
                child: _decimalNumberPicker,
              )
            ],
          ),
        ),
      ],
    );
  }

  void _initializePickers() {
    _wholeNumberPicker = NumberPicker.integer(
      initialValue: _wholeNumberValue,
      minValue: 0,
      maxValue: 100,
      onChanged: (value) => setState(() => _wholeNumberValue = value),
    );
    _decimalNumberPicker = NumberPicker.integer(
      initialValue: _decimalValue,
      minValue: 0,
      maxValue: 9,
      step: 1,
      onChanged: (value) => setState(() => _decimalValue = value),
    );
  }
}
