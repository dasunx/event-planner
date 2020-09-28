import 'package:event_planner/classes/GuestDonut.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GuestChart extends StatelessWidget {
  final List<GuestDonut> data;
  GuestChart({@required this.data});
  @override
  Widget build(BuildContext context) {
    List<charts.Series<GuestDonut, String>> series = [
      charts.Series(
        id: "Guest",
        data: data,
        domainFn: (GuestDonut guest, _) => guest.catId,
        measureFn: (GuestDonut guest, _) => guest.count,
        labelAccessorFn: (GuestDonut row, _) => '${row.catId}',
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
