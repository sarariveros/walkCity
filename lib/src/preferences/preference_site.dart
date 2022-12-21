import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

  static bool _theme = false;
  static String _img = '';
  static String _usuario = ' ';
  static String _password = ' ';
  static String _telefono = ' ';
  static String _titulo = '';

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
    //clean();
  }

  //GET & SET

  //theme
  static bool get theme {
    return _prefs.getBool("theme") ?? _theme;
  }

  static set theme(bool theme) {
    _theme = theme;
    _prefs.setBool("theme", theme);
  }

  static String get img {
    return _prefs.getString("img") ?? _img;
  }

  static set img(String img) {
    _img = img;
    _prefs.setString("img", img);
  }

  static String get usuario {
    return _prefs.getString("usuario") ?? _usuario;
  }

  static set usuario(String usuario) {
    _usuario = usuario;
    _prefs.setString("usuario", usuario);
  }

  static String get password {
    return _prefs.getString("password") ?? _password;
  }

  static set password(String password) {
    _password = password;
    _prefs.setString("password", password);
  }

  static String get telefono {
    return _prefs.getString("telefono") ?? _telefono;
  }

  static set telefono(String telefono) {
    _telefono = telefono;
    _prefs.setString("telefono", telefono);
  }

  static clean() {
    _prefs.setString("telefono", '');
    _prefs.setString("password", '');
    _prefs.setString("usuario", '');
  }

  static String get titulo {
    return _prefs.getString('titulo') ?? _titulo;
  }

  static set titulo(String titulo) {
    _titulo = _titulo;
    _prefs.setString('titulo', titulo);
  }
}