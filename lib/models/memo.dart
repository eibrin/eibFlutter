// models 패키지에 model 작성:  1. DB 프로퍼티 포함 클래스 작성 -> 2. 프로퍼티를 포함하는 생성자를 만듦 -> 3. Map<String, dynamic>반환하는 toMap()작성
// DB 처리시 주의사항 : 모든 작업은 비동기 async로 처리
class Memo {
  String? title;
  String? content;
  bool? active;
  int? id;

  Memo({this.title, this.content, this.active = false, this.id});

  Map<String, dynamic> toMap() {
    return {
      'id': (id == 0)
          ? null
          : id, //  new record에 null을 입력시 DB가 자동으로 증가로직을 사용하여 새 값을 할당함
      'title': title,
      'content': content,
      'active': (active == true) ? 1 : 0,
    };
  }
}

class Dog {
  final int id;
  final String name;
  final int age;

  const Dog({
    required this.id,
    required this.name,
    required this.age,
  });
}
