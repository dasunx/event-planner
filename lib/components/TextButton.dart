import 'package:event_planner/constants.dart';
import 'package:flutter/material.dart';

class TextButton extends StatelessWidget {
  final String text;
  final Function onPress;
  final double textSize;
  final FontWeight textWeight;

  const TextButton(
      {@required this.text,
      @required this.onPress,
      this.textSize,
      this.textWeight});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Text(
        text,
        style: TextStyle(
            color: kMainColor, fontSize: textSize, fontWeight: textWeight),
      ),
    );
  }
}
