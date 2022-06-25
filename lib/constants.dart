import 'package:flutter/material.dart';

const kTextFieldDecoration = InputDecoration(
  fillColor: Color.fromARGB(255, 201, 22, 22),
  hintText: 'Enter your value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color.fromARGB(255, 38, 39, 41), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color.fromARGB(255, 35, 36, 39), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);


const mobileWidth = 600;