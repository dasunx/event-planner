import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planner/classes/Event.dart';
import 'package:event_planner/components/EmptyList.dart';
import 'package:event_planner/components/EventList.dart';
import 'package:event_planner/components/MainDrawer.dart';
import 'package:event_planner/screens/event/add_event.dart';
import 'package:event_planner/screens/guest/view_guests.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  static const String id = 'test';
  @override
  _TestState createState() => _TestState();
}

final _firestore = FirebaseFirestore.instance;
User loggedInUser;

class _TestState extends State<Test> {
  final _auth = FirebaseAuth.instance;
  var eventList = List<Event>();
  List<Event> items = new List<Event>();
  @override
  void initState() {
    getCurrentUser();

    super.initState();
  }

  void getCurrentUser() async {
    try {
      var user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Events",
        ),
      ),
      drawer: MainDrawer(),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('events')
            .where('userId', isEqualTo: loggedInUser.uid)
            .snapshots(),
        builder: (context, snapshot) {
          List<Text> titles = [];

          if (!snapshot.hasData || snapshot.data.docs.length <= 0) {
            return Column(
              children: [
                EmptyList(
                  title: "No one here yet!",
                  onPress: () {
                    Navigator.popAndPushNamed(context, AddEvent.id);
                  },
                  buttonText: "Add Guest",
                ),
              ],
            );
          }

          final messages = snapshot.data.docs;
          messages.forEach((element) {
            Event ev = new Event(
                element.data()['title'],
                element.data()['location'],
                element.data()['startDate'].toDate(),
                DateTime(2020, 11, 02),
                20330,
                loggedInUser.uid, [], [], []);
            ev.id = element.id;
            eventList.add(ev);
          });
          items.addAll(eventList);
          FocusNode myFocusNode = new FocusNode();

          return Column(
            children: [
              Expanded(
                flex: 8,
                child: Container(
                  child: new ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) =>
                          buildEventCard(context, index, items, ViewGuests.id,
                              myFocusNode)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
