import 'package:flutter/material.dart';
import 'constants.dart';
import 'todo_model.dart';

class TodoDetailWidget extends StatefulWidget{

  String title = Constant.detail.addTitle; //  addTodoViewTitle;

//  var items = <Widget>[];
//  var todoList = Todo.samples(); // <Todo>[];


  Todo todo;

  TodoDetailWidget({Key key, this.todo}) : super(key: key);

  @override
  TodoDetailState createState() => TodoDetailState();
}

class TodoDetailState extends State<TodoDetailWidget> {


  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    // todoデータの有無で追加か編集のタイトルを変える
    if (widget.todo == null){
      widget.title = Constant.detail.addTitle;
      widget.todo = Todo.a();
    }else{
      widget.title = Constant.detail.editTitle;
      textController.text = widget.todo.title;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.shopping_cart),
//            tooltip: 'Open shopping cart',
//            onPressed: () {
//              // Implement navigation to shopping cart page here...
//              print('Shopping cart opened.');
//            },
//          ),
//        ],
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

//  ListView todoListView(Todo nextTodo){
//    return ListView.builder(
//      itemBuilder: (BuildContext context, int index) {
//
//        var todo = widget.todoList[index];
//        var title = todo.name;
//        var date = todo.dateString;
//
//        return Container(
//            decoration: BoxDecoration(
//              border: Border(
//                bottom: BorderSide(color: Colors.black38),
//              ),
//            ),
//            child: ListTile(
//              leading: const Icon(Icons.android),
//              title: Text(title),
//              subtitle: Text(date),
//              onTap: () => {},
//            ));
//      },
//      itemCount: widget.todoList.length,
//    );
//  }


  void addTodo(){

    widget.todo.title = textController.text;

    Navigator.of(context).pop(widget.todo);

  }

}
