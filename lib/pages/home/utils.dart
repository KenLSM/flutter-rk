import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_app/pages/home/HomeModel.dart';

Future<List<int>> fetchStory() async {
  final resp = await http
      .get(Uri.https('hacker-news.firebaseio.com', 'v0/beststories.json'));

  var l = jsonDecode(resp.body);
  return List<int>.from(l).sublist(0, 20);
}

Future<StoryDetail> fetchStoryDetail(int id) async {
  final resp = await http
      .get(Uri.https('hacker-news.firebaseio.com', 'v0/item/$id/.json'));

  var l = jsonDecode(resp.body);
  // debugPrint(l.toString());
  return StoryDetail.fromJson(l);
}
