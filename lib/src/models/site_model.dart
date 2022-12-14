//import 'package:walkcity/src/models/index.dart';
import 'package:walkcity/src/services/db_site.dart';

class Site {
  int? id;
  String? categoria;
  String? titulo;
  String? descripcion;
  String? lat;
  String? lon;
  String? image;
  // List<Comentario>? comentarios = [];
  Site({
    this.id,
    this.categoria,
    this.titulo,
    this.descripcion,
    this.lat,
    this.lon,
    this.image,
    // this.comentarios
  });

  Site.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    categoria = map['categoria'];
    titulo = map['titulo'];
    descripcion = map['descripcion'];
    lat = map['lat'];
    lon = map['lon'];
    image = map['image'];
    // comentarios = map['comentarios'];
  }
  Map<String, dynamic> toMapFavDB() {
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

  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'categoria': categoria,
  //     'descripcion': descripcion,
  //     'lon': lon,
  //     'lat': lat,
  //     'titulo': titulo,
  //     'image': image,
  //     //'comentarios': comentarios,
  //   };
  // }

  Site copyWith() => Site(
        id: id,
        titulo: titulo,
        descripcion: descripcion,
        lon: lon,
        lat: lat,
        image: image,
        // comentarios: comentarios
      );
}
