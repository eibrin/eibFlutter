class Memo {
  String? title;
  String? content;
  bool? active;
  int? id;

  Memo({this.title, this.content, this.active = false, this.id});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'active': active,
    };
  }
}
