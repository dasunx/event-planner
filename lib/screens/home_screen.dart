import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planner/classes/Event.dart';
import 'package:event_planner/classes/EventBrain.dart';
import 'package:event_planner/classes/Guest.dart';
import 'package:event_planner/classes/RouteArguments.dart';
import 'package:event_planner/components/EventList.dart';
import 'package:event_planner/components/MainDrawer.dart';
import 'package:event_planner/components/SearchBar.dart';
import 'package:event_planner/constants.dart';
import 'package:event_planner/screens/event/add_event.dart';
import 'package:event_planner/screens/event/view_event.dart';
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
  TextEditingController myCon = TextEditingController();
  final _auth = FirebaseAuth.instance;
  FocusNode myFocusNode;
  final EventBrain eb = EventBrain();
  var eventList;
  var items = List<Event>();
  var i = 0;

  void printData() async {
    _firestore
        .collection('events')
        .where('id', isEqualTo: loggedInUser.uid)
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        element.data()['guests'].forEach((e) {
          setState(() {
            i++;
          });
          print(i);
        });
      });
    });
    // CollectionReference ref = _firestore.collection('events');
    // QuerySnapshot eventQuery =
    //     await ref.where("id", isEqualTo: loggedInUser.uid).get();
    // eventQuery.docs.forEach((element) {
    //   print(loggedInUser.uid);
    //   element.data()['guests'].forEach((item) => {print(item['title'])});
    // });
  }

  @override
  void initState() {
    getCurrentUser();
    printData();
    eventList = eb.eventList;
    items.addAll(eventList);
    myFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
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

  void filterSearchResults(String query) {
    List<Event> searchList = List<Event>();
    searchList.addAll(eventList);
    if (query.isNotEmpty) {
      List<Event> dummyList = List<Event>();
      searchList.forEach((item) {
        if (item.title.toLowerCase().contains(query)) {
          dummyList.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyList);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(eventList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          'Event Planner',
        ),
      ),
      body: new GestureDetector(
        onTap: () {
          myFocusNode.unfocus();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Search Event $i",
                        style: kTitleTextStyle,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5, left: 40, right: 40),
                      child:
                          buildSearch(myFocusNode, "Search an event", (value) {
                        filterSearchResults(value);
                      }, myCon),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                child: new ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) =>
                        buildEventCard(
                            context, index, items, ViewEvent.id, myFocusNode)),
              ),
            ),
          ],
        ),
      ),
      drawer: MainDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddEvent.id);
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
