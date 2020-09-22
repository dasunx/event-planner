import 'package:event_planner/classes/Event.dart';
import 'package:event_planner/classes/RouteArguments.dart';
import 'package:event_planner/components/MainDrawer.dart';
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
  TextEditingController editingController = TextEditingController();
  FocusNode myFocusNode;
  final List<Event> eventList = [
    Event("Supun Birthday party", DateTime(2020, 11, 01),
        DateTime(2020, 11, 02), 50000.0, 1),
    Event("Banda's Wedding", DateTime(2020, 12, 06), DateTime(2020, 12, 09),
        150000.0, 2),
    Event("Mahesh Engagement party", DateTime(2020, 11, 12),
        DateTime(2020, 11, 12), 70000.0, 3),
    Event("Nolimt public gathering", DateTime(2020, 12, 01),
        DateTime(2020, 12, 02), 134000.0, 4),
    Event("Relational office meeting", DateTime(2021, 01, 01),
        DateTime(2020, 01, 02), 23000.0, 5),
    Event("Amila's Birthday", DateTime(2020, 02, 02), DateTime(2021, 02, 02),
        40000.0, 6)
  ];
  var items = List<Event>();

  @override
  void initState() {
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
              flex: 1,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 40, right: 40),
                      child: TextField(
                        focusNode: myFocusNode,
                        onChanged: (value) {
                          filterSearchResults(value);
                        },
                        controller: editingController,
                        decoration: InputDecoration(
                          labelText: "Search",
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          hintText: "Search event",
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: kMainColorOpacity,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                10.0,
                              ),
                            ),
                          ),
                          focusedBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(
                              10.0,
                            ),
                            borderSide: BorderSide(
                              color: kMainColor,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 6,
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
                            left: 6, right: 8.0, top: 4, bottom: 30),
                        child: Icon(Icons.event),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 6, right: 8.0, top: 4, bottom: 30),
                        child: Text(
                          event.title,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
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
