import 'package:flutter/material.dart';

const Color kMainColor = Color.fromRGBO(143, 148, 251, 1);
const Color kMainColorOpacity = Color.fromRGBO(143, 148, 251, 0.7);
const kSecondaryColor = Color(0xFF1ad1d1);
const kSecondartColorOpacity = Color.fromRGBO(26, 209, 209, 0.7);

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

const kLabelTextStyle = TextStyle(
  fontSize: 16,
  color: Colors.white,
);

const kHeaderTextStyle = TextStyle(
  fontSize: 35,
  fontFamily: 'NotoSans',
  color: Colors.white,
  fontWeight: FontWeight.bold,
);
