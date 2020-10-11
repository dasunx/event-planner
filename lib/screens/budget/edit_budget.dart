import 'package:event_planner/classes/Budget.dart';
import 'package:event_planner/classes/Event.dart';
import 'package:event_planner/components/button.dart';
import 'package:event_planner/constants.dart';
import 'package:event_planner/functions/FirebaseHelper.dart';
import 'package:event_planner/screens/budget/view_budget.dart';
import 'package:flutter/material.dart';

class EditBudget extends StatefulWidget {
  static const String id = 'edit_budget';
  @override
  _EditBudgetState createState() => _EditBudgetState();
}

class _EditBudgetState extends State<EditBudget> {
  TextEditingController txbudget = new TextEditingController();
  TextEditingController txNotes = new TextEditingController();
  TextEditingController txPaid = new TextEditingController();
  Event event;
  bool conditionx = false;
  int time = 1;
  FirebaseHelper fl = new FirebaseHelper();
  double budget;
  String notes;
  double paidAmount;
  @override
  Widget build(BuildContext context) {
    if (time == 1) {
      event = ModalRoute.of(context).settings.arguments;
      if (event.budget != null) {
        if (event.budget.budget != null && event.budget.paidAmount != null) {
          conditionx = true;
          txbudget..text = event.budget.budget.toString();
          txPaid..text = event.budget.paidAmount.toString();
          txNotes..text = event.budget.note;
          budget = event.budget.budget;
          notes = event.budget.note;
          paidAmount = event.budget.paidAmount;
          print(conditionx);
        }
      }
    }
    time++;
    return Scaffold(
      appBar: AppBar(
          title: Text("Update Budget", style: TextStyle(color: Colors.white)),
          iconTheme: new IconThemeData(color: Colors.white)),
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
                    "update Budget of ${event.title}",
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
                      controller: txbudget,
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
                      controller: txPaid,
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
                      controller: txNotes,
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
                  title: "update",
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
