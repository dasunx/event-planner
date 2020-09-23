import 'package:flutter/material.dart';

const Color kMainColor = Color.fromRGBO(143, 148, 251, 1);
const Color kMainColorOpacity = Color.fromRGBO(143, 148, 251, 0.7);

const kTitleTextStyle = TextStyle(
  color: Colors.black,
  fontSize: 24,
  fontWeight: FontWeight.bold,
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value.',
  labelText: 'Enter a value',
  hintStyle: TextStyle(color: Colors.black45),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kMainColor, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kMainColor, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),
);
