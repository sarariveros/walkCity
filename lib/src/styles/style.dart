import 'package:flutter/material.dart';

class Styles {
  static Color firstColor = Color.fromRGBO(255, 204, 0, .7);
  static Color secondColor = Color.fromRGBO(228, 36, 36, .7);
  static Color thirdColor = Colors.black;

  static Color textColor = Colors.black;
  static Color sitecardColor = Colors.white;
  static Color textColorCl = const Color(0xff96969A);
  static TextStyle textStyle =
      const TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
  static TextStyle textStyleB =
      const TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
  static TextStyle textStyleCl = TextStyle(fontSize: 15, color: textColorCl);
  static TextStyle sitecardTStyle = TextStyle(
      fontSize: 15,
      color: sitecardColor,
      height: 1.2,
      fontWeight: FontWeight.bold);

  static TextStyle sitecardDStyle =
      TextStyle(fontSize: 11, color: sitecardColor);
  static TextStyle sitecardBStyle =
      TextStyle(fontSize: 12, color: sitecardColor);

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
