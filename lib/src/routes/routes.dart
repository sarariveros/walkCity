import 'package:flutter/material.dart';
import 'package:walkcity/src/ui/screens/index.dart';
import 'package:walkcity/src/ui/screens/place.dart';

class MyRoutes {
  static const String rHome = '/home';
  static const String rPerfil = '/perfil';
  static const String rAjustes = '/ajustes';
  static const String rLogin = '/login';
  static const String rRegistro = '/registro';
  static const String rFavoritos = '/favoritos';
  static const String rPlace = '/place';
  static const String rVerify = '/verify';
  static const String rMap = "/map";
  static const String rComment = "/comment";
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ('/home'):
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case ('/perfil'):
        return MaterialPageRoute(builder: (_) => const PerfilScreen());
      case ('/login'):
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case ('/registro'):
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case ('/favoritos'):
        return MaterialPageRoute(builder: (_) => const FavoritosScreen());
      case ('/verify'):
        return MaterialPageRoute(builder: (_) => const VerifyAuthScreen());
      case ('/comment'):
        return MaterialPageRoute(builder: (_) => const ComentsPage());
      default:
        return MaterialPageRoute(builder: (_) => const ErrorScreen());
    }
  }
}
