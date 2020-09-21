import 'package:event_planner/constants.dart';
import 'package:event_planner/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    Key key,
  }) : super(key: key);

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
              "Dasun Ekanayake",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(
              "mwdasun@gmail.com",
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
            icon: Icons.event,
            onPress: () {},
            title: "Add Event",
          ),
          DrawerListTile(
            icon: Icons.person_add,
            onPress: () {},
            title: "Add Guests",
          ),
          DrawerListTile(
            icon: Icons.done,
            onPress: () {},
            title: "Add TO-DO",
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
          )
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
