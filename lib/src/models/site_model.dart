//import 'package:walkcity/src/models/index.dart';
import 'package:walkcity/src/services/sqlite_site.dart';

class Site {
  int? id;
  String? categoria;
  String? nombre;
  String? descripcion;
  String? lat;
  String? lon;
  String? imagen;

  Site({
    this.id,
    this.categoria,
    this.nombre,
    this.lat,
    this.lon,
    this.imagen,
    // this.comentarios
  });

  Site.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    categoria = map['id_categoria'].toString();
    nombre = map['nombre'];
    lat = map['lat'];
    lon = map['lon'];
    imagen = map['imagen'];
    // comentarios = map['comentarios'];
  }
  Map<String, dynamic> toMapFavDB() {
    return {
      DBSite.columnId: id,
      DBSite.columnCategoria: categoria,
      DBSite.columnLon: lon,
      DBSite.columnLat: lat,
      DBSite.columnTitulo: nombre,
      DBSite.columnImage: imagen,
    };
  }

  // Site copyWith() => Site(
  //       id: id,
  //       titulo: titulo,
  //       descripcion: descripcion,
  //       lon: lon,
  //       lat: lat,
  //       image: image,
  //       // comentarios: comentarios
  //     );
}
