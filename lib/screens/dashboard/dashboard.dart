import 'package:event_planner/classes/BudgetDonut.dart';
import 'package:event_planner/classes/Event.dart';
import 'package:event_planner/classes/Guest.dart';
import 'package:event_planner/classes/GuestDonut.dart';
import 'package:event_planner/classes/TodoDonut.dart';
import 'package:event_planner/components/BudgetChart.dart';
import 'package:event_planner/components/GuestChart.dart';
import 'package:event_planner/components/LeftCentricGraphCard.dart';
import 'package:event_planner/components/RightCentricGraphCard.dart';
import 'package:event_planner/components/TodoChart.dart';
import 'package:event_planner/components/ZeroDataCard.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  static const String id = 'dashboard';
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  TextEditingController myCon = TextEditingController();
  FocusNode myFocusNode;
  var time = 1;
  Event event;
  //guests
  var guestsList;
  var guests = List<Guest>();
  bool conditionGuest = false;
  int guestCount = 0;
  int guestMaleCount = 0;
  int guestFemaleCount = 0;
  double maleToFemalePercentage = 0.0;
  //tasks
  bool conditionTodo = false;
  int todoCount = 0;
  int remainingTodo = 0;
  int completedTodo = 0;
  double todoCompletedPercentage = 0.0;
  //budget
  bool conditionBudget = false;
  double totalBudget = 0.0;
  double paidAmount = 0.0;
  bool conditionShoppingList = false;
  double shoppingListTotal = 0.0;
  double leftBudget = 0.0;
  double leftBudgetPercentage = 0.0;

  @override
  void initState() {
    myFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (time == 1) {
      event = ModalRoute.of(context).settings.arguments;
      //guest info
      if (event.guests != null) {
        guestsList = event.guests;
        guests.addAll(guestsList);
        if (event.guests.length > 0) {
          conditionGuest = true;
          guestCount = event.guests.length;
          for (var g in event.guests) {
            if (g.gender == true) {
              guestMaleCount++;
            } else {
              guestFemaleCount++;
            }
          }
          maleToFemalePercentage = (guestMaleCount / guestCount) * 100;
        }
      }
      //task info
      if (event.todoList != null) {
        if (event.todoList.length > 0) {
          conditionTodo = true;
          todoCount = event.todoList.length;
          for (var t in event.todoList) {
            if (t.completed == true) {
              completedTodo++;
            } else {
              remainingTodo++;
            }
          }
          todoCompletedPercentage = (completedTodo / todoCount) * 100;
        }
      }
      //budget info
      if (event.budget != null) {
        if (event.budget.paidAmount != null) {
          conditionBudget = true;
          totalBudget = event.budget.budget;
          paidAmount = event.budget.paidAmount;
          todoCompletedPercentage = (completedTodo / todoCount) * 100;
        }
        //looping through the shopping list
        if (event.shoppingList != null) {
          if (event.shoppingList.length > 0) {
            conditionShoppingList = true;
            event.shoppingList.forEach((element) {
              shoppingListTotal += element.price;
            });
          }
        }
        leftBudget = totalBudget - (paidAmount + shoppingListTotal);
        leftBudgetPercentage = ((leftBudget) / totalBudget * 100);
      }
    }

    time++;
    final List<GuestDonut> guestData = [
      GuestDonut('Male', guestMaleCount),
      GuestDonut('Female', guestFemaleCount)
    ];
    final List<TodoDonut> taskData = [
      TodoDonut("Done", completedTodo),
      TodoDonut("Left", remainingTodo)
    ];
    final List<BudgetDonut> budgetData = [
      BudgetDonut('Initial', paidAmount),
      BudgetDonut('Shopping', shoppingListTotal),
      BudgetDonut('Remaining', leftBudget)
    ];

    return Scaffold(
      appBar: AppBar(
          title: Text('SUMMARY', style: TextStyle(color: Colors.white)),
          iconTheme: new IconThemeData(color: Colors.white)),
      body: Column(
        children: [
          Expanded(
            child: conditionTodo
                ? RightCentricGraphCard(
                    graphType: TodoChart(
                      data: taskData,
                    ),
                    title: "TASKS",
                    subTitle: todoCompletedPercentage.toStringAsFixed(1) + "%",
                    txtChildren: [
                      Text('Total : $todoCount'),
                      Text('Remaining: $remainingTodo')
                    ],
                  )
                : ZeroDataCard(title: "Tasks"),
          ),
          Expanded(
              child: conditionGuest
                  ? LeftCentricGraphCard(
                      graphType: GuestChart(
                        data: guestData,
                      ),
                      title: "Guests",
                      subTitle: maleToFemalePercentage.toStringAsFixed(1) + "%",
                      txtChildren: [
                        Text('Total : ${guestCount}'),
                        Text('Male: ${guestMaleCount}'),
                        Text('Female: ${guestFemaleCount}'),
                      ],
                    )
                  : ZeroDataCard(title: "Guests")),
          Expanded(
            child: conditionBudget
                ? RightCentricGraphCard(
                    graphType: BudgetChart(
                      data: budgetData,
                    ),
                    title: "Budget",
                    subTitle: leftBudgetPercentage.toStringAsFixed(1) + "%",
                    txtChildren: [
                      Text('Total : $totalBudget'),
                      Text('Paid  : ${paidAmount + shoppingListTotal}'),
                      Text('Left   : $leftBudget'),
                    ],
                  )
                : ZeroDataCard(
                    title: "Budget",
                  ),
          ),
        ],
      ),
    );
  }
}
