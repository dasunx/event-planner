import 'package:event_planner/classes/Event.dart';
import 'package:event_planner/components/EmptyList.dart';
import 'package:event_planner/constants.dart';
import 'package:flutter/material.dart';

class ViewToDo extends StatefulWidget {
  static const String id = 'view_todo';
  @override
  _ViewToDoState createState() => _ViewToDoState();
}

class _ViewToDoState extends State<ViewToDo> {
  Event event;
  @override
  Widget build(BuildContext context) {
    event = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${event.title}',
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  "View TODO list",
                  style: kTitleTextStyle,
                ),
              ),
            ),
            EmptyList(
              onPress: () {
                print("view Todo Screen");
              },
              buttonText: "Add To-Do",
              title: "It's Lonely here",
            )
          ],
        ),
      ),
    );
  }
}
