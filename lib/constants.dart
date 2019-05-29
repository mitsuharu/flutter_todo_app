// 定数群をまとめたクラス
class Constant{

  // アプリのタイトル
  static const String appTitle = "Todo App";


  static const String addTodoViewTitle = "Todoを追加する";


  static var detail = Detail();
}

class Detail{
  final String addTitle = "Todoを追加する";
  final String editTitle = "Todoを編集する";
}

enum TodoStatus{
  edit,
  add,
}