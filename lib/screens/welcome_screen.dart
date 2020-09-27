import 'package:event_planner/constants.dart';
import 'package:event_planner/screens/home_screen.dart';
import 'package:event_planner/screens/auth/login_screen.dart';
import 'package:event_planner/screens/onboard/onboard_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

User loggedInUser;

class _WelcomeScreenState extends State<WelcomeScreen> {
  void initState() {
    checkFirstTime();
    super.initState();
  }

  Future checkFirstTime() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool _seen = (preferences.getBool('seen') ?? false);

    if (!_seen) {
      await preferences.setBool("seen", true);
      Navigator.pushReplacementNamed(context, OnBoardScreen.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user == null) {
            return LoginScreen();
          }
          return HomeScreen();
        } else {
          return MaterialApp(
            home: Scaffold(
              backgroundColor: kMainColor,
              body: SafeArea(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
      },
    );
  }
}
