import 'package:flutter/material.dart';
import 'package:walkcity/src/models/index.dart';
import 'package:walkcity/src/styles/style.dart';
import 'package:walkcity/src/ui/widgets/index.dart';

class ListSites extends StatelessWidget {
  final String categoria;

  const ListSites({super.key, required this.categoria, required this.sites});
  final List<Site> sites;

  @override
  Widget build(BuildContext context) {
    // final favorites = Provider.of<SiteProvider>(context, listen: true);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        categoria,
        style: Styles.textStyleCl,
      ),
      SizedBox(
        width: 500,
        height: 250,
        child: AnimatedRotation(
          turns: 1,
          duration: const Duration(seconds: 1),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: sites.length,
              shrinkWrap: false,
              itemBuilder: (BuildContext context, index) {
                final data = sites[index];
                return SiteCard(
                  site: data,
                  icon: (categoria != 'Favoritos')
                      ? Icons.favorite_border
                      : Icons.remove_circle_outline,
                );
              }),
        ),
      ),
    ]);
  }
}
