import 'package:event_planner/components/MainDrawer.dart';
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
    );
  }
}
