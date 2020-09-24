import 'package:event_planner/classes/RouteArguments.dart';
import 'package:event_planner/constants.dart';
import 'package:event_planner/screens/event/add_event.dart';
import 'package:event_planner/screens/guest/add_guest.dart';
import 'package:event_planner/screens/shoppinglist/view_shoppinglsit.dart';
import 'package:event_planner/screens/todolist/add_todo.dart';
import 'package:event_planner/screens/event/choose_event_screen.dart';
import 'package:event_planner/screens/home_screen.dart';
import 'package:event_planner/screens/auth/login_screen.dart';
import 'package:event_planner/screens/guest/view_guests.dart';
import 'package:event_planner/screens/todolist/view_todo.dart';
import 'package:event_planner/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

User loggedInUser;

class _MainDrawerState extends State<MainDrawer> {
  final _auth = FirebaseAuth.instance;
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print('error $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            margin: EdgeInsets.only(
              bottom: 20.0,
            ),
            accountName: Text(
              loggedInUser.displayName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(
              loggedInUser.email,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: kMainColor,
              child: Text(
                "D",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                ),
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/drawer_header_background.png'),
                fit: BoxFit.fill,
              ),
              color: kMainColor,
            ),
          ),
          DrawerListTile(
            icon: Icons.home,
            onPress: () {
              Navigator.pushNamed(context, HomeScreen.id);
            },
            title: "Home",
          ),
          DrawerListTile(
            icon: Icons.event,
            onPress: () {
              Navigator.pushNamed(context, AddEvent.id);
            },
            title: "Event",
          ),
          DrawerListTile(
            icon: Icons.person_add,
            onPress: () {
              Navigator.pushNamed(
                context,
                ChooseEvent.id,
                arguments: RouteArguments(
                    routeScreen: AddGuest.id, subTitle: 'add guests'),
              );
            },
            title: "Add Guests",
          ),
          DrawerListTile(
            icon: Icons.done,
            onPress: () {
              Navigator.pushNamed(
                context,
                ChooseEvent.id,
                arguments:
                    RouteArguments(routeScreen: ViewToDo.id, subTitle: 'To-Do'),
              );
            },
            title: "Add TO-DO",
          ),
          DrawerListTile(
            icon: Icons.shopping_cart,
            onPress: () {
              Navigator.pushNamed(
                context,
                ChooseEvent.id,
                arguments: RouteArguments(
                    routeScreen: ViewShoppingList.id,
                    subTitle: 'Shopping List'),
              );
            },
            title: "Shopping List",
          ),
          DrawerListTile(
            icon: Icons.monetization_on,
            onPress: () {},
            title: "Add budget",
          ),
          SizedBox(
            height: 30.0,
          ),
          Divider(
            color: Colors.black,
          ),
          DrawerListTile(
            icon: Icons.dashboard,
            onPress: () {},
            title: "Dashboard",
          ),
          DrawerListTile(
            icon: Icons.person_add,
            onPress: () {
              Navigator.pushNamed(
                context,
                ChooseEvent.id,
                arguments: RouteArguments(
                    routeScreen: ViewGuests.id, subTitle: 'View guests'),
              );
            },
            title: "View Guests",
          ),
          DrawerListTile(
            icon: Icons.monetization_on,
            onPress: () {
              _auth.signOut();
              Navigator.popAndPushNamed(context, LoginScreen.id);
            },
            title: "Sign out",
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final IconData icon;
  final Function onPress;
  final String title;

  const DrawerListTile({Key key, this.icon, this.onPress, this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: kMainColor,
        size: 36.0,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.0,
        ),
      ),
      onTap: onPress,
    );
  }
}
