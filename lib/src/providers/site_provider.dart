import 'package:flutter/cupertino.dart';
import 'package:walkcity/src/models/site_model.dart';
import 'package:walkcity/src/services/sqlite_site.dart';

class SiteProvider extends ChangeNotifier {
  final dbSite = DBSite.instance;
  List<Site> sites = [];
  void addSite({titulo, categoria, lon, lat, image}) async {
    Map<String, dynamic> row = {
      DBSite.columnTitulo: titulo,
      DBSite.columnCategoria: categoria,
      DBSite.columnLon: lon,
      DBSite.columnLat: lat,
      DBSite.columnImage: image,
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
  void delete(id) async {
    final item = await dbSite.deleteFavorite(id);
    notifyListeners();
  }

  //borrar la lista/
  void deleteAll() async {
    final itemAll = await dbSite.deleteAllFavorites();
    notifyListeners();
  }

  void update({id, titulo, categoria, lon, lat, image}) async {
    Site site =
        Site(id: id, categoria: categoria, lon: lon, lat: lat, imagen: image);
    final rowupdate = await dbSite.updateFavorite(site);
    notifyListeners();
  }
}
