class Site {
  int? id;
  String? id_categoria;
  String? nombre;
  String? linkMap;
  String? descripcion;
  String? imagen;
  String? linkVideo;

  Site(
      {this.id,
      this.id_categoria,
      this.nombre,
      this.linkMap,
      this.descripcion,
      this.imagen,
      this.linkVideo});

  Site.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    id_categoria = map['id_categoria'].toString();
    nombre = map['nombre'];
    linkMap = map['linkMap'].toString();
    descripcion = map['descripcion'].toString();
    imagen = map['imagen'];
    linkVideo = map['linkVideo'];
  }
}
