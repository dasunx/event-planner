import 'package:flutter/material.dart';

class LeftCentricGraphCard extends StatelessWidget {
  final Widget graphType;
  final String title;
  final String subTitle;
  final List<Widget> txtChildren;

  LeftCentricGraphCard({
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
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: graphType,
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 15.0, bottom: 17.0, right: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
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
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
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
              ],
            ),
            margin: EdgeInsets.all(10.0),
          ),
        )
      ],
    );
  }
}
