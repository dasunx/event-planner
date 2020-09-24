import 'package:event_planner/components/button.dart';
import 'package:event_planner/constants.dart';
import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  final String title;
  final Function onPress;
  final String buttonText;
  final String image;

  const EmptyList(
      {this.title, @required this.onPress, this.image, this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 9,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
              ),
              child: Text(
                title,
                style: kTitleTextStyle.copyWith(
                  fontSize: 32,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/noguest.png"),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
              child: button(
                onPress: onPress,
                title: buttonText,
              ),
            ),
          )
        ],
      ),
    );
  }
}
