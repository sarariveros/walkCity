import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkcity/src/models/site_model.dart';
import 'package:walkcity/src/providers/index.dart';
import 'package:walkcity/src/ui/widgets/index.dart';

class FavoritosScreen extends StatelessWidget {
  const FavoritosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Site> showFavorites() {
      final favorites = Provider.of<SiteProvider>(context);
      favorites.queryAll();
      //print(favorites.sites[1].id);
      return favorites.sites;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: ListSites(categoria: 'Favoritos', sites: showFavorites()),
      ),
    );
  }
}
