class Comment {
  final String by;
  final int id;
  final int parent;
  final String text;
  final int time;
  final String type;

  Comment({
    required this.by,
    required this.id,
    required this.parent,
    required this.text,
    required this.time,
    required this.type,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      by: json['by'],
      id: json['id'],
      parent: json['parent'],
      text: json['text'],
      time: json['time'],
      type: json['type'],
    );
  }
}
