import 'package:flutter/material.dart';
import 'package:my_app/components/appbar.dart';

class ReaderRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: FlutteryAppBar(title: 'Reader Page'),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Text('This is comments page')]),
        ));
  }
}
