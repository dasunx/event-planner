import 'package:event_planner/classes/Event.dart';
import 'package:event_planner/classes/RouteArguments.dart';
import 'package:event_planner/components/AlertDialog.dart';
import 'package:event_planner/components/IconContent.dart';
import 'package:event_planner/components/WideStyledBtn.dart';
import 'package:event_planner/constants.dart';
import 'package:event_planner/functions/FirebaseHelper.dart';
import 'package:event_planner/screens/dashboard/dashboard.dart';
import 'package:event_planner/screens/budget/view_budget.dart';
import 'package:event_planner/screens/event/update_event.dart';
import 'package:event_planner/screens/guest/view_guests.dart';
import 'package:event_planner/screens/home_screen.dart';
import 'package:event_planner/screens/shoppinglist/view_shoppinglsit.dart';
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
          title: Text("View Event", style: TextStyle(color: Colors.white)),
          iconTheme: new IconThemeData(color: Colors.white)),
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
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
                      Divider(),
                      Row(
                        children: [
                          eventDetails(
                            "Date and time",
                          ),
                          Spacer(),
                          eventDetails(
                              "${DateFormat.yMMMd().format(event.startDate).toString()} ${DateFormat.Hm().format(event.startDate).toString()}"),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          eventDetails(
                            "Actions",
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              showAlertDialog(
                                  context,
                                  "Delete ${event.title} ?",
                                  "Are you sure, do you need to delete this event?",
                                  "Delete",
                                  "No", () {
                                FirebaseHelper fl = new FirebaseHelper();
                                fl.removeEvent(event.id);
                                Navigator.popAndPushNamed(
                                    context, HomeScreen.id);
                              }, () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              });
                            },
                            icon: Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.popAndPushNamed(context, UpdateEvent.id,
                                  arguments: event);
                            },
                            icon: Icon(Icons.edit),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
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
                          label: "Shopping",
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
                            Navigator.pushNamed(context, ViewBudget.id,
                                arguments: event);
                          },
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
              flex: 3,
              child: Row(
                children: [
                  Expanded(
                    child: WideStyledBtn(
                      onPress: () {
                        Navigator.pushNamed(context, Dashboard.id,
                            arguments: event);
                      },
                      icon: Icons.dashboard,
                      label: "Dashboard",
                      color: Colors.white,
                    ),
                  )
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
