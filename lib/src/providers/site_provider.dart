import 'package:flutter/cupertino.dart';
import 'package:walkcity/src/models/site_model.dart';
import 'package:walkcity/src/services/db_site.dart';

class SiteProvider extends ChangeNotifier {
  final dbSite = DBSite.instance;
  List<Site> sites = [];
  void addSite({titulo, descripcion, categoria, lon, lat, image}) async {
    Map<String, dynamic> row = {
      DBSite.columnTitulo: titulo,
      DBSite.columnDescripcion: descripcion,
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

  void update({id, titulo, descripcion, categoria, lon, lat, image}) async {
    Site site = Site(
        id: id,
        categoria: categoria,
        descripcion: descripcion,
        lon: lon,
        lat: lat,
        image: image);
    final rowupdate = await dbSite.updateFavorite(site);
    notifyListeners();
  }
}
