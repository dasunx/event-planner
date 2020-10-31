import 'dart:convert';

import 'package:event_planner/classes/Event.dart';
import 'package:event_planner/classes/Guest.dart';
import 'package:event_planner/classes/RouteArguments.dart';
import 'package:event_planner/components/AlertDialog.dart';
import 'package:event_planner/components/EmptyList.dart';
import 'package:event_planner/components/SearchBar.dart';
import 'package:event_planner/components/Toast.dart';
import 'package:event_planner/components/button.dart';
import 'package:event_planner/constants.dart';
import 'package:event_planner/functions/FirebaseHelper.dart';
import 'package:event_planner/screens/guest/add_guest.dart';
import 'package:event_planner/screens/guest/update_guest.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ViewGuests extends StatefulWidget {
  static const String id = 'view_guest';
  @override
  _ViewGuestsState createState() => _ViewGuestsState();
}

class _ViewGuestsState extends State<ViewGuests> {
  TextEditingController myCon = TextEditingController();
  FocusNode myFocusNode;
  var time = 1;
  Event event;
  var guestsList;
  var guests = List<Guest>();
  bool conditionx = false;
  bool inviting = false;
  int ivUser;
  @override
  void initState() {
    myFocusNode = FocusNode();
    super.initState();
  }

  void filterResult(String query) {
    List<Guest> searchList = List<Guest>();
    searchList.addAll(guestsList);
    if (query.isNotEmpty) {
      List<Guest> dummyList = List<Guest>();
      searchList.forEach((item) {
        if (item.name.toLowerCase().contains(query) ||
            item.email.toLowerCase().contains(query)) {
          dummyList.add(item);
        }
      });
      setState(() {
        guests.clear();
        guests.addAll(dummyList);
      });
      return;
    } else {
      setState(() {
        guests.clear();
        guests.addAll(guestsList);
      });
    }
  }

  void deleteGuest(int index) {
    FirebaseHelper fl = new FirebaseHelper();
    fl.removeGuest(event.id, event.guests[index]);
    event.guests.removeAt(index);
    setState(() {
      guests.clear();
      guests.addAll(event.guests);
      if (guests != null) {
        if (guests.length <= 0) {
          conditionx = false;
        }
      }
    });
  }

  void inviteGuest(Guest inGuest, int index) async {
    setState(() {
      ivUser = index;
      inviting = true;
    });
    final http.Response response =
        await http.post("https://nodemail-server.herokuapp.com/api/invitation/",
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            body: jsonEncode(<String, dynamic>{
              "senderMail": inGuest.email,
              "eventName": event.title,
              "senderName": "Eventplaneer",
              "callbackUrl": "https://google.lk",
              "time": DateFormat.yMMMd().format(event.startDate).toString(),
              "venue": event.location,
              "msg": inGuest.note != null
                  ? inGuest.note
                  : "you have been invited for this event"
            }));
    setState(() {
      inviting = false;
      inGuest.invited = true;
    });
    FirebaseHelper firebaseHelper = new FirebaseHelper();
    firebaseHelper.updateGuests(guests, event.id);
  }

  @override
  Widget build(BuildContext context) {
    if (time == 1) {
      event = ModalRoute.of(context).settings.arguments;

      if (event.guests != null) {
        guestsList = event.guests;
        guests.addAll(guestsList);
        if (event.guests.length > 0) {
          conditionx = true;
        }
      }
    }

    time++;
    return Scaffold(
      floatingActionButton: new Visibility(
        visible: conditionx,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.popAndPushNamed(context, AddGuest.id, arguments: event);
          },
          backgroundColor: kMainColor,
          elevation: 10,
          child: Icon(
            Icons.add,
            size: 34,
          ),
        ),
      ),
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
          title: Text('${event.title}', style: TextStyle(color: Colors.white)),
          iconTheme: new IconThemeData(color: Colors.white)),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          child: GestureDetector(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Text(
                      "View Guests",
                      style: kTitleTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Visibility(
                  visible: conditionx,
                  child: Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(top: 5, left: 40, right: 40),
                      child: buildSearch(myFocusNode, "search guest", (value) {
                        filterResult(value);
                      }, myCon),
                    ),
                  ),
                ),
                conditionx
                    ? Expanded(
                        flex: 8,
                        child: Container(
                          child: new ListView.builder(
                            itemCount: guests.length,
                            itemBuilder: (BuildContext context, int index) =>
                                buildGuestList(context, index),
                          ),
                        ),
                      )
                    : EmptyList(
                        title: "No one here yet!",
                        onPress: () {
                          Navigator.popAndPushNamed(context, AddGuest.id,
                              arguments: event);
                        },
                        buttonText: "Add Guest",
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildGuestList(BuildContext context, int index) {
    Guest guest = guests[index];
    return GestureDetector(
      onTap: () {
        myFocusNode.unfocus();
      },
      child: Container(
        margin: EdgeInsets.only(right: 10, left: 10, top: 5),
        child: Card(
          elevation: 4,
          child: ExpansionTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 8.0, left: 2.0, top: 2, bottom: 2),
                      child: Icon(
                        Icons.person,
                        color: kMainColor,
                      ),
                    ),
                    Text(
                      guest.name,
                      style: kTitleTextStyle.copyWith(fontSize: 18),
                    ),
                    Spacer(),
                    Visibility(
                      visible: inviting && !guest.invited && ivUser == index,
                      child: Chip(
                        avatar: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: CircularProgressIndicator(),
                        ),
                        backgroundColor: Colors.blue,
                        label: Text(
                          'inviting',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: guest.invited,
                      child: Chip(
                        avatar: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.done,
                            color: Colors.green,
                          ),
                        ),
                        backgroundColor: Colors.green,
                        label: Text(
                          'invited',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 8.0, left: 2.0, top: 2, bottom: 2),
                      child: Icon(
                        Icons.email,
                        color: kMainColorOpacity,
                      ),
                    ),
                    Text(guest.email),
                  ],
                )
              ],
            ),
            children: <Widget>[
              Container(
                padding:
                    EdgeInsets.only(right: 8.0, left: 20.0, top: 2, bottom: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          Text(
                            "Gender: ",
                          ),
                          Text(
                            guest.gender ? "Male" : "Female",
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          Text("Notes: "),
                          Text(
                            guest.note,
                            maxLines: 3,
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: button(
                              onPress: () {
                                if (!guest.invited) {
                                  inviteGuest(guest, index);
                                } else {
                                  showToast("already invited");
                                }
                              },
                              title: guest.invited ? "Invited" : "invite",
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            onPressed: () {
                              Navigator.popAndPushNamed(context, UpdateGuest.id,
                                  arguments:
                                      UpdateGuestArguments(index, event));
                            },
                            icon: Icon(Icons.edit),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            onPressed: () {
                              showAlertDialog(
                                  context,
                                  "Delete guest",
                                  "Are you sure, do you need to delete this guest?",
                                  "Delete",
                                  "No", () {
                                deleteGuest(index);
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              }, () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              });
                            },
                            icon: Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
