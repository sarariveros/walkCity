import 'package:flutter/cupertino.dart';
import 'package:walkcity/src/models/site_model.dart';
import 'package:walkcity/src/services/sqlite_site.dart';

class SiteProvider extends ChangeNotifier {
  final dbSite = DBSite.instance;
  List<Site> sites = [];
  void addSite({nombre, categoria, lon, lat, imagen}) async {
    Map<String, dynamic> row = {
      DBSite.columnNombre: nombre,
      DBSite.columnCategoria: categoria,
      DBSite.columnLon: lon,
      DBSite.columnLat: lat,
      DBSite.columnImagen: imagen,
    };
    Site site = Site.fromMap(row);
    final id = await dbSite.newFavorite(site);
    queryAll();
    // print(id);
    notifyListeners();
  }

  void queryAll() async {
    final allrows = await dbSite.queryAllFavorites();
    sites.clear();
    for (var element in allrows) {
      sites.add(Site.fromMap(element));
    }
    notifyListeners();
  }

  //borrar uno
  void delete(Site site) async {
    final item = await dbSite.deleteFavorite(site.id!);
    sites.remove(site);
    notifyListeners();
  }

  //borrar la lista/
  void deleteAll() async {
    final itemAll = await dbSite.deleteAllFavorites();
    sites.clear();
    notifyListeners();
  }

  void update({id, nombre, categoria, lon, lat, image}) async {
    Site site = Site(
        id: id,
        categoria: categoria,
        nombre: nombre,
        longitud: lon,
        latitud: lat,
        imagen: image);
    final rowupdate = await dbSite.updateFavorite(site);
    notifyListeners();
  }
}
