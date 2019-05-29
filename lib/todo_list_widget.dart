import 'package:flutter/material.dart';
import 'constants.dart';
import 'todo_model.dart';
import 'todo_detail_widget.dart';


class TodoListView extends StatefulWidget{

  String title = "title";

  var items = <Widget>[];
  var todoList = Todo.samples(); // <Todo>[];


  TodoListView({Key key, this.title}) : super(key: key);

  @override
  TodoListViewState createState() => TodoListViewState();
}

class TodoListViewState extends State<TodoListView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            tooltip: 'Open shopping cart',
            onPressed: () {
              // Implement navigation to shopping cart page here...
              print('Shopping cart opened.');
            },
          ),
        ],
      ),
      body: this.todoListView(null),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            addTodo();
          }),
    );
  }

  ListView todoListView(Todo nextTodo){
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {

        var todo = widget.todoList[index];
        var title = todo.name;
        var date = todo.dateString;

        return Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.black38),
              ),
            ),
            child: ListTile(
              leading: const Icon(Icons.android),
              title: Text(title),
              subtitle: Text(date),
              onTap: () => editTodo(todo, index),
            ));
      },
      itemCount: widget.todoList.length,
    );
  }


  void addTodo() async{
    print("[addTodo]");

    var todoDetail = TodoDetailWidget();

    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => todoDetail),
    ).then((todo){
      if (todo != null && todo is Todo){
        setState(() {
          widget.todoList.add(todo);
        });
      }
    });
  }

  void editTodo(Todo todo, int index) async{
    print("[editTodo] $index");

    var todoDetail = TodoDetailWidget();
    todoDetail.todo = todo;

    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => todoDetail),
    ).then((nextTodo){
      if (nextTodo != null && nextTodo is Todo){
        setState(() {
          widget.todoList.replaceRange(index, index+1, [nextTodo]);
        });
      }
    });
  }

}
