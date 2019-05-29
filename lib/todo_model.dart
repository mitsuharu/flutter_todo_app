import 'package:meta/meta.dart';

/*
 Dart2のコンストラクタがわからなかったのでメモ · Androg
 https://kwmt27.net/2018/06/23/dartlang-class/
 */

/// TODOデータのモデル
class Todo{
  String name;
  DateTime updatedAt;

  String get dateString{
    if (this.updatedAt == null){
      this.updatedAt = DateTime.now();
    }
    return this.updatedAt.toIso8601String();
  }

  Todo({this.name, this.updatedAt});

  Todo.anonymous() {
    this.name = "anonymous";
    this.updatedAt = DateTime.now();
  }

  @override
  String toString() {
    return "name: $name, date: $updatedAt";
  }

  static List<Todo> samples(){
    List<Todo> temps = <Todo>[];
    temps.add(Todo(name: "掃除"));
    temps.add(Todo(name: "買い物"));
    temps.add(Todo(name: "食事"));
    return temps;
  }

}