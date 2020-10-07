import 'package:flutter/material.dart';

class ZeroDataCard extends StatelessWidget {
  final String title;

  ZeroDataCard({
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            margin: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    title,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
                  ),
                ),
                const ListTile(
                  leading: Icon(Icons.data_usage),
                  title: Text(
                    'Not Enough Data',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                  subtitle: Text("Need more data to generate the Graph"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      child: Text(
                        'Add $title',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {},
                      textColor: Colors.blueAccent,
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
