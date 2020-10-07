import 'package:event_planner/classes/BudgetDonut.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class BudgetChart extends StatelessWidget {
  final List<BudgetDonut> data;
  BudgetChart({@required this.data});
  @override
  Widget build(BuildContext context) {
    List<charts.Series<BudgetDonut, String>> series = [
      charts.Series(
        id: "Budget",
        data: data,
        domainFn: (BudgetDonut guest, _) => guest.catId,
        measureFn: (BudgetDonut guest, _) => guest.count,
        labelAccessorFn: (BudgetDonut row, _) => '${row.catId}',
      )
    ];
    return Container(
      height: 206.0,
      child: charts.PieChart(series,
          animate: false,
          defaultRenderer: new charts.ArcRendererConfig(
              arcWidth: 90,
              arcRendererDecorators: [new charts.ArcLabelDecorator()])),
    );
  }
}
