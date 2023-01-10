import 'dart:convert';

class Festivity {
  int? id;
  String? titulo;
  int? dia;
  int? mes;
  String? imagen;
  String? descripcion;
  Festivity({
    this.id,
    this.titulo,
    this.dia,
    this.mes,
    this.imagen,
    this.descripcion,
  });

  factory Festivity.fromJson(String str) => Festivity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Festivity.fromMap(Map<String, dynamic> json) => Festivity(
        id: json["id"],
        titulo: json["titulo"],
        dia: json["dia"],
        mes: json["mes"],
        imagen: json["imagen"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "titulo": titulo,
        "dia": dia,
        "mes": mes,
        "imagen": imagen,
        "descrpcion": descripcion,
      };
}
