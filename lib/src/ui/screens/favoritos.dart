import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkcity/src/models/index.dart';
import 'package:walkcity/src/providers/index.dart';
import 'package:walkcity/src/styles/style.dart';
import 'package:walkcity/src/ui/widgets/index.dart';

class FavoritosScreen extends StatelessWidget {
  const FavoritosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Site> showFavorites(int estado) {
      final sbFav = Provider.of<SBFavorite>(context);
      sbFav.getFavByUser();
      final sbSite = Provider.of<SBSite>(context);
      sbSite.getAllSites();
      List<Favorito> favoritos = sbFav.favoritos;
      List<Site> allsites = sbSite.sites;
      List<Site> favSites = [];

      for (var fav in favoritos) {
        favSites.addAll(allsites
            .where((site) => site.id == fav.id_site && fav.estado == estado)
            .toList());
      }

      return favSites;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DefaultTabController(
        length: 2,
        child: Column(children: [
          TabBar(
              unselectedLabelColor: Styles.firstColor,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Styles.firstColor),
              tabs: [
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Styles.firstColor, width: 1)),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text("POR VISITAR"),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Styles.firstColor, width: 1)),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text("VISITADOS"),
                    ),
                  ),
                ),
              ]),

          Expanded(
            flex: 1,
            child: TabBarView(
              viewportFraction: 1,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ListSites(categoria: '0', sites: showFavorites(0)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ListSites(categoria: '1', sites: showFavorites(1)),
                ),
              ],
            ),
          ),
          // ListSites(categoria: 'Favoritos', sites: showFavorites()),
        ]),
      ),
    );
  }
}
