import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planner/classes/Budget.dart';
import 'package:event_planner/classes/Event.dart';

import 'package:event_planner/classes/Guest.dart';
import 'package:event_planner/classes/RouteArguments.dart';
import 'package:event_planner/classes/ShoppingList.dart';
import 'package:event_planner/classes/ToDoList.dart';
import 'package:event_planner/components/EmptyList.dart';
import 'package:event_planner/components/EventList.dart';
import 'package:event_planner/components/MainDrawer.dart';
import 'package:event_planner/components/SearchBar.dart';
import 'package:event_planner/constants.dart';
import 'package:event_planner/screens/event/add_event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChooseEvent extends StatefulWidget {
  static const String id = 'choose_event';
  @override
  _ChooseEventState createState() => _ChooseEventState();
}

final _firestore = FirebaseFirestore.instance;
User loggedInUser;
final _auth = FirebaseAuth.instance;

class _ChooseEventState extends State<ChooseEvent> {
  RouteArguments args;
  TextEditingController myCon = TextEditingController();
  FocusNode myFocusNode;
  bool conditionx = false;
  var eventList = List<Event>();
  var items = List<Event>();
  var i = 0;

  void getData() async {
    _firestore
        .collection('events')
        .where('userId', isEqualTo: loggedInUser.uid)
        .snapshots()
        .listen((event) {
      eventList.clear();
      event.docs.forEach((element) {
        List<Guest> guests = new List<Guest>();
        List<ToDoList> todos = new List<ToDoList>();
        List<ShoppingList> shoppingList = new List<ShoppingList>();
        element.data()['guests'].forEach((e) {
          Guest tempGuest =
              new Guest(e['email'], e['name'], e['gender'], e['note']);
          guests.add(tempGuest);
        });
        element.data()['todoList'].forEach((e) {
          ToDoList tempTodo =
              new ToDoList(e['title'], e['completed'], e['details']);
          todos.add(tempTodo);
        });
        element.data()['shoppingList'].forEach((e) {
          ShoppingList sList = new ShoppingList(
              e['name'], e['qty'], e['price'], e['details'], e['purchased']);
          shoppingList.add(sList);
        });
        Map<String, dynamic> budgetElement = element.data()['budget'];
        Budget tempBudget;
        if (budgetElement != null) {
          tempBudget = new Budget(budgetElement['budget'],
              budgetElement['paidAmount'], budgetElement['note']);
        }
        print(budgetElement);

        Event ev = new Event(
            element.data()['title'],
            element.data()['location'],
            element.data()['startDate'].toDate(),
            DateTime(2020, 11, 02),
            tempBudget,
            loggedInUser.uid,
            guests,
            shoppingList,
            todos);

        ev.id = element.id;

        eventList.add(ev);
      });
      if (mounted) {
        items.clear();
        items.addAll(eventList);
        items.sort((a, b) => a.startDate.compareTo(b.startDate));
      }
    });
  }

  @override
  void initState() {
    getCurrentUser();
    getData();
    if (eventList.length > 0) {
      conditionx = true;
    }
    myFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
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
    args = ModalRoute.of(context).settings.arguments;
    setState(() {
      conditionx = eventList.length >= 0 ? true : false;
    });
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          args.subTitle,
        ),
      ),
      drawer: MainDrawer(
        id: args.routeScreen,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Visibility(
            visible: conditionx,
            child: Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Search Event",
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
          ),
          Expanded(
            flex: 8,
            child: StreamBuilder<QuerySnapshot>(
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
                        title: "No Events yet!",
                        image: "images/noevent.png",
                        onPress: () {
                          Navigator.popAndPushNamed(context, AddEvent.id);
                        },
                        buttonText: "Add Event",
                      ),
                    ],
                  );
                }

                FocusNode myFocusNode = new FocusNode();

                return Column(
                  children: [
                    Expanded(
                      flex: 8,
                      child: Container(
                        child: new ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (BuildContext context, int index) =>
                                buildEventCard(context, index, items,
                                    args.routeScreen, myFocusNode)),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
