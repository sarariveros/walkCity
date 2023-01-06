import 'package:flutter/material.dart';

class CategoryIcon {
//funcion Para el icono
  static Icon iconCategory(category) {
    Icon icon = const Icon(
      Icons.favorite,
      color: Color.fromARGB(255, 217, 27, 90),
    );
    switch (category) {
      case "1":
        icon = const Icon(
          Icons.church,
          color: Color.fromARGB(255, 215, 147, 147),
        );
        break;
      case "2":
        icon = const Icon(
          Icons.park,
          color: Colors.green,
        );
        break;
      case "3":
        icon = const Icon(
          Icons.museum_sharp,
          color: Colors.orangeAccent,
        );
        break;
      case "4":
        icon = const Icon(
          Icons.home_work,
          color: Color.fromARGB(255, 218, 60, 49),
        );
        break;
      default:
        icon;
    }
    return icon;
  }
}
