import 'package:flutter/material.dart';

import '../constants.dart';

class button extends StatelessWidget {
  final Function onPress;
  final String title;

  const button({@required this.onPress, @required this.title});

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
              kMainColor,
              kMainColorOpacity,
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
