import 'package:event_planner/constants.dart';
import 'package:flutter/material.dart';

class WideStyledBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Function onPress;
  WideStyledBtn({this.icon, this.label, this.color, this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: kMainColor,
                      blurRadius: 1.5,
                      spreadRadius: 0.01,
                    ),
                  ]),
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    icon,
                    size: 40.0,
                    color: color,
                  ),
                  SizedBox(
                    width: 25.0,
                  ),
                  Text(
                    label,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
