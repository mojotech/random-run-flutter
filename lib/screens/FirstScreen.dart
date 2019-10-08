import 'package:flutter/material.dart';
import 'package:random_run/theme.dart' as T;

import 'package:random_run/widgets/Picker.dart';
import 'package:random_run/widgets/Dropdown.dart';
import 'package:random_run/widgets/NextButton.dart';

class FirstScreen extends StatelessWidget {
  static Color brightPink = T.RandomRunColors.brightPink;

  final TextStyle _howFarStyle = TextStyle(
    fontSize: T.FontSize.small,
    fontWeight: FontWeight.w500,
    color: brightPink,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: T.appBar,
        backgroundColor: brightPink,
      ),
      body: Center(
        child: Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: T.Spacing.medium,
                bottom: T.Spacing.medium,
              ),
              child: Text(
                'How far would you like to run?',
                style: _howFarStyle,
              ),
            ),
            Picker(),
            Dropdown(),
            Container(
              padding: EdgeInsets.only(
                top: T.Spacing.large,
              ),
              child: NextButton(),
            ),
          ],
        ),
      ),
    );
  }
}
