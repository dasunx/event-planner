import 'package:event_planner/classes/Event.dart';
import 'package:event_planner/classes/EventBrain.dart';
import 'package:event_planner/classes/Guest.dart';
import 'package:event_planner/classes/RouteArguments.dart';
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
                      }),
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
                        buildEventCard(context, index)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEventCard(BuildContext context, int index) {
    final event = items[index];
    return GestureDetector(
      onTap: () {
        myFocusNode.unfocus();
        Navigator.pushNamed(context, args.routeScreen, arguments: event);
      },
      child: Container(
        margin: EdgeInsets.only(right: 6, top: 10),
        child: Card(
          elevation: 6,
          child: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.ideographic,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 6, right: 8.0, top: 4, bottom: 20),
                        child: Icon(Icons.event),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 6, right: 8.0, top: 4, bottom: 20),
                        child: Container(
                          width: 250,
                          child: Text(
                            event.title,
                            style: kTitleTextStyle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 6, right: 8.0, top: 4),
                        child: Icon(Icons.access_time),
                      ),
                      Text(
                        "${DateFormat.y().format(event.startDate).toString()} ${DateFormat.MMMd().format(event.startDate).toString()} - ${DateFormat.MMMd().format(event.endDate).toString()}",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 6, right: 8.0, top: 4),
                        child: Icon(Icons.attach_money),
                      ),
                      Text(
                        event.budget.toString(),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Spacer(),
              ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [
                      Colors.black,
                      Colors.transparent,
                    ],
                  ).createShader(Rect.fromLTRB(5, 0, rect.width, rect.height));
                },
                blendMode: BlendMode.dstATop,
                child: Image.asset(
                  'images/event${event.id}.jpg',
                  height: 150,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
