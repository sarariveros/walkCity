import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkcity/src/providers/map_provider.dart';


class MapPage extends StatelessWidget {
  const MapPage({super.key});


  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<MapProvider>(context);
    return Scaffold(

      body: Center(
          child: Column(
        children: [
          Text("Ir al mapa"),
          FloatingActionButton(onPressed: () {
            mapProvider.goMap();
          },
          child: Icon(Icons.gps_fixed_rounded),
          )
        ],
      )),

    );
  }
}
