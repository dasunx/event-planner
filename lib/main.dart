import 'package:event_planner/constants.dart';
import 'package:event_planner/screens/event/add_event.dart';
import 'package:event_planner/screens/guest/add_guest.dart';
import 'package:event_planner/screens/onboard/onboard_screen.dart';
import 'package:event_planner/screens/shoppinglist/add_shoppinglist.dart';
import 'package:event_planner/screens/shoppinglist/view_shoppinglsit.dart';
import 'package:event_planner/screens/test.dart';
import 'package:event_planner/screens/todolist/add_todo.dart';
import 'package:event_planner/screens/event/choose_event_screen.dart';
import 'package:event_planner/screens/auth/forgotpassword_screen.dart';
import 'package:event_planner/screens/home_screen.dart';
import 'package:event_planner/screens/auth/login_screen.dart';
import 'package:event_planner/screens/auth/registration_screen.dart';
import 'package:event_planner/screens/event/view_event.dart';
import 'package:event_planner/screens/guest/view_guests.dart';
import 'package:event_planner/screens/todolist/view_todo.dart';
import 'package:event_planner/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSans',
        primaryColor: kMainColor,
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistraionScreen.id: (context) => RegistraionScreen(),
        ForgotPasswordScreen.id: (context) => ForgotPasswordScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        AddEvent.id: (context) => AddEvent(),
        ViewEvent.id: (context) => ViewEvent(),
        ChooseEvent.id: (context) => ChooseEvent(),
        AddGuest.id: (context) => AddGuest(),
        ViewGuests.id: (context) => ViewGuests(),
        AddToDo.id: (context) => AddToDo(),
        ViewToDo.id: (context) => ViewToDo(),
        AddShoppingList.id: (context) => AddShoppingList(),
        ViewShoppingList.id: (context) => ViewShoppingList(),
        Test.id: (context) => Test(),
        OnBoardScreen.id: (context) => OnBoardScreen()
      },
    );
  }
}
