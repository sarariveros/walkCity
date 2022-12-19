import 'package:walkcity/src/services/db_site.dart';

class Site {
  int? id;
  String? categoria;
  String? titulo;
  String? descripcion;
  double? lat;
  double? lon;
  String? image;
  Site(
      {this.id,
      this.categoria,
      this.titulo,
      this.descripcion,
      this.lat,
      this.lon,
      this.image});

  Site.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    categoria = map['categoria'];
    titulo = map['titulo'];
    descripcion = map['descripcion'];
    lat = map['lat'];
    lon = map['lon'];
    image = map['image'];
  }
  Map<String, dynamic> toMap() {
    return {
      DBSite.columnId: id,
      DBSite.columnCategoria: categoria,
      DBSite.columnDescripcion: descripcion,
      DBSite.columnLon: lon,
      DBSite.columnLat: lat,
      DBSite.columnTitulo: titulo,
      DBSite.columnImage: image,
    };
  }
}
