import 'package:event_planner/classes/Event.dart';
import 'package:event_planner/classes/RouteArguments.dart';
import 'package:event_planner/components/AlertDialog.dart';
import 'package:event_planner/components/button.dart';
import 'package:event_planner/constants.dart';
import 'package:event_planner/functions/FirebaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpdateEvent extends StatefulWidget {
  static const String id = 'update_event';
  @override
  _UpdateEventState createState() => _UpdateEventState();
}

class _UpdateEventState extends State<UpdateEvent> {
  Event event;
  FocusNode myFocusNode;
  TextEditingController nameController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();
  TextEditingController noteController = new TextEditingController();

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

  @override
  String location;
  String title;
  String note;
  int time = 1;
  int index;

  @override
  void initState() {
    myFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (time == 1) {
      event = ModalRoute.of(context).settings.arguments;
      setState(() {
        nameController..text = event.title;
        locationController..text = event.location;
        noteController..text = event.note;
        title = event.title;
        location = event.location;
        note = event.note;
      });
    }
    time++;
    return Scaffold(
      appBar: AppBar(
          title: Text(
            '${event.title}',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: new IconThemeData(color: Colors.white)),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 100,
          margin: EdgeInsets.only(left: 10, right: 10),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "Update Event ${event.title}",
                      style: kTitleTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: Column(
                    children: [
                      TextField(
                        onChanged: (value) {
                          title = value;
                        },
                        controller: nameController,
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: "Event Name", labelText: 'Event Name'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: locationController,
                        onChanged: (value) {
                          location = value;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: "Location", labelText: 'Location'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      new RaisedButton(
                        padding: EdgeInsets.only(
                            left: 12, right: 170, top: 5, bottom: 5),
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
                      SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        controller: noteController,
                        onChanged: (value) {
                          note = value;
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
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: button(
                    onPress: () {
                      FirebaseHelper fl = new FirebaseHelper();
                      Event eventLoc = event;
                      if (location != null && title != null) {
                        if (eventLoc.title == title &&
                            eventLoc.location == location &&
                            eventLoc.note == note) {
                          showAlertDialog(
                              context,
                              "Nothing changed",
                              "You haven't update the event\'s details, do you need to continue editing?",
                              "Yes",
                              "No, Go back", () {
                            Navigator.of(context, rootNavigator: true).pop();
                          }, () {
                            Navigator.of(context, rootNavigator: true).pop();
                            // Navigator.popAndPushNamed(context, ViewGuests.id,
                            //     arguments: event);
                            Navigator.pop(context);
                          });
                        } else {
                          event.title = title;
                          event.location = location;
                          event.note = note;
                          fl.updateEvent(location, title, note, event.id);
                          Navigator.pop(context);
                        }
                      }

                      // showToast("Guest added");
                    },
                    title: "Save",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: button(
                    onPress: () {
                      Navigator.pop(context);
                    },
                    title: "Cancel",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
