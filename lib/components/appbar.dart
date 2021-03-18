import 'package:flutter/material.dart';

class FlutteryAppBar extends StatefulWidget implements PreferredSizeWidget {
  FlutteryAppBar({Key key, @required this.title}) : super(key: key);

  final String title;

  @override
  Size get preferredSize => Size.fromHeight(50.0);

  @override
  _FlutterAppBarState createState() => _FlutterAppBarState();
}

class _FlutterAppBarState extends State<FlutteryAppBar> {
  int _counter = 0;
  final List<Color> palette = [
    Colors.green,
    Colors.blue,
    Colors.black,
    Colors.yellow
  ];
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _incrementCounter,
      child: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        backgroundColor: palette[_counter % palette.length],
        title: Text(widget.title),
      ),
    );
  }
}
