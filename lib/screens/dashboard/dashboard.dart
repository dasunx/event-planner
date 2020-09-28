import 'package:event_planner/classes/Event.dart';
import 'package:event_planner/classes/Guest.dart';
import 'package:event_planner/classes/GuestDonut.dart';
import 'package:event_planner/classes/TodoDonut.dart';
import 'package:event_planner/components/GuestChart.dart';
import 'package:event_planner/components/LeftCentricGraphCard.dart';
import 'package:event_planner/components/RightCentricGraphCard.dart';
import 'package:event_planner/components/TodoChart.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  static const String id = 'dashboard';
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  TextEditingController myCon = TextEditingController();
  FocusNode myFocusNode;
  int guestCount;
  int guestMaleCount = 0;
  int guestFemaleCount = 0;
  double maleToFemalePercentage;

  var time = 1;
  Event event;
  var guestsList;
  var guests = List<Guest>();
  bool conditionx = false;
  @override
  void initState() {
    myFocusNode = FocusNode();
    super.initState();
  }

  final List<TodoDonut> todoData = [TodoDonut(1, 20), TodoDonut(2, 15)];

  @override
  Widget build(BuildContext context) {
    if (time == 1) {
      event = ModalRoute.of(context).settings.arguments;
      setState(() {
        if (event.guests != null) {
          guestsList = event.guests;
          guests.addAll(guestsList);
          if (event.guests.length > 0) {
            conditionx = true;
            guestCount = event.guests.length;
            for (var g in event.guests) {
              if (g.gender == true) {
                guestMaleCount++;
              } else {
                guestFemaleCount++;
              }
            }
          }
          maleToFemalePercentage = (guestMaleCount / guestCount) * 100;
        }
      });
    }

    time++;
    final List<GuestDonut> guestData = [
      GuestDonut('Male', guestMaleCount),
      GuestDonut('Female', guestFemaleCount)
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SUMMARY',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: RightCentricGraphCard(
              graphType: TodoChart(
                data: todoData,
              ),
              title: "TASKS",
              subTitle: "60%",
              txtChildren: [Text('Total : 25'), Text('Remaining: 10')],
            ),
          ),
          Expanded(
            child: LeftCentricGraphCard(
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
            ),
          ),
          Expanded(
            child: RightCentricGraphCard(
              graphType: TodoChart(
                data: todoData,
              ),
              title: "TASKS",
              subTitle: "60%",
              txtChildren: [Text('Total : 25'), Text('Remaining: 10')],
            ),
          ),
        ],
      ),
    );
  }
}
