import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' show Client;
import 'package:walkcity/src/models/favorito_model.dart';
import 'package:walkcity/src/preferences/preferences.dart';
import 'dart:convert';

import 'package:walkcity/src/services/index.dart';

class SBFavorite extends ChangeNotifier {
  Client client = Client();

  List<Favorito> favoritos = [];
  // List<Favorito> favToVisit = [];
  // List<Favorito> favVisited = [];

  final _apiKeyFav =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imtvd3psbmNmcnJxamNvanhhcG12Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEwNjgzMDQsImV4cCI6MTk4NjY0NDMwNH0.uyGGT_QVwemGWQY-IEsIVPuEC0itGhQ19l4sjJkc1gQ';
  final _authfav =
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imtvd3psbmNmcnJxamNvanhhcG12Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEwNjgzMDQsImV4cCI6MTk4NjY0NDMwNH0.uyGGT_QVwemGWQY-IEsIVPuEC0itGhQ19l4sjJkc1gQ';

  Future getFavByUser() async {
    // favoritos.clear();
    // favToVisit.clear();
    // favVisited.clear();
    final response = await client.get(
        Uri.parse(
            'https://kowzlncfrrqjcojxapmv.supabase.co/rest/v1/Favorito?usuario=eq.${Preferences.identificador}&select=*'),
        headers: {'apikey': _apiKeyFav, 'Authorization': _authfav});
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      List<Favorito> favTemp = [];
      for (var element in jsonData) {
        favTemp.add(Favorito.fromMap(element));
      }
      favoritos = favTemp;

      // favToVisit.addAll(favoritos.where((fav) => fav.estado == 0).toList());

      // favVisited.addAll(favoritos.where((fav) => fav.estado == 1).toList());

      notifyListeners();
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load favorites');
    }
  }

  Future updateFav(Favorito fav) async {
    final body = jsonEncode({"estado": 1});
    final response = await client.patch(
        Uri.parse(
            'https://kowzlncfrrqjcojxapmv.supabase.co/rest/v1/Favorito?id_site=eq.${fav.id_site}&usuario=eq.${fav.usuario}'),
        headers: {
          'apikey': _apiKeyFav,
          'Authorization': _authfav,
          'Content-Type': 'application/json',
          'Prefer': 'return=minimal'
        },
        body: body);
    if (response.statusCode == 200 || response.statusCode == 204) {
      // String body = utf8.decode(response.bodyBytes);
      // final jsonData = jsonDecode(body);
      // favToVisit.remove(fav);
      // favVisited.add(fav);
      notifyListeners();
    } else {
      // If that call was not successful, throw an error.
      print(response.statusCode);
      throw Exception('Failed to update favorite');
    }
  }

  Future<String> addFavorite(Favorito fav) async {
    final String msg;

    final body = jsonEncode(
        {"id_site": fav.id_site, "estado": 0, "usuario": fav.usuario});

    final url =
        Uri.parse('https://kowzlncfrrqjcojxapmv.supabase.co/rest/v1/Favorito');
    final response = await client.post(body: body, url, headers: {
      'apikey': _apiKeyFav,
      'Authorization': _authfav,
      'Content-Type': 'application/json',
      'Prefer': 'return=minimal'
    });
    if (response.statusCode != 201) {
      msg = 'No se pudo agregar';
    } else {
      favoritos.add(fav);
      msg = 'Añadido a Favoritos';
      notifyListeners();
    }
    NotificationServices.showSnackbar(msg, Icons.favorite_outlined);
    return msg;
  }

  Future<String> removeFavorite(Favorito fav) async {
    final String msg;

    final url = Uri.parse(
        'https://kowzlncfrrqjcojxapmv.supabase.co/rest/v1/Favorito?id_site=eq.${fav.id_site.toString()}&usuario=eq.${fav.usuario}');
    final response = await client.delete(url, headers: {
      'apikey': _apiKeyFav,
      'Authorization': _authfav,
    });
    if (response.statusCode != 204) {
      msg = 'No se pudo eliminar';
    } else {
      favoritos.remove(fav);
      msg = 'Quitado de Favoritos';
      notifyListeners();
    }
    NotificationServices.showSnackbar(msg, Icons.heart_broken);
    return msg;
  }
}
