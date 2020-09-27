import 'package:event_planner/classes/RouteArguments.dart';
import 'package:event_planner/components/Toast.dart';
import 'package:event_planner/constants.dart';
import 'package:event_planner/screens/event/add_event.dart';
import 'package:event_planner/screens/guest/add_guest.dart';
import 'package:event_planner/screens/onboard/onboard_screen.dart';
import 'package:event_planner/screens/shoppinglist/view_shoppinglsit.dart';
import 'package:event_planner/screens/test.dart';
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
  final String id;

  const MainDrawer({Key key, this.id}) : super(key: key);
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

  void makeRoutes(BuildContext context, RouteArguments arg, String changeId) {
    Navigator.pop(context);
    if (widget.id != changeId) {
      if (widget.id == HomeScreen.id) {
        Navigator.pushNamed(context, changeId, arguments: arg);
      } else {
        Navigator.popAndPushNamed(context, changeId, arguments: arg);
      }
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
              backgroundImage: loggedInUser.photoURL != null
                  ? NetworkImage(loggedInUser.photoURL)
                  : null,
              backgroundColor: kMainColor,
              child: Visibility(
                visible: loggedInUser.photoURL == null,
                child: Text(
                  "D",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                  ),
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
              makeRoutes(context, null, HomeScreen.id);
            },
            title: "Home",
          ),
          DrawerListTile(
            icon: Icons.event,
            onPress: () {
              makeRoutes(context, null, AddEvent.id);
            },
            title: "Event",
          ),
          DrawerListTile(
            icon: Icons.person_add,
            onPress: () {
              makeRoutes(
                  context,
                  RouteArguments(
                      routeScreen: ViewGuests.id, subTitle: 'add guests'),
                  ChooseEvent.id);
            },
            title: "Guests",
          ),
          DrawerListTile(
            icon: Icons.done,
            onPress: () {
              makeRoutes(
                  context,
                  RouteArguments(routeScreen: ViewToDo.id, subTitle: 'To-Do'),
                  ChooseEvent.id);
            },
            title: "Add TO-DO",
          ),
          DrawerListTile(
            icon: Icons.shopping_cart,
            onPress: () {
              makeRoutes(
                  context,
                  RouteArguments(
                      routeScreen: ViewShoppingList.id,
                      subTitle: 'Shopping List'),
                  ChooseEvent.id);
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
            onPress: () {
              Navigator.pushNamed(context, OnBoardScreen.id);
            },
            title: "Dashboard",
          ),
          DrawerListTile(
            icon: Icons.monetization_on,
            onPress: () {
              _auth.signOut();
              Navigator.pushReplacementNamed(context, LoginScreen.id);
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
