import 'package:event_planner/constants.dart';
import 'package:flutter/material.dart';

class IconContent extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Function onPress;
  IconContent({this.icon, this.label, this.color, this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.all(20),
        color: kMainColorOpacity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 80.0,
              color: color,
            ),
            SizedBox(
              height: 15.0,
            ),
            Text(
              label,
              style: kLabelTextStyle,
            )
          ],
        ),
      ),
    );
  }
}
