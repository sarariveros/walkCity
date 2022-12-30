import 'package:flutter/material.dart';

class Styles {
  static Color firstColor = const Color.fromRGBO(255, 204, 0, .7);
  static Color secondColor = const Color.fromRGBO(228, 36, 36, .7);
  static Color thirdColor = Colors.black;

  static Color textColor = Colors.black;
  static Color sitecardColor = const Color.fromARGB(255, 139, 137, 137);
  static Color textColorCl = const Color.fromARGB(255, 18, 95, 105);
  static TextStyle textStyle =
      const TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
  static TextStyle textStyleB =
      const TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
  static TextStyle textStyleCl = TextStyle(fontSize: 15, color: textColorCl);
  static TextStyle sitecardTStyle = TextStyle(
      fontSize: 12,
      color: sitecardColor,
      // height: 1.2,
      fontWeight: FontWeight.bold);

  static TextStyle sitecardDStyle =
      TextStyle(fontSize: 10, color: sitecardColor);
  static TextStyle sitecardBStyle =
      TextStyle(fontSize: 10, color: sitecardColor);

  static TextStyle title = const TextStyle(
      fontSize: 26, color: Colors.grey, fontWeight: FontWeight.bold);
  //////////weather widget////
  static TextStyle wdataTextStyle = TextStyle(
      fontSize: 15,
      color: sitecardColor,
      height: 1,
      fontWeight: FontWeight.bold);
  static TextStyle wdataTempStyle = TextStyle(
      fontSize: 40,
      color: sitecardColor,
      height: 2,
      fontWeight: FontWeight.bold);
  static TextStyle wTitleStyle = TextStyle(
      fontSize: 16,
      color: sitecardColor,
      height: 2,
      fontWeight: FontWeight.w900);
}
