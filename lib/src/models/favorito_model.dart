class Favorito {
  int? id_site;
  String? usuario;
  int? estado;

  Favorito({
    this.id_site,
    this.usuario,
    this.estado,
  });

  Favorito.fromMap(Map<String, dynamic> map) {
    id_site = map['id_site'];
    usuario = map['usuario'];
    estado = map['estado'];
  }

  Map<String, dynamic> toMap() {
    return {'id_site': id_site, 'usuario': usuario, 'estado': estado};
  }
}
