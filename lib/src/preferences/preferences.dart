import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

  static String _identificador = '';
  static String _name = '';
  static String _years = '';
  static String _country = '';

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  //GET & SET

  //UUID
  static String get identificador {
    return _prefs.getString('identificador') ?? _identificador;
  }

  static set identificador(String identificador) {
    _identificador = identificador;
    _prefs.setString('identificador', identificador);
  }

  //NAME
  static String get name {
    return _prefs.getString('name') ?? _name;
  }

  static set name(String name) {
    _name = name;
    _prefs.setString('name', name);
  }

  //YEARS
  static String get years {
    return _prefs.getString('years') ?? _years;
  }

  static set years(String years) {
    _years = years;
    _prefs.setString('years', years);
  }

  //YEARS
  static String get country {
    return _prefs.getString('country') ?? _country;
  }

  static set country(String country) {
    _country = country;
    _prefs.setString('country', country);
  }
}