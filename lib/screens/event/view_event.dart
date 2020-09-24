import 'package:flutter/material.dart';

class ViewEvent extends StatefulWidget {
  static const String id = 'view_event';
  @override
  _ViewEventState createState() => _ViewEventState();
}

class _ViewEventState extends State<ViewEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Event"),
      ),
      body: Container(
        color: Colors.white,
        child: Text("f"),
      ),
    );
  }
}
