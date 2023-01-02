import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:walkcity/src/preferences/preferences.dart';

class AuthService extends ChangeNotifier {
  final String urlbase =
      'https://kowzlncfrrqjcojxapmv.supabase.co/rest/v1/DatosUsuario';
  final String _baseUrl = 'kowzlncfrrqjcojxapmv.supabase.co';
  final String _apikey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imtvd3psbmNmcnJxamNvanhhcG12Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEwNjgzMDQsImV4cCI6MTk4NjY0NDMwNH0.uyGGT_QVwemGWQY-IEsIVPuEC0itGhQ19l4sjJkc1gQ';
  final String autorization =
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imtvd3psbmNmcnJxamNvanhhcG12Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEwNjgzMDQsImV4cCI6MTk4NjY0NDMwNH0.uyGGT_QVwemGWQY-IEsIVPuEC0itGhQ19l4sjJkc1gQ';



  //REGISTRAR NUEVO USUARIO
  Future<String?> createUser(String email, String password, String name) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };

    final url = Uri.https(_baseUrl, '/auth/v1/signup', {'apikey': _apikey});
    final response = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodeResponse = json.decode(response.body);

    if (decodeResponse.containsKey('id')) {
      Preferences.identificador = decodeResponse["id"];
      crearDataUser(name, decodeResponse["id"], email);
      return null;
    } else {
      return "error";
    }
  }

  //LOGIN
  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };

    final url = Uri.https(_baseUrl, '/auth/v1/token',
        {'grant_type': 'password', 'apikey': _apikey});
    final response = await http.post(url, body: json.encode(authData));
    final decodeResponse = json.decode(response.body);

    if (decodeResponse.containsKey('access_token')) {
      Preferences.identificador = decodeResponse["user"]["id"];
      Preferences.token = decodeResponse['access_token'];
      return null;
    } else {
      return "error";
    }
  }

  //TRAER DATOS DEL USUARIO
  Future traerDataUser() async {
    final url = Uri.parse('$urlbase?usuario=eq.${Preferences.identificador}');

    Map<String, String> header = {
      'apikey': _apikey,
      'Authorization': autorization,
      'Content-Type': 'application/json',
      'Prefer': 'return=minimal'
    };

    final response = await http.get(url, headers: header);
    final decodeResponse = json.decode(response.body)[0];

    Preferences.name = decodeResponse["nombre"];
    Preferences.years =
        decodeResponse["edad"] == null ? "" : decodeResponse["edad"].toString();
    Preferences.country = decodeResponse["origen"] ?? "";
    Preferences.image = decodeResponse["image"] ?? "";

    return decodeResponse;
  }

  //CREAR DATOS DEL USUARIO
  Future crearDataUser(String name, String uuid, String email) async {
    final url = Uri.parse(urlbase);
    final String msg;

    Map<String, String> header = {
      'apikey': _apikey,
      'Authorization': autorization,
      'Content-Type': 'application/json',
      'Prefer': 'return=minimal'
    };

    final body = jsonEncode({
      "usuario": uuid,
      "nombre": name,
      "email": email,
    });

    final response = await http.post(url, body: body, headers: header);

    if (response.statusCode != 201) {
      msg = 'MSG=> NO SE GUARDO CORRECTAMENTE';
    } else {
      msg = 'MSG=> SE GUARDO CORRECTAMENTE';
    }
    return msg;
  }

  //CERRAR SESION
  Future cerrarSesion() async {
    Preferences.token = "";
    return;
  }

  //VERIFICAR TOKEN
  Future<String> leerToken() async {
    return Preferences.token;
  }
}
