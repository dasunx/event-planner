import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue,
        body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget>[
                    Image(
                      width: 200.0,
                      image: AssetImage('images/logo.png'),
                    ),
                    Text(
                      'Event planner',
                      style: TextStyle(
                          fontSize: 40.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ]
              ),
            )
        ),
      ),
    );
  }

}