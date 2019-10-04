import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Random Run'),
      ),
      body: Center(child: new Text('Placeholder Second screen')),
    );
  }
}
