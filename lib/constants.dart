// 定数群をまとめたクラス
class Constant{

  // アプリのタイトル
  static const String appTitle = "Todo App";
  static const String addTodoViewTitle = "Todoを追加する";

  static var detail = Detail();
  static var alert = Alert();
}

class Detail{
  final String addTitle = "Todoを追加する";
  final String editTitle = "Todoを編集する";
}

class Alert{
  final String cancel = "Cancel";
  final String ok = "OK";

  final String titleDeleteTodo = "削除の確認";
  final String messageDeleteTodo = "このTodoを削除しますか？";

}


enum TodoDetailMode{
  update,
  add,
  delete,
}