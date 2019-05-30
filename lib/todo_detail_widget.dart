import 'package:flutter/material.dart';
import 'constants.dart';
import 'todo_model.dart';


class TodoDetail{
  Todo todo;
  TodoDetailMode mode;
}

class TodoDetailWidget extends StatefulWidget{

  String title = Constant.detail.addTitle; //  addTodoViewTitle;
  Todo todo;

  TodoDetailWidget({Key key, this.todo}) : super(key: key);

  @override
  TodoDetailState createState() => TodoDetailState();
}

class TodoDetailState extends State<TodoDetailWidget> {

  TodoDetail model = TodoDetail();
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.todo == null){
      widget.title = Constant.detail.addTitle;
      model.todo = Todo.empty();
      model.mode = TodoDetailMode.add;
    }else{
      widget.title = Constant.detail.editTitle;
      textController.text = widget.todo.title;
      model.todo = widget.todo;
      model.mode = TodoDetailMode.update;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: appBarActions(),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: textController,
              decoration: InputDecoration(
                  labelText: "Todo Name",
                  hintText: "すること"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.done),
          onPressed: () {
            addTodo();
          }),
    );
  }

  // modeによって表示するactionを変更する
  List<Widget> appBarActions(){
    if (model.mode == TodoDetailMode.update){
      return <Widget>[
        IconButton(
          icon: Icon(Icons.delete),
          tooltip: 'delete todo',
          onPressed: () {
            print('delete todo');
            showDeleteAlert();
          },
        ),
      ];
    }else{
      return null;
    }
  }


  void showDeleteAlert(){
    showDialog(context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(Constant.alert.titleDeleteTodo),
          content: Text(Constant.alert.messageDeleteTodo),
          actions: <Widget>[
            FlatButton(
              child: Text(Constant.alert.cancel),
              onPressed: () => Navigator.pop<String>(context, Constant.alert.cancel),
            ),
            FlatButton(
              child: Text(Constant.alert.ok),
              onPressed: () => Navigator.pop<String>(context, Constant.alert.ok),
            )
          ],
        )
    ).then<void>((value){
      print(value);

      if (value == Constant.alert.ok){
        // 削除する
        model.mode = TodoDetailMode.delete;
        Navigator.of(context).pop(model);
      }

    });

  }

  void addTodo(){
    model.todo.title = textController.text;
    Navigator.of(context).pop(model);
  }

}
