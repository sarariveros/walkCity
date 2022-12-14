import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

import 'package:walkcity/src/models/index.dart';

class SBSite extends ChangeNotifier {
  Client client = Client();
  List<Site> sites = [];
  final _urlCat =
      'https://kowzlncfrrqjcojxapmv.supabase.co/rest/v1/Categoria?select=*';
  final _apiKeyCat =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imtvd3psbmNmcnJxamNvanhhcG12Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEwNjgzMDQsImV4cCI6MTk4NjY0NDMwNH0.uyGGT_QVwemGWQY-IEsIVPuEC0itGhQ19l4sjJkc1gQ ';
  final _authCat =
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imtvd3psbmNmcnJxamNvanhhcG12Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEwNjgzMDQsImV4cCI6MTk4NjY0NDMwNH0.uyGGT_QVwemGWQY-IEsIVPuEC0itGhQ19l4sjJkc1gQ ';

  final _urlSite =
      'https://kowzlncfrrqjcojxapmv.supabase.co/rest/v1/Sitio?id_categoria=eq.';
  final _apikeySite =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imtvd3psbmNmcnJxamNvanhhcG12Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEwNjgzMDQsImV4cCI6MTk4NjY0NDMwNH0.uyGGT_QVwemGWQY-IEsIVPuEC0itGhQ19l4sjJkc1gQ';
  final _authSite =
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imtvd3psbmNmcnJxamNvanhhcG12Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEwNjgzMDQsImV4cCI6MTk4NjY0NDMwNH0.uyGGT_QVwemGWQY-IEsIVPuEC0itGhQ19l4sjJkc1gQ';

  Future<List<Category>> getcategorias() async {
    final response = await client.get(Uri.parse(_urlCat),
        headers: {'apikey': _apiKeyCat, 'Authorization': _authCat});
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      List<Category> categorias = [];
      for (var element in jsonData) {
        categorias.add(Category.fromMap(element));
      }

      return categorias;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load categories');
    }
  }

  Future<List<Site>> getSiteByCat(int id) async {
    final response = await client.get(
        Uri.parse('$_urlSite + ${id.toString()} + &select=*'),
        headers: {'apikey': _apikeySite, 'Authorization': _authSite});
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      List<Site> sitesCat = [];

      // print(jsonData);
      for (var element in jsonData) {
        sitesCat.add(Site.fromMap(element));
      }

      return sitesCat;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load Sites');
    }
  }

  Future getAllSites() async {
    final response = await client.get(
        Uri.parse(
            'https://kowzlncfrrqjcojxapmv.supabase.co/rest/v1/Sitio?select=*'),
        headers: {'apikey': _apikeySite, 'Authorization': _authSite});
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      List<Site> sitesTemp = [];
      for (var element in jsonData) {
        sitesTemp.add(Site.fromMap(element));
      }
      sites = sitesTemp;

      notifyListeners();
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load Sites');
    }
  }
}
