import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planner/classes/RouteArguments.dart';
import 'package:event_planner/components/MainDrawer.dart';
import 'package:event_planner/constants.dart';
import 'package:event_planner/screens/add_event.dart';
import 'package:event_planner/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final _firestore = FirebaseFirestore.instance;
User loggedInUser;

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    getCurrentUser();

    super.initState();
  }

  @override
  void dispose() {
    loggedInUser = null;
    super.dispose();
  }

  void getCurrentUser() async {
    try {
      var user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(user.email);
      }
    } catch (e) {
      print('error $e');
    }
  }

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
          'My Page!- ${loggedInUser.email} ',
        ),
      ),
      drawer: MainDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _firestore.collection("events").doc(loggedInUser.uid).set({
            "eventname": "Birthday",
          }).then((value) => print('scc'));
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
