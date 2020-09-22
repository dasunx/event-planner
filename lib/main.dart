import 'package:event_planner/constants.dart';
import 'package:event_planner/screens/add_event.dart';
import 'package:event_planner/screens/add_guest.dart';
import 'package:event_planner/screens/choose_event_screen.dart';
import 'package:event_planner/screens/forgotpassword_screen.dart';
import 'package:event_planner/screens/home_screen.dart';
import 'package:event_planner/screens/login_screen.dart';
import 'package:event_planner/screens/registration_screen.dart';
import 'package:event_planner/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'NotoSans', primaryColor: kMainColor),
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistraionScreen.id: (context) => RegistraionScreen(),
        ForgotPasswordScreen.id: (context) => ForgotPasswordScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        AddEvent.id: (context) => AddEvent(),
        ChooseEvent.id: (context) => ChooseEvent(),
        AddGuest.id: (context) => AddGuest()
      },
    );
  }
}
