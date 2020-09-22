import 'package:event_planner/classes/RouteArguments.dart';
import 'package:event_planner/components/MainDrawer.dart';
import 'package:event_planner/constants.dart';
import 'package:event_planner/screens/add_event.dart';
import 'package:event_planner/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Event Planner',
        ),
      ),
      body: Center(
        child: Text(
          'My Page!',
        ),
      ),
      drawer: MainDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            AddEvent.id,
          );
        },
        backgroundColor: kMainColor,
        elevation: 10,
        child: Icon(
          Icons.add,
          size: 34,
        ),
      ),
    );
  }
}
