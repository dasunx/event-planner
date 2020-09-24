import 'package:event_planner/classes/Event.dart';
import 'package:flutter/material.dart';

class AddToDo extends StatefulWidget {
  static const String id = 'add_todo';
  @override
  _AddToDoState createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  Event event;

  @override
  Widget build(BuildContext context) {
    event = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Todo',
        ),
      ),
      body: Container(
        child: Center(
          child: Text(
            event.title,
          ),
        ),
      ),
    );
  }
}
