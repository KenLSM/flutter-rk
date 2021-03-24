import 'dart:collection';

import 'package:flutter/material.dart';

class StoryDetail {
  final String by;
  // final int decendants;
  final int id;
  final List<int> kids;
  final int score;
  final int time;
  final String title;
  final String type;
  final String url;

  StoryDetail({
    required this.by,
    required this.id,
    required this.kids,
    required this.score,
    required this.time,
    required this.title,
    required this.type,
    required this.url,
  });

  factory StoryDetail.fromJson(Map<String, dynamic> json) {
    return StoryDetail(
        by: json['by'],
        id: json['id'],
        kids: json['kids'],
        score: json['score'],
        time: json['time'],
        title: json['title'],
        type: json['type'],
        url: json['url']);
  }
}

class HomeModel extends ChangeNotifier {
  final List<int> _items = [];

  UnmodifiableListView<int> get items => UnmodifiableListView(_items);

  int get length => _items.length;

  void add(int item) {
    _items.add(item);

    notifyListeners();
  }

  void addAll(List<int> items) {
    _items.addAll(items);

    notifyListeners();
  }
}
