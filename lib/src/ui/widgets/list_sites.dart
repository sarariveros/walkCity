import 'package:flutter/material.dart';
import 'package:walkcity/src/styles/style.dart';
import 'package:walkcity/src/ui/widgets/index.dart';

class ListSites extends StatelessWidget {
  final String clasificacion;
  //List<>

  const ListSites({super.key, required this.clasificacion});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        clasificacion,
        style: Styles.textStyleCl,
      ),
      SizedBox(
        width: 500,
        height: 250,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: const [
            SiteCard(
                nombre: 'Catedral de ayacucho', descripcion: ' descripcion '),
            SiteCard(
                nombre: 'Catedral de ayacucho', descripcion: 'descripcion'),
            SiteCard(
                nombre: 'Catedral de ayacucho', descripcion: 'descripcion'),
          ],
        ),
      ),
    ]);
  }
}
