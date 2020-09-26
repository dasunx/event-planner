import 'package:event_planner/classes/Event.dart';
import 'package:event_planner/components/IconContent.dart';
import 'package:event_planner/components/button.dart';
import 'package:event_planner/constants.dart';
import 'package:event_planner/screens/guest/view_guests.dart';
import 'package:event_planner/screens/shoppinglist/view_shoppinglsit.dart';
import 'package:event_planner/screens/todolist/add_todo.dart';
import 'package:event_planner/screens/todolist/view_todo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewEvent extends StatefulWidget {
  static const String id = 'view_event';
  @override
  _ViewEventState createState() => _ViewEventState();
}

class _ViewEventState extends State<ViewEvent> {
  Event event;

  @override
  Widget build(BuildContext context) {
    event = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("View Event"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        eventDetails("Event"),
                        Spacer(),
                        eventDetails(
                          event.title,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        eventDetails(
                          "Date",
                        ),
                        Spacer(),
                        eventDetails(
                            "${DateFormat.yMMMd().format(event.startDate).toString()}"),
                      ],
                    ),
                    Row(
                      children: [
                        eventDetails(
                          "Venue",
                        ),
                        Spacer(),
                        eventDetails(event.location),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: IconContent(
                          onPress: () {
                            Navigator.pushNamed(context, ViewToDo.id,
                                arguments: event);
                          },
                          icon: Icons.done,
                          label: "To Do",
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 2,
                        child: IconContent(
                          onPress: () {
                            Navigator.pushNamed(context, ViewGuests.id,
                                arguments: event);
                          },
                          icon: Icons.person,
                          label: "Guest",
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: IconContent(
                          onPress: () {
                            Navigator.pushNamed(context, ViewShoppingList.id,
                                arguments: event);
                          },
                          icon: Icons.list,
                          label: "Shopping List",
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 2,
                        child: IconContent(
                          icon: Icons.attach_money,
                          label: "Budget",
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  button(
                    onPress: () {
                      print("dashboard");
                    },
                    title: "Dashboard",
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Text eventDetails(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 18, color: Colors.black),
    );
  }
}
