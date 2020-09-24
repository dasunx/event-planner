import 'package:event_planner/classes/Event.dart';
import 'package:event_planner/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget buildEventCard(BuildContext context, int index, List<Event> items,
    String routeId, FocusNode myFocusNode) {
  final event = items[index];
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.ideographic,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 6, right: 8.0, top: 4, bottom: 20),
                      child: Icon(Icons.event),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 6, right: 8.0, top: 4, bottom: 20),
                      child: Container(
                        width: 250,
                        child: Text(
                          event.title,
                          style: kTitleTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 6, right: 8.0, top: 4),
                      child: Icon(Icons.access_time),
                    ),
                    Text(
                      "${DateFormat.y().format(event.startDate).toString()} ${DateFormat.MMMd().format(event.startDate).toString()} - ${DateFormat.MMMd().format(event.endDate).toString()}",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 6, right: 8.0, top: 4),
                      child: Icon(Icons.attach_money),
                    ),
                    Text(
                      event.budget.toString(),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Spacer(),
            ShaderMask(
              shaderCallback: (rect) {
                return LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Colors.black,
                    Colors.transparent,
                  ],
                ).createShader(Rect.fromLTRB(5, 0, rect.width, rect.height));
              },
              blendMode: BlendMode.dstATop,
              child: Image.asset(
                'images/event${event.id}.jpg',
                height: 150,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
