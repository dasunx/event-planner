import 'package:event_planner/classes/Event.dart';
import 'package:event_planner/components/EmptyList.dart';
import 'package:event_planner/constants.dart';
import 'package:event_planner/screens/budget/add_budget_screen.dart';
import 'package:flutter/material.dart';

class ViewBudget extends StatefulWidget {
  static const String id = 'view_budget';
  @override
  _ViewBudgetState createState() => _ViewBudgetState();
}

class _ViewBudgetState extends State<ViewBudget> {
  Event event;
  bool conditionx = false;

  @override
  Widget build(BuildContext context) {
    event = ModalRoute.of(context).settings.arguments;
    if (event.budget.budget != null && event.budget.paidAmount != null) {
      conditionx = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  "Budget of ${event.title}",
                  style: kTitleTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            conditionx
                ? Expanded(
                    flex: 8,
                    child: Container(
                      child: Text("Chart will go here"),
                    ),
                  )
                : EmptyList(
                    title: "Not added yet!",
                    onPress: () {
                      Navigator.popAndPushNamed(context, AddBudget.id,
                          arguments: event);
                    },
                    buttonText: "Add budget",
                  ),
          ],
        ),
      ),
    );
  }
}
