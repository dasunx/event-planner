import 'package:event_planner/classes/Event.dart';
import 'package:flutter/material.dart';

class AddGuest extends StatefulWidget {
  static const String id = 'add_guest';
  @override
  _AddGuestState createState() => _AddGuestState();
}

class _AddGuestState extends State<AddGuest> {
  Event event;
  @override
  Widget build(BuildContext context) {
    event = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add guests',
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
