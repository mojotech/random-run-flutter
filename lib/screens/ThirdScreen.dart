import 'package:flutter/material.dart';
import 'package:random_run/theme.dart' as T;

class ThirdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: T.appBar,
        backgroundColor: T.RandomRunColors.brightPink,
      ),
      body: Center(
        child: Text(
          'Placeholder third screen.',
        ),
      ),
    );
  }
}
