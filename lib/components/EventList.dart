import 'package:event_planner/classes/Event.dart';
import 'package:event_planner/constants.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget buildEventCard(BuildContext context, int index, List<Event> items,
    String routeId, FocusNode myFocusNode) {
  final event = items[index];
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  double width = MediaQuery.of(context).size.width - 20;
  return GestureDetector(
    onTap: () {
      myFocusNode.unfocus();
      Navigator.pushNamed(context, routeId, arguments: event);
    },
    child: Container(
      margin: EdgeInsets.only(right: 6, top: 10, left: 6),
      child: Card(
        elevation: 6,
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              height: 150,
              width: (width / 20) * 13,
              child: Column(
                textBaseline: TextBaseline.ideographic,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 1.0),
                        child: Text(
                          capitalize(event.title),
                          style: kTitleTextStyle.copyWith(fontSize: 22),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.access_time),
                      Text(
                        "${DateFormat.yMMMd().format(event.startDate).toString()}",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_on),
                      Text(
                        event.location,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: 150,
              width: (width / 20) * 7,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'images/event$index.jpg',
                  ),
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4), BlendMode.dstOut),
                  fit: BoxFit.cover,
                  alignment: Alignment.lerp(
                      Alignment.center, Alignment.centerRight, 1),
                ),
              ),
            ),
            // Container(
            //   child: ShaderMask(
            //     shaderCallback: (rect) {
            //       return LinearGradient(
            //         begin: Alignment.centerRight,
            //         end: Alignment.centerLeft,
            //         colors: [
            //           Colors.black,
            //           Colors.transparent,
            //         ],
            //       ).createShader(Rect.fromLTRB(5, 0, rect.width, rect.height));
            //     },
            //     blendMode: BlendMode.dstATop,
            //     child: Image.asset(
            //       'images/event$index.jpg',
            //       height: 150,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    ),
  );
}
