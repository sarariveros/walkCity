import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

  static String _identificador = '';

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
}