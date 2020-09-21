import 'package:event_planner/constants.dart';
import 'package:event_planner/screens/home_screen.dart';
import 'package:event_planner/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: kMainColor,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        width: 200.0,
                        image: AssetImage('images/logo.png'),
                      ),
                      Text(
                        'Event planner',
                        style: TextStyle(
                            fontSize: 40.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
              ),
              Container(
                child: MaterialButton(
                  color: Colors.white,
                  child: Text('Home'),
                  onPressed: () {
                    // Fluttertoast.showToast(
                    //   msg: "I am in Login screen",
                    //   toastLength: Toast.LENGTH_SHORT,
                    //   gravity: ToastGravity.BOTTOM,
                    //   timeInSecForIosWeb: 1,
                    //   backgroundColor: Colors.black38,
                    //   textColor: Colors.white,
                    //   fontSize: 16.0,
                    // );
                    Navigator.pushNamed(context, HomeScreen.id);
                  },
                ),
              ),
              Container(
                child: MaterialButton(
                  color: Colors.white,
                  child: Text('Login'),
                  onPressed: () {
                    // Fluttertoast.showToast(
                    //   msg: "I am in Login screen",
                    //   toastLength: Toast.LENGTH_SHORT,
                    //   gravity: ToastGravity.BOTTOM,
                    //   timeInSecForIosWeb: 1,
                    //   backgroundColor: Colors.black38,
                    //   textColor: Colors.white,
                    //   fontSize: 16.0,
                    // );
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
