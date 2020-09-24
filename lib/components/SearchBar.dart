import 'package:event_planner/constants.dart';
import 'package:flutter/material.dart';

TextField buildSearch(FocusNode myFocusNode, String hintText, Function onChange,
    TextEditingController myCon) {
  return TextField(
    controller: myCon,
    focusNode: myFocusNode,
    onChanged: onChange,
    decoration: InputDecoration(
      labelText: "Search",
      hintText: hintText,
      prefixIcon: Icon(
        Icons.search,
        color: Colors.grey,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: kMainColorOpacity,
          width: 1.0,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            10.0,
          ),
        ),
      ),
      focusedBorder: new OutlineInputBorder(
        borderRadius: new BorderRadius.circular(
          10.0,
        ),
        borderSide: BorderSide(
          color: kMainColor,
          width: 2.0,
        ),
      ),
    ),
  );
}
