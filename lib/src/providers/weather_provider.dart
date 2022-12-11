import 'package:flutter/material.dart';

class SWeatherProvider extends ChangeNotifier {
  bool showWeather = true;
  bool get estado => showWeather;
  void changeVisibility() {
    showWeather = !showWeather;
    notifyListeners();
  }
}
