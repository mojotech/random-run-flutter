import 'package:flutter/material.dart';
import 'package:random_run/theme.dart' as T;

class LoadingState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(
          top: T.Spacing.xlarge,
        ),
        color: T.RandomRunColors.grayPink,
        child: Flex(
          direction: Axis.vertical,
          children: <Widget>[
            CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(
                T.RandomRunColors.brightPink,
              ),
              strokeWidth: 5.0,
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: T.Spacing.small,
              ),
            ),
            Text(
              'Loading...',
              style: TextStyle(
                color: T.RandomRunColors.brightPink,
                fontSize: T.FontSize.large,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
