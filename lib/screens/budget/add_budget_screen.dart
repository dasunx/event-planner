import 'package:event_planner/classes/Budget.dart';
import 'package:event_planner/classes/Event.dart';
import 'package:event_planner/components/button.dart';
import 'package:event_planner/constants.dart';
import 'package:event_planner/functions/FirebaseHelper.dart';
import 'package:event_planner/screens/budget/view_budget.dart';
import 'package:event_planner/screens/guest/view_guests.dart';
import 'package:flutter/material.dart';

class AddBudget extends StatefulWidget {
  static const String id = 'add_budget';
  @override
  _AddBudgetState createState() => _AddBudgetState();
}

class _AddBudgetState extends State<AddBudget> {
  Event event;
  FirebaseHelper fl = new FirebaseHelper();
  double budget;
  String notes;
  double paidAmount;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    event = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Budget",
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
                padding: const EdgeInsets.all(18.0),
                child: Center(
                  child: Text(
                    "Add Budget of ${event.title}",
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
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        budget = double.parse(value);
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: "Total budget", labelText: 'Budget'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        paidAmount = double.parse(value);
                      },
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: "Paid amount", labelText: 'Paid amount'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      onChanged: (value) {
                        notes = value;
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

                    if (budget != null && paidAmount != null) {
                      Budget tempBudget = new Budget(budget, paidAmount, notes);

                      fl.addBudget(event.id, tempBudget);
                      event.budget.budget = budget;
                      event.budget.paidAmount = paidAmount;
                      event.budget.note = notes;
                      Navigator.popAndPushNamed(context, ViewBudget.id,
                          arguments: event);
                    }
                    // Guest guest = Guest(email, name, _radioValue, note);
                    // event.guests.add(guest);
                    // fl.addGuest(event.id, guest, context);

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
