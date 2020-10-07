import 'package:event_planner/classes/TodoDonut.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class TodoChart extends StatelessWidget {
  final List<TodoDonut> data;
  TodoChart({@required this.data});
  @override
  Widget build(BuildContext context) {
    List<charts.Series<TodoDonut, String>> series = [
      charts.Series(
        id: "Todo",
        data: data,
        domainFn: (TodoDonut todo, _) => todo.catId,
        measureFn: (TodoDonut todo, _) => todo.count,
        labelAccessorFn: (TodoDonut row, _) => '${row.catId}',
      )
    ];
    return Container(
      height: 206.0,
      child: charts.PieChart(series,
          animate: true,
          defaultRenderer: new charts.ArcRendererConfig(
              arcWidth: 40,
              arcRendererDecorators: [new charts.ArcLabelDecorator()])),
    );
  }
}
