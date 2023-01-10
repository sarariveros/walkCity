import 'package:flutter/material.dart';

class Styles {
  static Color firstColor = const Color.fromRGBO(20, 200, 226, 1);
  static Color secondColor = const Color.fromARGB(255, 215, 215, 210);
  static Color thirdColor = Colors.black;
  static Color fouthColor = Colors.white;
  static Color fithColor = const Color.fromRGBO(255, 204, 0, .7);

  static Color textColor = const Color.fromRGBO(53, 82, 88, 1);

  static Color textColorCl = const Color.fromARGB(255, 12, 67, 73);

  static TextStyle textStyle =
      const TextStyle(fontSize: 15, fontWeight: FontWeight.bold);
  static TextStyle textStyleB =
      const TextStyle(fontSize: 25, fontWeight: FontWeight.bold);
///////////////////////inicio/////////////////////////////////
/////////////////////////////////////////////////////////////
  static TextStyle titleAyacucho = const TextStyle(
      fontSize: 26, color: Colors.black, fontWeight: FontWeight.bold);

  ///////////////////////////////////////////////////////////
  ///////////////////////sites Cards////////
  static TextStyle textStyleCl = TextStyle(fontSize: 15, color: textColorCl);

  static TextStyle scNameStyle = const TextStyle(
      fontSize: 13,
      color: Color.fromARGB(255, 36, 35, 35),
      fontWeight: FontWeight.w300,
      letterSpacing: 0.5);

  static TextStyle scVerStyle = const TextStyle(
      //background: Color.white,
      fontSize: 12,
      letterSpacing: 0.8,
      color: Color.fromARGB(255, 17, 107, 44),
      fontWeight: FontWeight.bold);

  /////////////////////////////////////////////////////////
  //////////weather widget////
  ///////////////////////////////////////////////////////////

  static TextStyle wdataTextStyle = TextStyle(
      fontSize: 15, color: fouthColor, height: 1, fontWeight: FontWeight.bold);
  static TextStyle wdataTempStyle = TextStyle(
      fontSize: 40, color: fouthColor, height: 2, fontWeight: FontWeight.bold);
  static TextStyle wTitleStyle = TextStyle(
      fontSize: 16, color: fouthColor, height: 2, fontWeight: FontWeight.w900);

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

/////////////////////////////////////////////////////////////////////
/////////////////////tutorial page////////////////////////////////////
/////////////////////////////////////////////////////////////////////
  static TextStyle tutorialNumber = TextStyle(
      fontSize: 40, color: fouthColor, height: 2, fontWeight: FontWeight.w900);
  static TextStyle tutorialText = TextStyle(
      fontSize: 17,
      color: fouthColor,
      height: 1.5,
      fontWeight: FontWeight.w900);
}
