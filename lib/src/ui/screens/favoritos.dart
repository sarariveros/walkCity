import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkcity/src/models/index.dart';
import 'package:walkcity/src/providers/index.dart';
import 'package:walkcity/src/ui/widgets/index.dart';

class FavoritosScreen extends StatelessWidget {
  const FavoritosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Site> showFavorites() {
      final sbFav = Provider.of<SBFavorite>(context);
      sbFav.getFavByUser();
      final sbSite = Provider.of<SBSite>(context);
      sbSite.getAllSites();
      List<Favorito> favoritos = sbFav.favoritos;
      List<Site> allsites = sbSite.sites;
      List<Site> favSites = [];

      for (var fav in favoritos) {
        favSites
            .addAll(allsites.where((site) => site.id == fav.id_site).toList());
      }

      return favSites;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: ListSites(categoria: 'Favoritos', sites: showFavorites()),
      ),
    );
  }
}
