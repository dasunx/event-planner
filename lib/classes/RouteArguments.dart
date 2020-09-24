import 'package:event_planner/classes/Event.dart';
import 'package:flutter/cupertino.dart';

class RouteArguments {
  final String buttonName;
  final String subTitle;
  final String routeScreen;
  final Type widget;
  RouteArguments(
      {this.widget, this.buttonName, this.subTitle, this.routeScreen});
}
