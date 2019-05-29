// Flutter code sample for material.AppBar.actions.1

// This sample shows adding an action to an [AppBar] that opens a shopping cart.

import 'package:flutter/material.dart';
import 'constants.dart';
import 'todo_model.dart';
import 'todo_list_widget.dart';

void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = Constant.appTitle;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: TodoListView(title: _title,),
    );
  }
}
