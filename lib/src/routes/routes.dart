import 'package:flutter/material.dart';
import 'package:walkcity/src/ui/screens/index.dart';

class MyRoutes {
  static const String rHome = '/home';

  static const String rPerfil = '/perfil';

  static const String rAjustes = '/ajustes';
  static const String rLogin = '/login';
  static const String rRegistro = '/registro';
  static const String rVerify = '/verify';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ('/home'):
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case ('/perfil'):
      //return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case ('/login'):
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case ('/registro'):
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case ('/verify'):
      // return MaterialPageRoute(builder: (_) => const VerifyAuthScreen());
      case ('/ajustes'):
      // return MaterialPageRoute(
      //     builder: (_) =>
      //         const ConfigScreen()); //subguion en lugar de poner context

      default:
        return MaterialPageRoute(builder: (_) => const ErrorScreen());
    }
  }
}
