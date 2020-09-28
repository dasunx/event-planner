import 'package:flutter/material.dart';

import '../constants.dart';

class button extends StatelessWidget {
  final Function onPress;
  final String title;
  final Color color;
  final Color secondaryColor;

  const button(
      {@required this.onPress,
      @required this.title,
      this.color,
      this.secondaryColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [
              color != null ? color : kMainColor,
              secondaryColor != null ? secondaryColor : kMainColorOpacity,
            ],
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
