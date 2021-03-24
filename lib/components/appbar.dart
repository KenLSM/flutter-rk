import 'package:flutter/material.dart';

class FlutteryAppBar extends StatefulWidget implements PreferredSizeWidget {
  FlutteryAppBar({Key? key, required this.title, withBack}) : super(key: key);

  final String title;
  final bool withBack = false;

  @override
  Size get preferredSize => Size.fromHeight(50.0);

  @override
  _FlutterAppBarState createState() => _FlutterAppBarState(withBack: withBack);
}

class _FlutterAppBarState extends State<FlutteryAppBar> {
  _FlutterAppBarState({required this.withBack});

  final bool withBack;

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
    final leadingComponent = this.withBack
        ? GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          )
        : null;
    return GestureDetector(
      onTap: _incrementCounter,
      child: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          backgroundColor: palette[_counter % palette.length],
          title: Text(widget.title),
          leading: leadingComponent),
    );
  }
}
