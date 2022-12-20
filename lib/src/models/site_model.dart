import 'package:walkcity/src/services/sqlite_site.dart';

class Site {
  int? id;
  String? categoria;
  String? nombre;
  String? lat;
  String? lon;

 // double? lat;
  //double? lon;
  
  String? imagen;

  Site({
    this.id,
    this.categoria,
    this.nombre,
    this.lat,
    this.lon,
    this.imagen,
  });


  Site.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    categoria = map['id_categoria'].toString();
    nombre = map['nombre'];
    lat = map['latitud'].toString();
    lon = map['longitud'].toString();
    imagen = map['imagen'];
  }
  Map<String, dynamic> toMapFavDB() {
    return {
      DBSite.columnId: id,
      DBSite.columnCategoria: categoria,
      DBSite.columnLon: lon.toString(),
      DBSite.columnLat: lat.toString(),
      DBSite.columnNombre: nombre,
      DBSite.columnImagen: imagen,
    };
  }
}
