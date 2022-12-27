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
    if (categoria == 'Favoritos') {
      if (sites.isEmpty) {
        return Column(
          children: [
            (const Text('Aun no tienes favoritos agregados')),
            SizedBox(
                height: 150,
                width: 100,
                child: Image.asset('assets/empty.png')),
          ],
        );
      } else {
        List<SiteCard> sitesCard = [];
        for (var element in sites) {
          final card = SiteCard(icon: (Icons.delete), site: element);
          sitesCard.add(card);
        }
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 35,
                  child: Text(
                    categoria,
                    style: Styles.textStyleCl,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.72,
                ),
                itemBuilder: (context, index) => sitesCard[index],
                itemCount: sitesCard.length,
              ),
            )
          ],
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
