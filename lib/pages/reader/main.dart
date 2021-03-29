import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:my_app/components/appbar.dart';
import 'package:my_app/pages/home/HomeModel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:my_app/pages/home/utils.dart' as utils;

import 'ReaderModel.dart';

class ReaderRoute extends StatefulWidget {
  ReaderRoute(this.sd) : super();

  final StoryDetail sd;

  @override
  _ReaderRoute createState() {
    return _ReaderRoute(sd);
  }
}

class _ReaderRoute extends State<ReaderRoute> {
  StoryDetail sd;
  String htmlContent = '';
  List<Comment> comments = [];

  _ReaderRoute(this.sd) : super();

  void fetchReaderStory() async {
    final detail = this.sd;

    if (detail.url != '') {
      final d = await utils.fetchHtml(detail.url).onError((error, stackTrace) {
        debugPrint(error.toString());
        return '';
      });
      setState(() {
        htmlContent = d;
      });
    }

    for (int i in detail.kids.sublist(0, min(detail.kids.length, 20))) {
      final c = await utils.fetchStoryComments(i);
      setState(() {
        comments.add(c);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchReaderStory();
  }

  @override
  Widget build(BuildContext context) {
    final title = Text(
      this.sd.title,
      style: Theme.of(context).textTheme.headline6,
    );
    final url = this.sd.url;
    final by = this.sd.by;
    final byline = Text(by + ' - ' + Uri.parse(url).host);

    return Scaffold(
      appBar: FlutteryAppBar(title: 'Reader Page'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => launch(url),
                  child: Container(
                    color: Colors.amber,
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        title,
                        byline,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 400,
            // margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: WebView(initialUrl: url),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Comments(this.comments),
            ),
          )
        ],
      ),
    );
  }
}

class Comments extends StatelessWidget {
  final List<Comment> comments;
  Comments(this.comments) : super();

  Widget build(BuildContext context) {
    List<Widget> ans = [];
    for (Comment c in this.comments) {
      ans.add(Container(
          margin: EdgeInsets.all(5),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Text(
                  c.by,
                  style: Theme.of(context).textTheme.caption,
                ),
                Text(
                  ' - ',
                  style: Theme.of(context).textTheme.caption,
                ),
                Text(
                  DateTime.fromMillisecondsSinceEpoch(c.time * 1000).toString(),
                  style: Theme.of(context).textTheme.caption,
                ),
              ]),
              Html(data: c.text),
            ],
          )));
    }
    return Column(children: ans);
  }
}
