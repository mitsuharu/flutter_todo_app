import 'package:flutter/material.dart';
import 'constants.dart';
import 'todo_model.dart';
import 'todo_detail_widget.dart';


abstract class TodoListViewCallbacks {
  void describe();
  void describeWithEmphasis() {
    print('========');
    describe();
    print('========');
  }
}

class TodoListView extends StatefulWidget{

  String title = "title";

  TodoListView({Key key, this.title}) : super(key: key);

  @override
  TodoListViewState createState() => TodoListViewState();
}

class TodoListViewState extends State<TodoListView>  {

  List<Todo> todoList = <Todo>[];

  @override
  void initState() {
    super.initState();

    Todo.allTodo().then((temps){
      if (temps != null) {
        setState(() {
          todoList = temps;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    print("[build]");

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
      body: this.todoListView(null),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            addTodo();
          }),
    );
  }

  ListView todoListView(Todo nextTodo){

    var length = todoList.length;
    print("[todoListView] $length");

    if (length == 0){
      return ListView();
    }
    
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {

        var todo = todoList[index];
        var title = todo.title;
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
      itemCount: todoList.length,
    );
  }


  void addTodo() async{
    print("[addTodo]");

    var todoDetail = TodoDetailWidget();

    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => todoDetail),
    ).then((response){
      if (response != null
          && response is TodoDetail
          && response.mode == TodoDetailMode.add){
        response.todo.save();
        setState(() {
          todoList.add(response.todo);
        });
      }
    });
  }

  void editTodo(Todo todo, int index) async{
    print("[editTodo] $index");

    var todoDetail = TodoDetailWidget(todo: todo);

    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => todoDetail),
    ).then((response){
      if (response != null && response is TodoDetail){
        if (response.mode == TodoDetailMode.update){
          response.todo.save();
          setState(() {
            todoList.replaceRange(index, index+1, [response.todo]);
          });
        }else if (response.mode == TodoDetailMode.delete){
          response.todo.delete();
          setState(() {
            todoList.removeAt(index);
          });
        }
      }
    });
  }



}
