import 'package:flutter/material.dart';

class RightCentricGraphCard extends StatelessWidget {
  final Widget graphType;
  final String title;
  final String subTitle;
  final List<Widget> txtChildren;
  RightCentricGraphCard({
    @required this.graphType,
    @required this.title,
    @required this.subTitle,
    @required this.txtChildren,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 17.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title,
                                      style: TextStyle(
                                          fontSize: 28.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      subTitle,
                                      style: TextStyle(
                                        fontSize: 28.0,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: txtChildren,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: graphType,
                  )
                ],
              ),
            ),
            margin: EdgeInsets.all(10.0),
          ),
        )
      ],
    );
  }
}
