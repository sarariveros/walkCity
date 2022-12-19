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
      return favorites.sites;
    }

    final List<Site> listaFavoritos = showFavorites();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: [
            ListSites(categoria: 'Favoritos', sites: showFavorites()),
          ],
        ),

        //bottomNavigationBar: MenuWidget(),
      ),
    );
  }
}
