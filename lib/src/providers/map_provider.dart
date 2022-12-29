import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MapProvider extends ChangeNotifier{

  //metodo para el mapa
  void goMap(url)async{
    String urlEncode=Uri.encodeFull(url);
    if (await canLaunchUrlString(urlEncode)) {
      await launchUrlString(urlEncode,mode: LaunchMode.externalApplication);
    }

  }
}