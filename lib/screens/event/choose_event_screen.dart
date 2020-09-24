import 'package:event_planner/classes/Event.dart';
import 'package:event_planner/classes/EventBrain.dart';
import 'package:event_planner/classes/Guest.dart';
import 'package:event_planner/classes/RouteArguments.dart';
import 'package:event_planner/components/EventList.dart';
import 'package:event_planner/components/MainDrawer.dart';
import 'package:event_planner/components/SearchBar.dart';
import 'package:event_planner/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChooseEvent extends StatefulWidget {
  static const String id = 'choose_event';
  @override
  _ChooseEventState createState() => _ChooseEventState();
}

class _ChooseEventState extends State<ChooseEvent> {
  RouteArguments args;
  TextEditingController myCon = TextEditingController();
  FocusNode myFocusNode;
  final EventBrain eb = EventBrain();
  var eventList;
  var items = List<Event>();

  @override
  void initState() {
    eventList = eb.eventList;
    items.addAll(eventList);
    myFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
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
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          args.subTitle,
        ),
      ),
      drawer: MainDrawer(),
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
                        "Select event to ${args.subTitle}",
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
                        buildEventCard(context, index, items, args.routeScreen,
                            myFocusNode)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
