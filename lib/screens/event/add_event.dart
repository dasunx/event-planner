import 'package:event_planner/classes/RouteArguments.dart';
import 'package:flutter/material.dart';

class AddEvent extends StatefulWidget {
  static const String id = 'add_event';
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Event',
        ),
      ),
      body: Center(
        child: Text(
          'Add Even',
        ),
      ),
    );
  }
}
