import 'package:flutter/material.dart';
import 'package:random_run/theme.dart' as T;

class NextButton extends StatelessWidget {
  final bool _disabled;

  NextButton({@required bool disabled}) : _disabled = disabled;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      padding: EdgeInsets.only(
        top: T.Spacing.small,
        bottom: T.Spacing.small,
        left: T.Spacing.mediumLarge,
        right: T.Spacing.mediumLarge,
      ),
      child: RaisedButton(
        child: Text(
          'Next',
          style: TextStyle(
            fontSize: T.FontSize.small,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        color: _disabled
            ? T.RandomRunColors.disabled
            : T.RandomRunColors.brightPink,
        onPressed: () {
          // Navigate to the second screen using a named route.
          return _disabled ? null : Navigator.pushNamed(context, '/second');
        },
      ),
    );
  }
}
