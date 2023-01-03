import 'package:flutter/material.dart';
import 'package:walkcity/src/models/index.dart';
import 'package:walkcity/src/styles/style.dart';
import 'package:walkcity/src/ui/widgets/index.dart';

class ListSites extends StatelessWidget {
  final String categoria;

  final List<Site> sites;
  const ListSites({super.key, required this.categoria, required this.sites});

  @override
  Widget build(BuildContext context) {
    final msgVacio = [
      {
        'msg': 'Aun no tienes favoritos por visitar',
        'image': 'assets/empty.png',
      },
      {
        'msg': 'Aun no haz visitado ningun lugar',
        'image': 'assets/empty.png',
      }
    ];
    if (categoria == '0' || categoria == '1') {
      int index = int.parse(categoria);
      if (sites.isEmpty) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              (Text(msgVacio[index]['msg']!)),
              SizedBox(
                  height: 150,
                  width: 100,
                  child: Image.asset(msgVacio[index]['image']!)),
            ],
          ),
        );
      } else {
        List<SiteCardFav> sitesCard = [];
        for (var element in sites) {
          final card = SiteCardFav(icon: (Icons.delete), site: element);
          sitesCard.add(card);
        }
        return GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 0,
            childAspectRatio: 0.73,
          ),
          itemBuilder: (context, index) => sitesCard[index],
          itemCount: sitesCard.length,
        );
      }
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Text(
          categoria,
          style: Styles.textStyleCl,
        ),
      ),
      SizedBox(
        width: double.infinity,
        height: 232, //MediaQuery.of(context).size.height / 2.55,
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
                  icon: Icons.favorite,
                );
              }),
        ),
      ),
    ]);
  }
}
