import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_app/pages/home/HomeModel.dart';
import 'package:my_app/pages/reader/ReaderModel.dart';

Future<List<int>> fetchStory() async {
  final resp = await http
      .get(Uri.https('hacker-news.firebaseio.com', 'v0/beststories.json'));

  var l = jsonDecode(resp.body);
  return List<int>.from(l).sublist(0, 20);
}

Future<List<int>> fetchTopStory() async {
  final resp = await http
      .get(Uri.https('hacker-news.firebaseio.com', 'v0/topstories.json'));

  var l = jsonDecode(resp.body);
  return List<int>.from(l).sublist(0, 20);
}

Future<StoryDetail> fetchStoryDetail(int id) async {
  final resp = await http
      .get(Uri.https('hacker-news.firebaseio.com', 'v0/item/$id/.json'));

  var l = jsonDecode(resp.body);
  return StoryDetail.fromJson(l);
}

Future<Comment> fetchStoryComments(int id) async {
  final resp = await http
      .get(Uri.https('hacker-news.firebaseio.com', 'v0/item/$id/.json'));

  var l = jsonDecode(resp.body);
  return Comment.fromJson(l);
}

Future<String> fetchHtml(String url) async {
  debugPrint(Uri.parse(url).toString());
  final resp = await http.get(Uri.parse(url));
  return resp.body;
}
