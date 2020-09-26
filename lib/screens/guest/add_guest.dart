import 'package:event_planner/classes/Event.dart';
import 'package:event_planner/classes/Guest.dart';
import 'package:event_planner/components/Toast.dart';
import 'package:event_planner/components/button.dart';
import 'package:event_planner/constants.dart';
import 'package:event_planner/functions/FirebaseHelper.dart';
import 'package:event_planner/screens/guest/view_guests.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddGuest extends StatefulWidget {
  static const String id = 'add_guest';
  @override
  _AddGuestState createState() => _AddGuestState();
}

class _AddGuestState extends State<AddGuest> {
  Event event;
  FocusNode myFocusNode;
  @override
  bool _radioValue = true;
  String email;
  String name;
  String note;

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
    event = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${event.title}',
        ),
      ),
      body: Container(
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
                    "Add Guest",
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
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: "Guest email", labelText: 'Email'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
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
                      onChanged: (value) {
                        note = value;
                      },
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: "Notes", labelText: 'Notes'),
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

                    Guest guest = Guest(email, name, _radioValue, note);
                    event.guests.add(guest);
                    fl.addGuest(event.id, guest, context);
                    // Navigator.pushNamed(context, ViewGuests.id,
                    //     arguments: event);
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
    );
  }
}
