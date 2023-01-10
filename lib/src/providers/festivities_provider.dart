import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:walkcity/src/models/festivity_models.dart';
import 'package:http/http.dart' show Client;


class SBFestivity extends ChangeNotifier{
  Client client = Client();
  List<Festivity> festivities=[];
  
  final _urlFest= 'https://kowzlncfrrqjcojxapmv.supabase.co/rest/v1/Festividades?select=*';
  final _apiKeyFest="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imtvd3psbmNmcnJxamNvanhhcG12Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEwNjgzMDQsImV4cCI6MTk4NjY0NDMwNH0.uyGGT_QVwemGWQY-IEsIVPuEC0itGhQ19l4sjJkc1gQ";
  final _authFest="Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imtvd3psbmNmcnJxamNvanhhcG12Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEwNjgzMDQsImV4cCI6MTk4NjY0NDMwNH0.uyGGT_QVwemGWQY-IEsIVPuEC0itGhQ19l4sjJkc1gQ";


  Future getFestivities() async {
    final response = await client.get(
        Uri.parse(
           _urlFest),
        headers: {'apikey': _apiKeyFest, 'Authorization': _authFest});
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      List<Festivity> festivitiesTemp = [];
      for (var element in jsonData) {
        festivitiesTemp.add(Festivity.fromMap(element));
      }
      festivities = festivitiesTemp;

      notifyListeners();
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load Sites');
    }
  }
}
