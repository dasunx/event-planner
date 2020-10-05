import 'package:event_planner/classes/Event.dart';
import 'package:event_planner/components/EmptyList.dart';
import 'package:event_planner/components/button.dart';
import 'package:event_planner/constants.dart';
import 'package:event_planner/screens/budget/add_budget_screen.dart';
import 'package:event_planner/screens/budget/edit_budget.dart';
import 'package:event_planner/screens/guest/view_guests.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class ViewBudget extends StatefulWidget {
  static const String id = 'view_budget';
  @override
  _ViewBudgetState createState() => _ViewBudgetState();
}

class _ViewBudgetState extends State<ViewBudget> {
  Event event;
  bool conditionx = false;
  Map<String, double> dataMap = new Map();

  @override
  Widget build(BuildContext context) {
    event = ModalRoute.of(context).settings.arguments;
    if (event.budget != null) {
      if (event.budget.budget != null && event.budget.paidAmount != null) {
        conditionx = true;
        dataMap.putIfAbsent("paidAmount", () => event.budget.paidAmount);
        dataMap.putIfAbsent(
            "balance", () => (event.budget.budget - event.budget.paidAmount));
        print(conditionx);
      }
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
            Visibility(
              visible: conditionx,
              child: Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      detailsRow("Budget amount",
                          conditionx ? event.budget.budget.toString() : "0"),
                      detailsRow(
                          "paid amount: ",
                          conditionx
                              ? event.budget.paidAmount.toString()
                              : "0"),
                      detailsRow(
                          "Balance amount: ",
                          conditionx
                              ? (event.budget.budget - event.budget.paidAmount)
                                  .toString()
                              : "0"),
                    ],
                  ),
                ),
              ),
            ),
            conditionx
                ? Expanded(
                    flex: 8,
                    child: Container(
                      child: Center(
                          child: PieChart(
                        dataMap: dataMap,
                        legendFontColor: Colors.blueGrey[900],
                        legendFontSize: 14.0,
                        legendFontWeight: FontWeight.w500,
                        animationDuration: Duration(milliseconds: 800),
                        chartLegendSpacing: 32.0,
                        chartRadius: MediaQuery.of(context).size.width / 2.7,
                        showChartValuesInPercentage: true,
                        showChartValues: true,
                        chartValuesColor: Colors.blueGrey[900].withOpacity(0.9),
                      )),
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
            Visibility(
              visible: conditionx,
              child: Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Tooltip(
                    message: "update this event's budget",
                    child: button(
                      title: "Update budget",
                      onPress: () {
                        Navigator.pushNamed(context, EditBudget.id,
                            arguments: event);
                      },
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: conditionx,
              child: Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Tooltip(
                    message: "Go to dashboard page to view full details",
                    child: button(
                      title: "View Dashboard",
                      onPress: () {
                        Navigator.pushNamed(context, ViewGuests.id,
                            arguments: event);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget detailsRow(String title, String message) {
    return Row(
      children: [
        Text(
          title,
          style: kLabelTextStyle.copyWith(color: Colors.black),
        ),
        Spacer(),
        Text(message, style: kLabelTextStyle.copyWith(color: Colors.black)),
      ],
    );
  }
}
