import 'package:flutter/material.dart';
import 'package:my_app/components/appbar.dart';
import 'package:my_app/pages/home/HomeModel.dart';
import 'package:my_app/pages/reader/main.dart';
import 'package:my_app/pages/home/utils.dart' as utils;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Fluttering Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Map<int, StoryDetail?> storyIds = {};
  final List<Color> palette = [
    Colors.green,
    Colors.blue,
    Colors.black,
    Colors.yellow
  ];

  void fetchStories() async {
    final ff = await utils.fetchStory();
    setState(() {
      storyIds.addEntries(ff.map((e) => MapEntry(e, null)));
    });

    for (final f in ff) {
      final detail = await utils.fetchStoryDetail(f);
      debugPrint(f.toString());
      setState(() {
        storyIds.update(f, (value) => detail);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchStories();
  }

  @override
  Widget build(BuildContext context) {
    final itemLength = storyIds.length;
    final _row = storyIds.values
        .whereType<StoryDetail>()
        .map((e) => Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Expanded(
                  child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.yellow,
                            width: 1.0,
                          ),
                        ),
                        color: Colors.black38,
                      ),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ReaderRoute(e.id);
                            }));
                          },
                          child: Text(e.title))))
            ]));
    return Scaffold(
      appBar: FlutteryAppBar(title: 'Home Page'),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Stories available: $itemLength',
              style: Theme.of(context).textTheme.headline6,
            ),
            ..._row
          ],
        ),
      ),
    );
  }
}
