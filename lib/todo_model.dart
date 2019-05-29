import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:io';

import 'util.dart';

/*
 Dart2のコンストラクタがわからなかったのでメモ · Androg
 https://kwmt27.net/2018/06/23/dartlang-class/

 FlutterでローカルDBを扱う方法 - Iganinのブログ
https://iganin.hatenablog.com/entry/2019/01/09/010804

Datatypes In SQLite Version 3
https://www.sqlite.org/datatype3.html

sqflite | Flutter Package
https://pub.dev/packages/sqflite

 */

final String tableTodo = 'todo';
final String columnId = '_id';
final String columnTitle = 'title';
final String columnDone = 'done';
final String columnCreatedAt = 'created_at';
final String columnUpdatedAt = 'updated_at';
final colums = [columnId, columnDone, columnTitle, columnCreatedAt, columnUpdatedAt];


/// TODOデータのモデル
class Todo{

  int id;
  String title;
  bool done;
  DateTime createdAt;
  DateTime updatedAt;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTitle: title,
      columnDone: done == true ? 1 : 0,
      columnCreatedAt: Util.date2string(createdAt),
      columnUpdatedAt: Util.date2string(updatedAt),
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  String get dateString{
    if (this.updatedAt == null){
      this.updatedAt = DateTime.now();
    }
    return this.updatedAt.toIso8601String();
  }

  Todo({this.title, this.updatedAt});

  Todo.a() {
    this.title = "";
    this.done = false;
    this.createdAt = DateTime.now();
    this.updatedAt = this.createdAt;
  }

  Todo.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    title = map[columnTitle];
    done = map[columnDone] == 1;
    createdAt = Util.string2date(map[columnCreatedAt]);
    updatedAt = Util.string2date(map[columnUpdatedAt]);
  }

  @override
  String toString() {
    return "{title: $title, date: $updatedAt}";
  }


  static Future<List<Todo>> allTodo() async {
    try{
      TodoProvider p = TodoProvider();
      await p.open();
      var temps = await p.getAllTodo();
      return temps;
    }catch (e) {
      print("[allTodo] $e");
      return <Todo>[];
    }
  }

  static List<Todo> samples(){
    List<Todo> temps = <Todo>[];
    temps.add(Todo(title: "掃除"));
    temps.add(Todo(title: "買い物"));
    temps.add(Todo(title: "食事"));
    return temps;
  }


  Future save() async{
    try{
      TodoProvider p = TodoProvider();
      await p.open();

      var temp = await p.getTodo(this.id);
      if (temp == null){
        await p.insert(this);
      }else{
        await p.update(this);
      }
      p.close();

    }catch (e) {
      print("[save] $e");
    }

  }
}


class TodoProvider {
  Database db;

  Future<TodoProvider> open() async {
    print("[TodoProvider][open]");

    var dbPath = await getDatabasesPath();
    final path = join(dbPath, "sample.db");
    
    print("[open] $path");
    print("[open][0] $db");

    db = await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
create table $tableTodo ( 
  $columnId integer primary key autoincrement, 
  $columnTitle text not null,
  $columnDone integer not null,
  $columnCreatedAt text not null,
  $columnUpdatedAt text not null)
''');
        });

    print("[open][2] $db");
    return this;
  }

  Future<Todo> insert(Todo todo) async {
    todo.id = await db.insert(tableTodo, todo.toMap());

    var temp = todo.id;
    print("[insert] $temp");
    
    return todo;
  }

  Future<Todo> getTodo(int id) async {
    List<Map> maps = await db.query(tableTodo,
        columns: colums,
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Todo.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Todo>> getAllTodo() async {
    List<Map> maps = await db.query(
        tableTodo,
        columns: colums);
    if (maps.length > 0) {
      List<Todo> temps = <Todo>[];
      maps.forEach((m) {
        temps.add(Todo.fromMap(m));
      });
      return temps;
    }else{
      return null;
    }
  }

  Future<int> getTodoCount() async {
    List<Map> maps = await db.query(tableTodo,
        columns: colums);
    if (maps.length > 0) {
      return maps.length;
    }
    return 0;
  }

  Future<int> delete(int id) async {
    return await db.delete(tableTodo, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Todo todo) async {

    return await db.update(tableTodo, todo.toMap(),
        where: '$columnId = ?', whereArgs: [todo.id]);
  }

  Future close() async => db.close();
}
