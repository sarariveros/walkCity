import 'package:flutter/material.dart';

class Styles {
  static Color firstColor = Color.fromRGBO(20, 200, 226, 1);
  static Color secondColor = Color.fromARGB(255, 215, 215, 210);
  static Color thirdColor = Colors.black;

  static Color textColor = Color.fromRGBO(53, 82, 88, 1);
  static Color sitecardColor = Colors.white;
  //const Color.fromARGB(255, 139, 137, 137);
  static Color textColorCl = const Color.fromARGB(255, 18, 95, 105);

  static TextStyle textStyle =
      const TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
  static TextStyle textStyleB =
      const TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
  static TextStyle textStyleCl = TextStyle(fontSize: 15, color: thirdColor);
  static TextStyle sitecardTStyle = TextStyle(
      fontSize: 12,
      color: thirdColor,
      // height: 1.2,
      fontWeight: FontWeight.bold);

  static TextStyle sitecardDStyle =
      TextStyle(fontSize: 10, color: sitecardColor);
  static TextStyle sitecardBStyle =
      TextStyle(fontSize: 10, color: sitecardColor);

  static TextStyle title = const TextStyle(
      fontSize: 26, color: Colors.black, fontWeight: FontWeight.bold);
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

  // Diego
  // ignore: unused_element
  static InputDecoration buildDecoration(
      {final String? hintText, final Icon? sufIcon}) {
    return InputDecoration(
      suffixIcon: sufIcon,
      fillColor: const Color.fromARGB(255, 240, 240, 240),
      hintStyle: const TextStyle(color: Colors.grey),
      contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.transparent)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.transparent)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.transparent)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      hintText: hintText,
      filled: true,
    );
  }

  static TextStyle tutorialNumber = TextStyle(
      fontSize: 40,
      color: sitecardColor,
      height: 2,
      fontWeight: FontWeight.w900);
  static TextStyle tutorialText = TextStyle(
      fontSize: 17,
      color: sitecardColor,
      height: 1.5,
      fontWeight: FontWeight.w900);
}
