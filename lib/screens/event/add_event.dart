import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planner/classes/Event.dart';
import 'package:event_planner/classes/RouteArguments.dart';
import 'package:event_planner/components/Toast.dart';
import 'package:event_planner/components/button.dart';
import 'package:event_planner/constants.dart';
import 'package:event_planner/screens/guest/add_guest.dart';
import 'package:event_planner/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:event_planner/functions/FirebaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddEvent extends StatefulWidget {
  static const String id = 'add_event';
  @override
  _AddEventState createState() => _AddEventState();
}

final globalScaffoldKey = GlobalKey<ScaffoldState>();
User loggedInUser;
final _firestore = FirebaseFirestore.instance;

class _AddEventState extends State<AddEvent> {
  final _auth = FirebaseAuth.instance;
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print('error $e');
    }
  }

  FocusNode myFocus = FocusNode();
  DateTime selectedDate = DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  String name;

  String venue;
  String note;

  @override
  Widget build(BuildContext context) {
    getCurrentUser();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
          key: globalScaffoldKey,
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            title: Text(
              'Add Event',
            ),
          ),
          body: Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      "Add Event",
                      style: kTitleTextStyle,
                    ),
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        onChanged: (v) {
                          name = v;
                        },
                        focusNode: myFocus,
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Charle\'s Birthday',
                            labelText: 'Event Name'),
                      ),
                      new RaisedButton(
                        padding: EdgeInsets.only(
                            left: 12, right: 60, top: 5, bottom: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(12.0),
                          side: BorderSide(color: kMainColor),
                        ),
                        color: Colors.white,
                        onPressed: () => _selectDate(context),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Text(
                            "Select Date - ${DateFormat.yMMMd().format(selectedDate).toString()}",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black45,
                            ),
                          ),
                        ),
                      ),
                      TextField(
                        onTap: () {},
                        onChanged: (v) {
                          venue = v;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: 'At Hotel Shanthi', labelText: 'Venue'),
                      ),
                      TextField(
                        onChanged: (v) {
                          note = v;
                        },
                        maxLines: 7,
                        decoration: kTextFieldDecoration.copyWith(
                          hintText:
                              'Add details of the event\nThere can be many lines',
                          labelText: 'Event Description',
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Center(
                    child: button(
                      title: 'Create Event',
                      onPress: () {
                        if (name != null && venue != null) {
                          Event event = new Event(name, venue, selectedDate,
                              selectedDate, null, loggedInUser.uid, [], [], []);
                          FirebaseHelper helper = new FirebaseHelper();
                          helper.addEvent(event, context);
                        }
                      },
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
