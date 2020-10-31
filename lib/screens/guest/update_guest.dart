import 'package:event_planner/classes/Event.dart';
import 'package:event_planner/classes/Guest.dart';
import 'package:event_planner/classes/RouteArguments.dart';
import 'package:event_planner/components/AlertDialog.dart';

import 'package:event_planner/components/button.dart';
import 'package:event_planner/constants.dart';
import 'package:event_planner/functions/FirebaseHelper.dart';
import 'package:event_planner/screens/guest/view_guests.dart';
import 'package:flutter/material.dart';

class UpdateGuest extends StatefulWidget {
  static const String id = 'update_guest';
  @override
  _UpdateGuestState createState() => _UpdateGuestState();
}

class _UpdateGuestState extends State<UpdateGuest> {
  UpdateGuestArguments upArgs;
  Event event;
  FocusNode myFocusNode;
  TextEditingController emailController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController noteController = new TextEditingController();

  @override
  bool _radioValue = true;
  String email;
  String name;
  String note;
  int time = 1;
  int index;

  @override
  void initState() {
    myFocusNode = FocusNode();
    super.initState();
  }

  void _handleRadioInput(bool value) {
    setState(() {
      _radioValue = value;
    });
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    if (time == 1) {
      upArgs = ModalRoute.of(context).settings.arguments;
      event = upArgs.event;
      index = upArgs.index;
      setState(() {
        emailController..text = event.guests[index].email;
        nameController..text = event.guests[index].name;
        noteController..text = event.guests[index].note;
        email = event.guests[index].email;
        name = event.guests[index].name;
        note = event.guests[index].note;
        _radioValue = event.guests[index].gender;
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
          height: MediaQuery.of(context).size.height - 200,
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
                      "Update Guest ${event.guests[index].name.split(" ")[0]}",
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
                          email = value;
                        },
                        controller: emailController,
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: "Guest email", labelText: 'Email'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: nameController,
                        onChanged: (value) {
                          name = value;
                        },
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: "Guest Name", labelText: 'Name'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Radio(
                            value: true,
                            groupValue: _radioValue,
                            onChanged: _handleRadioInput,
                          ),
                          Text('Male'),
                          Radio(
                            value: false,
                            groupValue: _radioValue,
                            onChanged: _handleRadioInput,
                          ),
                          Text('Female'),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: noteController,
                        onChanged: (value) {
                          note = value;
                        },
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        decoration: kTextFieldDecoration.copyWith(
                            hintText: "Invitation message",
                            labelText: 'Invitation message'),
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
                      Guest guest = event.guests[index];
                      if (email != null &&
                          name != null &&
                          _radioValue != null &&
                          note != null) {
                        if (guest.email == email &&
                            guest.name == name &&
                            guest.gender == _radioValue &&
                            guest.note == note) {
                          showAlertDialog(
                              context,
                              "Nothing changed",
                              "You didn't update this guest\'s details, do you need to continue editing?",
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
                          event.guests[index].email = email;
                          event.guests[index].name = name;
                          event.guests[index].gender = _radioValue;
                          event.guests[index].note = note;
                          event.guests[index].invited = false;
                          fl.updateGuests(event.guests, event.id);
                          Navigator.popAndPushNamed(context, ViewGuests.id,
                              arguments: event);
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
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
