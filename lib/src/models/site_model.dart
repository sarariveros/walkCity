import 'package:walkcity/src/services/sqlite_site.dart';

class Site {
  int? id;
  String? id_categoria;
  String? nombre;
  String? latitud;
  String? longitud;

  // double? lat;
  //double? lon;

  String? imagen;

  Site({
    this.id,
    this.id_categoria,
    this.nombre,
    this.latitud,
    this.longitud,
    this.imagen,
  });

  Site.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    id_categoria = map['id_categoria'].toString();
    nombre = map['nombre'];
    latitud = map['latitud'].toString();
    longitud = map['longitud'].toString();
    imagen = map['imagen'];
  }
  Map<String, dynamic> toMapFavDB() {
    return {
      DBSite.columnId: id,
      DBSite.columnCategoria: id_categoria.toString(),
      DBSite.columnLon: longitud.toString(),
      DBSite.columnLat: latitud.toString(),
      DBSite.columnNombre: nombre,
      DBSite.columnImagen: imagen,
    };
  }
}
